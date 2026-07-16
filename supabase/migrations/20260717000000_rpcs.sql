-- 20260717000000_rpcs.sql

-- ==========================================
-- FUNCTION: create_order_transaction
-- UC-001: Membuat Order beserta Items, Sizes, dan draft SPK secara atomik.
-- ==========================================
CREATE OR REPLACE FUNCTION public.create_order_transaction(
    p_branch_id UUID,
    p_customer_id UUID,
    p_deadline_date TIMESTAMPTZ,
    p_notes TEXT,
    p_items JSONB
) RETURNS UUID AS $$
DECLARE
    v_order_id UUID;
    v_item JSONB;
    v_order_item_id UUID;
    v_size JSONB;
BEGIN
    -- 1. Insert Order
    INSERT INTO public.orders (branch_id, customer_id, deadline_date, notes, status)
    VALUES (p_branch_id, p_customer_id, p_deadline_date, p_notes, 'draft')
    RETURNING id INTO v_order_id;

    -- 2. Loop through items
    FOR v_item IN SELECT * FROM jsonb_array_elements(p_items)
    LOOP
        -- Insert order_item
        INSERT INTO public.order_items (order_id, product_id, price_per_pcs)
        VALUES (v_order_id, (v_item->>'product_id')::UUID, (v_item->>'price_per_pcs')::DECIMAL)
        RETURNING id INTO v_order_item_id;

        -- Create blank SPK for this item
        INSERT INTO public.spks (order_item_id, client_name)
        VALUES (v_order_item_id, v_item->>'client_name');

        -- Loop through sizes
        FOR v_size IN SELECT * FROM jsonb_array_elements(v_item->'sizes')
        LOOP
            INSERT INTO public.order_item_sizes (order_item_id, size, qty)
            VALUES (v_order_item_id, v_size->>'size', (v_size->>'qty')::INTEGER);
        END LOOP;
    END LOOP;

    RETURN v_order_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- ==========================================
-- FUNCTION: bulk_assign_tasks
-- UC-002: Membagikan item order menjadi tasks.
-- ==========================================
CREATE OR REPLACE FUNCTION public.bulk_assign_tasks(
    p_order_item_ids UUID[],
    p_division VARCHAR,
    p_assignee_ids UUID[]
) RETURNS INTEGER AS $$
DECLARE
    v_order_item_id UUID;
    v_assignee_id UUID;
    v_size_row RECORD;
    v_task_id UUID;
    v_total_assignees INTEGER;
    v_base_qty INTEGER;
    v_remainder INTEGER;
    v_assigned_qty INTEGER;
    v_assignee_index INTEGER;
    v_task_count INTEGER := 0;
BEGIN
    v_total_assignees := array_length(p_assignee_ids, 1);
    IF v_total_assignees IS NULL OR v_total_assignees = 0 THEN
        RAISE EXCEPTION 'Assignees cannot be empty';
    END IF;

    FOR i IN 1 .. array_length(p_order_item_ids, 1)
    LOOP
        v_order_item_id := p_order_item_ids[i];
        
        -- Loop setiap assignee
        FOR v_assignee_index IN 1 .. v_total_assignees
        LOOP
            v_assignee_id := p_assignee_ids[v_assignee_index];
            
            -- Buat task baru untuk user ini
            INSERT INTO public.tasks (order_item_id, assigned_to_user, division, status)
            VALUES (v_order_item_id, v_assignee_id, p_division, 'running')
            RETURNING id INTO v_task_id;
            
            v_task_count := v_task_count + 1;
            
            -- Bagi per size
            FOR v_size_row IN SELECT * FROM public.order_item_sizes WHERE order_item_id = v_order_item_id
            LOOP
                v_base_qty := v_size_row.qty / v_total_assignees;
                v_remainder := v_size_row.qty % v_total_assignees;
                
                -- Berikan sisa (remainder) ke orang-orang pertama
                IF v_assignee_index <= v_remainder THEN
                    v_assigned_qty := v_base_qty + 1;
                ELSE
                    v_assigned_qty := v_base_qty;
                END IF;
                
                IF v_assigned_qty > 0 THEN
                    INSERT INTO public.task_sizes (task_id, size, qty)
                    VALUES (v_task_id, v_size_row.size, v_assigned_qty);
                END IF;
            END LOOP;
        END LOOP;

        -- Update order status to running (via the order_item_id)
        UPDATE public.orders 
        SET status = 'running' 
        WHERE id = (SELECT order_id FROM public.order_items WHERE id = v_order_item_id);
    END LOOP;

    RETURN v_task_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- ==========================================
