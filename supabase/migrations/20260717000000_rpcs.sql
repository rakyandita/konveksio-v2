-- ========================================================================================
-- Kumpulan RPC dan Trigger untuk Konveksio v2 (Sesuai Audit Fase 4 System Logics)
-- ========================================================================================

-- ----------------------------------------------------------------------------------------
-- 1. UC-001: Create Order Transaction
-- ----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION create_order_transaction(payload jsonb)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
    v_branch_id uuid;
    v_order_id uuid;
    v_item jsonb;
    v_item_id uuid;
    v_size_key text;
    v_size_qty int;
BEGIN
    -- Validasi branch
    v_branch_id := auth_branch_id();
    IF v_branch_id IS NULL THEN
        RAISE EXCEPTION 'Not authorized or no branch context.';
    END IF;

    -- Insert Order
    INSERT INTO orders (branch_id, customer_id, deadline, notes, status)
    VALUES (
        v_branch_id,
        (payload->>'p_customer_id')::uuid,
        (payload->>'p_deadline')::date,
        payload->>'p_notes',
        'draft'
    ) RETURNING id INTO v_order_id;

    -- Loop per item (diasumsikan tidak lebih dari puluhan item, aman tanpa unnest ekstrim)
    FOR v_item IN SELECT * FROM jsonb_array_elements(payload->'p_items')
    LOOP
        INSERT INTO order_items (order_id, product_id, quantity, price)
        VALUES (
            v_order_id,
            (v_item->>'product_id')::uuid,
            (v_item->>'quantity')::int,
            (v_item->>'price')::numeric
        ) RETURNING id INTO v_item_id;

        -- Loop sizes (JSON object to key-value)
        FOR v_size_key, v_size_qty IN SELECT * FROM jsonb_each_text(v_item->'sizes')
        LOOP
            INSERT INTO order_item_sizes (order_item_id, size_label, qty)
            VALUES (v_item_id, v_size_key, v_size_qty::int);
        END LOOP;

        -- Create draft SPK
        INSERT INTO spks (order_item_id) VALUES (v_item_id);
    END LOOP;

    RETURN v_order_id;
END;
$$;

-- ----------------------------------------------------------------------------------------
-- 2. UC-002: Bulk Insert Tasks (Smart Assign)
-- ----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION bulk_insert_tasks(p_tasks jsonb)
RETURNS int
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
    v_branch_id uuid;
    v_task jsonb;
    v_task_id uuid;
    v_size_key text;
    v_size_qty int;
    v_count int := 0;
    v_rate numeric;
BEGIN
    v_branch_id := auth_branch_id();
    
    FOR v_task IN SELECT * FROM jsonb_array_elements(p_tasks)
    LOOP
        -- Ambil rate snapshot dari master data karyawan
        SELECT rate INTO v_rate 
        FROM employee_rates 
        WHERE user_id = (v_task->>'employee_id')::uuid
        LIMIT 1;

        INSERT INTO tasks (order_item_id, assignee_id, ongkos_per_pcs_snapshot, status)
        VALUES (
            (v_task->>'order_item_id')::uuid,
            (v_task->>'employee_id')::uuid,
            COALESCE(v_rate, 0),
            'pending'
        ) RETURNING id INTO v_task_id;

        FOR v_size_key, v_size_qty IN SELECT * FROM jsonb_each_text(v_task->'sizes')
        LOOP
            INSERT INTO task_sizes (task_id, size_label, target_qty, completed_qty)
            VALUES (v_task_id, v_size_key, v_size_qty::int, 0);
        END LOOP;
        
        -- Update order status to running (aman dipanggil berkali-kali)
        UPDATE orders 
        SET status = 'running' 
        WHERE id = (SELECT order_id FROM order_items WHERE id = (v_task->>'order_item_id')::uuid)
        AND status IN ('draft', 'confirmation');

        v_count := v_count + 1;
    END LOOP;

    RETURN v_count;
END;
$$;

-- ----------------------------------------------------------------------------------------
-- 3. UC-003: Handover (Submit & Accept)
-- ----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION submit_handover(payload jsonb)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
    v_handover_id uuid;
    v_size jsonb;
BEGIN
    INSERT INTO handovers (from_task_id, to_user_id, to_vendor_id, status)
    VALUES (
        (payload->>'p_from_task_id')::uuid,
        NULLIF(payload->>'p_to_user_id', '')::uuid,
        NULLIF(payload->>'p_to_vendor_id', '')::uuid,
        'pending'
    ) RETURNING id INTO v_handover_id;

    FOR v_size IN SELECT * FROM jsonb_array_elements(payload->'p_sizes')
    LOOP
        INSERT INTO handover_sizes (handover_id, size_label, qty_sent)
        VALUES (
            v_handover_id,
            v_size->>'size',
            (v_size->>'qty')::int
        );
    END LOOP;

    RETURN v_handover_id;
END;
$$;

CREATE OR REPLACE FUNCTION accept_handover(p_handover_id uuid, p_actual_sizes jsonb)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
    v_handover record;
    v_size jsonb;
    v_task_id uuid;
    v_rate numeric;
    v_order_item_id uuid;