-- FUNCTION: submit_handover
-- UC-003: Kirim Handover
-- ==========================================
CREATE OR REPLACE FUNCTION public.submit_handover(
    p_from_task_id UUID,
    p_to_user_id UUID,
    p_to_vendor_id UUID,
    p_sizes JSONB
) RETURNS UUID AS $$
DECLARE
    v_handover_id UUID;
    v_size JSONB;
BEGIN
    INSERT INTO public.handovers (from_task_id, to_user_id, to_vendor_id, status)
    VALUES (p_from_task_id, p_to_user_id, p_to_vendor_id, 'pending')
    RETURNING id INTO v_handover_id;

    FOR v_size IN SELECT * FROM jsonb_array_elements(p_sizes)
    LOOP
        INSERT INTO public.handover_sizes (handover_id, size, qty_sent)
        VALUES (v_handover_id, v_size->>'size', (v_size->>'qty')::INTEGER);
    END LOOP;

    RETURN v_handover_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- ==========================================
-- FUNCTION: accept_handover
-- UC-003: Terima Handover dan auto-task
-- ==========================================
CREATE OR REPLACE FUNCTION public.accept_handover(
    p_handover_id UUID,
    p_actual_sizes JSONB
) RETURNS UUID AS $$
DECLARE
    v_handover RECORD;
    v_size JSONB;
    v_task_id UUID;
    v_order_item_id UUID;
    v_division VARCHAR;
BEGIN
    SELECT * INTO v_handover FROM public.handovers WHERE id = p_handover_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Handover not found';
    END IF;

    -- Dapatkan order_item_id dari task asal
    SELECT order_item_id INTO v_order_item_id FROM public.tasks WHERE id = v_handover.from_task_id;
    
    -- Sementara set division default ke 'received' (seharusnya dikirim dari UI / param)
    v_division := 'received';

    -- Update Handover Status
    UPDATE public.handovers SET status = 'accepted' WHERE id = p_handover_id;

    -- Update Handover Sizes dgn qty_received
    FOR v_size IN SELECT * FROM jsonb_array_elements(p_actual_sizes)
    LOOP
        UPDATE public.handover_sizes 
        SET qty_received = (v_size->>'qty')::INTEGER
        WHERE handover_id = p_handover_id AND size = v_size->>'size';
    END LOOP;

    -- Create New Task for Receiver
    INSERT INTO public.tasks (order_item_id, assigned_to_user, assigned_to_vendor, division, status)
    VALUES (v_order_item_id, v_handover.to_user_id, v_handover.to_vendor_id, v_division, 'running')
    RETURNING id INTO v_task_id;

    -- Insert into task sizes based on received qty
    FOR v_size IN SELECT * FROM jsonb_array_elements(p_actual_sizes)
    LOOP
        IF (v_size->>'qty')::INTEGER > 0 THEN
            INSERT INTO public.task_sizes (task_id, size, qty)
            VALUES (v_task_id, v_size->>'size', (v_size->>'qty')::INTEGER);
        END IF;
    END LOOP;

    RETURN v_task_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- ==========================================
-- FUNCTION: get_kasbon_limit
-- UC-004
-- ==========================================
CREATE OR REPLACE FUNCTION public.get_kasbon_limit(p_user_id UUID) 
RETURNS DECIMAL AS $$
DECLARE
    v_gross_salary DECIMAL := 0;
    v_max_pct DECIMAL := 0.5;
    v_branch_id UUID;
    v_total_pending_approved DECIMAL := 0;
    v_limit DECIMAL := 0;
BEGIN
    -- 1. Get branch_id for user
    SELECT branch_id INTO v_branch_id FROM public.profiles WHERE id = p_user_id;

    -- 2. Get max percentage
    SELECT max_kasbon_percentage / 100.0 INTO v_max_pct 
    FROM public.branch_settings WHERE branch_id = v_branch_id;
    
    IF v_max_pct IS NULL THEN v_max_pct := 0.5; END IF;

    -- 3. Calculate gross salary from progress_logs for the current period
    -- In production, add date filtering: AND pl.created_at > (last payroll date)
    SELECT COALESCE(SUM(pl.qty_completed * er.rate_per_pcs), 0)
    INTO v_gross_salary
    FROM public.progress_logs pl
    JOIN public.tasks t ON pl.task_id = t.id
    LEFT JOIN public.employee_rates er ON er.user_id = p_user_id AND er.division = t.division
    WHERE pl.user_id = p_user_id;

    -- 4. Calculate total active kasbon (pending + approved but not deducted)
    SELECT COALESCE(SUM(amount_requested), 0)
    INTO v_total_pending_approved
    FROM public.cash_advances
    WHERE user_id = p_user_id AND is_deducted = false AND status IN ('pending', 'approved');

    v_limit := (v_gross_salary * v_max_pct) - v_total_pending_approved;
    
    IF v_limit < 0 THEN
        v_limit := 0;
    END IF;

    RETURN v_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- ==========================================
-- FUNCTION: generate_weekly_salary
-- UC-005
-- ==========================================
CREATE OR REPLACE FUNCTION public.generate_weekly_salary(
    p_branch_id UUID,
    p_period_end DATE
) RETURNS JSONB AS $$
DECLARE
    v_user RECORD;
    v_gross DECIMAL;
    v_kasbon_deduct DECIMAL;
    v_net DECIMAL;
    v_count INTEGER := 0;
    v_total_amount DECIMAL := 0;
BEGIN
    -- Loop active employees in branch
    FOR v_user IN SELECT id FROM public.profiles WHERE branch_id = p_branch_id AND role = 'employee'
    LOOP
        -- Gross: sum progress logs
        SELECT COALESCE(SUM(pl.qty_completed * er.rate_per_pcs), 0)
        INTO v_gross
        FROM public.progress_logs pl
        JOIN public.tasks t ON pl.task_id = t.id
        LEFT JOIN public.employee_rates er ON er.user_id = v_user.id AND er.division = t.division
        WHERE pl.user_id = v_user.id;

        -- Get total un-deducted approved cash advances
        SELECT COALESCE(SUM(amount_approved), 0)
        INTO v_kasbon_deduct
        FROM public.cash_advances
        WHERE user_id = v_user.id AND status = 'approved' AND is_deducted = false;

        v_net := v_gross - v_kasbon_deduct;

        IF v_gross > 0 THEN
            INSERT INTO public.salary_records (branch_id, user_id, period_end, gross_salary, cash_advance_deduction, net_salary)
            VALUES (p_branch_id, v_user.id, p_period_end, v_gross, v_kasbon_deduct, v_net);

            -- Mark cash advances as deducted
            UPDATE public.cash_advances
            SET is_deducted = true
            WHERE user_id = v_user.id AND status = 'approved' AND is_deducted = false;

            v_count := v_count + 1;
            v_total_amount := v_total_amount + v_net;
        END IF;
    END LOOP;

    RETURN jsonb_build_object('generated_count', v_count, 'total_amount', v_total_amount);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