BEGIN
    -- Validasi kepemilikan dan status
    SELECT * INTO v_handover FROM handovers WHERE id = p_handover_id AND status = 'pending';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Handover tidak valid atau sudah diproses.';
    END IF;

    -- Update status handover
    UPDATE handovers SET status = 'accepted' WHERE id = p_handover_id;

    -- Dapatkan order_item_id dari from_task_id
    SELECT order_item_id INTO v_order_item_id FROM tasks WHERE id = v_handover.from_task_id;

    -- Ambil rate snapshot untuk penerima
    SELECT rate INTO v_rate 
    FROM employee_rates 
    WHERE user_id = v_handover.to_user_id
    LIMIT 1;

    -- Auto-Task: Buat task baru untuk penerima
    IF v_handover.to_user_id IS NOT NULL THEN
        INSERT INTO tasks (order_item_id, assignee_id, ongkos_per_pcs_snapshot, status)
        VALUES (v_order_item_id, v_handover.to_user_id, COALESCE(v_rate, 0), 'pending')
        RETURNING id INTO v_task_id;
        
        -- Update received qty dan buat task sizes
        FOR v_size IN SELECT * FROM jsonb_array_elements(p_actual_sizes)
        LOOP
            UPDATE handover_sizes 
            SET qty_received = (v_size->>'qty')::int 
            WHERE handover_id = p_handover_id AND size_label = v_size->>'size';

            INSERT INTO task_sizes (task_id, size_label, target_qty, completed_qty)
            VALUES (v_task_id, v_size->>'size', (v_size->>'qty')::int, 0);
        END LOOP;
    END IF;
END;
$$;

-- ----------------------------------------------------------------------------------------
-- 4. UC-004: Get Kasbon Limit
-- ----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_kasbon_limit(p_user_id uuid)
RETURNS numeric
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
    v_branch_id uuid;
    v_max_percent numeric;
    v_gross_est numeric;
BEGIN
    v_branch_id := auth_branch_id();
    
    SELECT max_kasbon_percentage INTO v_max_percent 
    FROM branch_settings WHERE branch_id = v_branch_id;

    -- Estimasi kotor: sum(qty_completed * ongkos_per_pcs_snapshot)
    SELECT COALESCE(SUM(pl.qty_completed * t.ongkos_per_pcs_snapshot), 0) INTO v_gross_est
    FROM progress_logs pl
    JOIN tasks t ON pl.task_id = t.id
    WHERE pl.user_id = p_user_id
    AND pl.created_at >= (now() - interval '7 days');

    RETURN (v_gross_est * (v_max_percent / 100.0));
END;
$$;

-- ----------------------------------------------------------------------------------------
-- 5. UC-005: Generate Weekly Salary
-- ----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION generate_weekly_salary(p_branch_id uuid, p_period_start date, p_period_end date)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
    v_count int := 0;
    v_total numeric := 0;
BEGIN
    IF auth_user_role() NOT IN ('boss', 'owner') THEN
        RAISE EXCEPTION 'Not authorized';
    END IF;

    -- CTE (Common Table Expression) untuk aggregasi dan insert sekaligus mencegah N+1 loop (Optimasi Performa)
    WITH EmployeeGross AS (
        SELECT pl.user_id, SUM(pl.qty_completed * t.ongkos_per_pcs_snapshot) AS gross
        FROM progress_logs pl
        JOIN tasks t ON pl.task_id = t.id
        WHERE pl.created_at::date BETWEEN p_period_start AND p_period_end
        GROUP BY pl.user_id
    ),
    EmployeeDeduction AS (
        SELECT employee_id, SUM(amount_approved) AS deduction
        FROM cash_advances
        WHERE branch_id = p_branch_id AND status = 'approved'
        GROUP BY employee_id
    ),
    Inserted AS (
        INSERT INTO salary_records (branch_id, user_id, period_end, gross_salary, cash_advance_deduction, net_salary)
        SELECT 
            p_branch_id,
            g.user_id,
            p_period_end,
            g.gross,
            COALESCE(d.deduction, 0),
            GREATEST(g.gross - COALESCE(d.deduction, 0), 0)
        FROM EmployeeGross g
        LEFT JOIN EmployeeDeduction d ON g.user_id = d.employee_id
        RETURNING net_salary
    )
    SELECT count(*), COALESCE(sum(net_salary), 0) INTO v_count, v_total FROM Inserted;
    
    RETURN jsonb_build_object('generated_count', v_count, 'total_amount', v_total);
END;
$$;

-- ----------------------------------------------------------------------------------------
-- 6. UC-006: Trigger Update Task Sizes
-- ----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION trg_update_task_completed_qty()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
    UPDATE task_sizes
    SET completed_qty = completed_qty + NEW.qty_completed
    WHERE task_id = NEW.task_id AND size_label = NEW.size;
    
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trigger_progress_logs_insert ON progress_logs;
CREATE TRIGGER trigger_progress_logs_insert
AFTER INSERT ON progress_logs
FOR EACH ROW
EXECUTE FUNCTION trg_update_task_completed_qty();
