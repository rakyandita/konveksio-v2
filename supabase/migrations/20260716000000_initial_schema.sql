-- ==========================================
-- SOT #3: DATABASE SCHEMA & RLS POLICIES (HARDENED v2)
-- Project: Konveksio V2
-- Audit: 9-Skill | Applied: 16 fixes
-- Updated: 2026-07-16
-- ==========================================

-- ==========================================
-- SECTION 1: EXTENSIONS & ENUMS
-- ==========================================

CREATE EXTENSION IF NOT EXISTS moddatetime SCHEMA extensions;

-- [FIX-N2] Semua enum menggunakan Bahasa Inggris (backend/data layer standard).
-- UI/Frontend bertanggung jawab untuk translasi ke Bahasa Indonesia via i18n.
CREATE TYPE user_role       AS ENUM ('owner', 'boss', 'admin', 'employee');
CREATE TYPE product_category AS ENUM ('setelan', 'non-setelan');

-- [FIX-N2] order_status: diganti dari Bahasa Indonesia ke Bahasa Inggris.
-- Mapping: konfirmasi→confirmation, produksi_berjalan→running, produksi_selesai→completed, batal→cancelled
CREATE TYPE order_status    AS ENUM ('draft', 'confirmation', 'running', 'completed', 'shipped', 'done', 'cancelled');

-- [FIX-N2] task_status: diganti dari Bahasa Indonesia ke Bahasa Inggris.
-- Mapping: berjalan→running, selesai→completed
CREATE TYPE task_status     AS ENUM ('running', 'completed');

-- handover_status & approval_status sudah Bahasa Inggris, tidak berubah.
CREATE TYPE handover_status AS ENUM ('pending', 'accepted', 'rejected');
CREATE TYPE approval_status AS ENUM ('pending', 'approved', 'rejected');


-- ==========================================
-- SECTION 2: TENANT & AUTHENTICATION
-- ==========================================

CREATE TABLE public.branches (
    id         UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    name       VARCHAR(255) NOT NULL,
    address    TEXT,
    phone      VARCHAR(50),
    is_active  BOOLEAN      DEFAULT true,
    created_at TIMESTAMPTZ  DEFAULT now(),
    updated_at TIMESTAMPTZ  DEFAULT now()
);

CREATE TABLE public.profiles (
    id         UUID         PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    branch_id  UUID         REFERENCES public.branches(id) ON DELETE RESTRICT,
    role       user_role    NOT NULL,
    name       VARCHAR(255) NOT NULL,
    is_active  BOOLEAN      DEFAULT true,
    created_at TIMESTAMPTZ  DEFAULT now(),
    updated_at TIMESTAMPTZ  DEFAULT now()
);

CREATE TABLE public.admin_permissions (
    user_id              UUID     PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
    can_manage_orders    BOOLEAN  DEFAULT false,
    can_manage_production BOOLEAN DEFAULT false,
    can_view_reports     BOOLEAN  DEFAULT false,
    updated_at           TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.branch_settings (
    branch_id             UUID         PRIMARY KEY REFERENCES public.branches(id) ON DELETE CASCADE,
    invoice_logo_url      TEXT,
    invoice_bank_info     TEXT,
    official_whatsapp     VARCHAR(50),
    payment_system        VARCHAR(50)  DEFAULT 'borongan_per_pcs' CHECK (payment_system IN ('borongan_per_pcs', 'vendor_lump_sum')),
    max_kasbon_percentage INTEGER      DEFAULT 50 CHECK (max_kasbon_percentage >= 0 AND max_kasbon_percentage <= 100),
    updated_at            TIMESTAMPTZ  DEFAULT now()
);


-- ==========================================
-- SECTION 3: MASTER DATA
-- ==========================================

-- [FIX-M1] Tambah created_at ke tabel yang sebelumnya missing.
CREATE TABLE public.size_groups (
    id         UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id  UUID         NOT NULL REFERENCES public.branches(id) ON DELETE RESTRICT,
    name       VARCHAR(100) NOT NULL,
    sizes      JSONB        NOT NULL,
    created_at TIMESTAMPTZ  DEFAULT now(),
    updated_at TIMESTAMPTZ  DEFAULT now()
);

-- [FIX-M1] Tambah created_at.
CREATE TABLE public.products (
    id             UUID             PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id      UUID             NOT NULL REFERENCES public.branches(id) ON DELETE RESTRICT,
    name           VARCHAR(255)     NOT NULL,
    category       product_category NOT NULL,
    size_group_id  UUID             NOT NULL REFERENCES public.size_groups(id) ON DELETE RESTRICT,
    price_min      DECIMAL(12,2)    NOT NULL,
    price_max      DECIMAL(12,2)    NOT NULL,
    is_active      BOOLEAN          DEFAULT true,
    created_at     TIMESTAMPTZ      DEFAULT now(),
    updated_at     TIMESTAMPTZ      DEFAULT now()
);

-- [FIX-M1] Tambah created_at.
CREATE TABLE public.vendors (
    id         UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id  UUID         NOT NULL REFERENCES public.branches(id) ON DELETE RESTRICT,
    name       VARCHAR(255) NOT NULL,
    division   VARCHAR(100) NOT NULL,
    phone      VARCHAR(50),
    notes      TEXT,
    is_active  BOOLEAN      DEFAULT true,
    created_at TIMESTAMPTZ  DEFAULT now(),
    updated_at TIMESTAMPTZ  DEFAULT now()
);

-- [FIX-M1] Tambah created_at.
-- [FIX-M3] Tambah UNIQUE(user_id, division) untuk mencegah duplikat rate.
CREATE TABLE public.employee_rates (
    id           UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id      UUID          NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    division     VARCHAR(100)  NOT NULL,
    rate_per_pcs DECIMAL(10,2) NOT NULL,
    created_at   TIMESTAMPTZ   DEFAULT now(),
    updated_at   TIMESTAMPTZ   DEFAULT now(),
    CONSTRAINT uq_employee_rate UNIQUE (user_id, division)
);


-- ==========================================
-- SECTION 4: TRANSAKSIONAL
-- ==========================================

-- [FIX-M1] Tambah created_at.
CREATE TABLE public.customers (
    id         UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id  UUID         NOT NULL REFERENCES public.branches(id) ON DELETE RESTRICT,
    name       VARCHAR(255) NOT NULL,
    phone      VARCHAR(50),
    address    TEXT,
    notes      TEXT,
    is_active  BOOLEAN      DEFAULT true,
    created_at TIMESTAMPTZ  DEFAULT now(),
    updated_at TIMESTAMPTZ  DEFAULT now()
);

CREATE TABLE public.orders (
    id           UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id    UUID         NOT NULL REFERENCES public.branches(id) ON DELETE RESTRICT,
    customer_id  UUID         NOT NULL REFERENCES public.customers(id) ON DELETE RESTRICT,
    status       order_status NOT NULL DEFAULT 'draft',
    deadline_date TIMESTAMPTZ,
    total_price  DECIMAL(15,2) DEFAULT 0,
    notes        TEXT,
    is_active    BOOLEAN      DEFAULT true,
    created_at   TIMESTAMPTZ  DEFAULT now(),
    updated_at   TIMESTAMPTZ  DEFAULT now()
);

-- [FIX-M1] Tambah created_at.
CREATE TABLE public.order_items (
    id            UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id      UUID          NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
    product_id    UUID          NOT NULL REFERENCES public.products(id) ON DELETE RESTRICT,
    price_per_pcs DECIMAL(12,2) NOT NULL,
    created_at    TIMESTAMPTZ   DEFAULT now()
);

-- [FIX-M1] Tambah created_at.
CREATE TABLE public.order_item_sizes (
    id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    order_item_id UUID        NOT NULL REFERENCES public.order_items(id) ON DELETE CASCADE,
    size          VARCHAR(20) NOT NULL,
    qty           INTEGER     NOT NULL CHECK (qty > 0),
    created_at    TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.spks (
    id              UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    order_item_id   UUID         NOT NULL UNIQUE REFERENCES public.order_items(id) ON DELETE CASCADE,
    client_name     VARCHAR(255),
    material        VARCHAR(255),
    color           VARCHAR(100),
    style           VARCHAR(255),
    notes           TEXT,
    front_image_url TEXT,
    back_image_url  TEXT,
    updated_at      TIMESTAMPTZ  DEFAULT now()
);

-- Tabel payments: APPEND-ONLY (audit trail keuangan). Tidak ada updated_at.
CREATE TABLE public.payments (
    id           UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id     UUID          NOT NULL REFERENCES public.orders(id) ON DELETE RESTRICT,
    amount       DECIMAL(15,2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMPTZ   DEFAULT now(),
    notes        TEXT,
    created_at   TIMESTAMPTZ   DEFAULT now()
);


-- ==========================================
-- SECTION 5: TRACKING PRODUKSI
-- ==========================================

CREATE TABLE public.tasks (
    id                      UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    order_item_id           UUID          NOT NULL REFERENCES public.order_items(id) ON DELETE CASCADE,
    assigned_to_user        UUID          REFERENCES public.profiles(id) ON DELETE RESTRICT,
    assigned_to_vendor      UUID          REFERENCES public.vendors(id) ON DELETE RESTRICT,
    division                VARCHAR(100)  NOT NULL,
    status                  task_status   NOT NULL DEFAULT 'running',
    ongkos_per_pcs_snapshot DECIMAL(10,2) NOT NULL,
    created_at              TIMESTAMPTZ   DEFAULT now(),
    updated_at              TIMESTAMPTZ   DEFAULT now(),
    CHECK (
        (assigned_to_user IS NOT NULL AND assigned_to_vendor IS NULL) OR
        (assigned_to_user IS NULL AND assigned_to_vendor IS NOT NULL) OR
        (assigned_to_user IS NULL AND assigned_to_vendor IS NULL)
    )
);

-- [FIX-M4] Tambah UNIQUE(task_id, size) untuk mencegah duplikat per ukuran.
CREATE TABLE public.task_sizes (
    id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    task_id       UUID        NOT NULL REFERENCES public.tasks(id) ON DELETE CASCADE,
    size          VARCHAR(20) NOT NULL,
    target_qty    INTEGER     NOT NULL CHECK (target_qty >= 0),
    completed_qty INTEGER     NOT NULL DEFAULT 0 CHECK (completed_qty >= 0),
    CONSTRAINT uq_task_size UNIQUE (task_id, size)
);

-- Tabel progress_logs: APPEND-ONLY (audit trail produksi).
-- [FIX-M5] qty_completed harus positif (> 0).
CREATE TABLE public.progress_logs (
    id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    task_id       UUID        NOT NULL REFERENCES public.tasks(id) ON DELETE RESTRICT,
    user_id       UUID        REFERENCES public.profiles(id) ON DELETE RESTRICT,
    size          VARCHAR(20) NOT NULL,
    qty_completed INTEGER     NOT NULL CHECK (qty_completed > 0),
    created_at    TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE public.handovers (
    id               UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
    from_task_id     UUID            NOT NULL REFERENCES public.tasks(id) ON DELETE RESTRICT,
    to_user_id       UUID            REFERENCES public.profiles(id) ON DELETE RESTRICT,
    to_vendor_id     UUID            REFERENCES public.vendors(id) ON DELETE RESTRICT,
    status           handover_status NOT NULL DEFAULT 'pending',
    rejection_reason TEXT,
    created_at       TIMESTAMPTZ     DEFAULT now(),
    updated_at       TIMESTAMPTZ     DEFAULT now(),
    CHECK (
        (to_user_id IS NOT NULL AND to_vendor_id IS NULL) OR
        (to_user_id IS NULL AND to_vendor_id IS NOT NULL)
    )
);

CREATE TABLE public.handover_sizes (
    id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    handover_id  UUID        NOT NULL REFERENCES public.handovers(id) ON DELETE CASCADE,
    size         VARCHAR(20) NOT NULL,
    qty_sent     INTEGER     NOT NULL CHECK (qty_sent > 0),
    qty_received INTEGER
);


-- ==========================================
-- SECTION 6: KEUANGAN & SDM
-- ==========================================

-- [FIX-M2] Denormalisasi branch_id ke cash_advances untuk isolasi tenant langsung.
CREATE TABLE public.cash_advances (
    id               UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id        UUID          NOT NULL REFERENCES public.branches(id) ON DELETE RESTRICT,
    user_id          UUID          NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    amount_requested DECIMAL(12,2) NOT NULL CHECK (amount_requested > 0),
    amount_approved  DECIMAL(12,2),
    reason           TEXT          NOT NULL,
    status           approval_status NOT NULL DEFAULT 'pending',
    created_at       TIMESTAMPTZ   DEFAULT now(),
    updated_at       TIMESTAMPTZ   DEFAULT now()
);

-- [FIX-M2] Denormalisasi branch_id ke salary_records. APPEND-ONLY.
-- Tidak ada updated_at karena gaji yang sudah dibayar tidak boleh diubah.
CREATE TABLE public.salary_records (
    id                   UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
    branch_id            UUID          NOT NULL REFERENCES public.branches(id) ON DELETE RESTRICT,
    user_id              UUID          NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    period_end           DATE          NOT NULL,
    gross_salary         DECIMAL(15,2) NOT NULL,
    cash_advance_deduction DECIMAL(15,2) NOT NULL DEFAULT 0,
    net_salary           DECIMAL(15,2) NOT NULL,
    created_at           TIMESTAMPTZ   DEFAULT now()
);


-- ==========================================
-- SECTION 7: NOTIFIKASI
-- ==========================================

CREATE TABLE public.notifications (
    id                UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id           UUID         NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    title             VARCHAR(255) NOT NULL,
    body              TEXT         NOT NULL,
    type              VARCHAR(50),
    related_entity_id UUID,
    is_read           BOOLEAN      DEFAULT false,
    created_at        TIMESTAMPTZ  DEFAULT now(),
    updated_at        TIMESTAMPTZ  DEFAULT now()
);


-- ==========================================
-- SECTION 8: TRIGGERS updated_at
-- [FIX-C2] Ganti EXECUTE PROCEDURE → EXECUTE FUNCTION (non-deprecated).
--           Tambah schema qualifier extensions.moddatetime.
-- ==========================================

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.branches
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime (updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.branch_settings
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime (updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.admin_permissions
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.size_groups
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.products
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.vendors
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.employee_rates
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.customers
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.orders
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.spks
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.tasks
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.handovers
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.cash_advances
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.notifications
    FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime(updated_at);


-- ==========================================
-- SECTION 9: INDEXES (B-Tree)
-- ==========================================

-- Tenant isolation indexes
CREATE INDEX idx_profiles_branch       ON public.profiles(branch_id);
CREATE INDEX idx_size_groups_branch    ON public.size_groups(branch_id);
CREATE INDEX idx_products_branch       ON public.products(branch_id);
CREATE INDEX idx_vendors_branch        ON public.vendors(branch_id);
CREATE INDEX idx_customers_branch      ON public.customers(branch_id);
CREATE INDEX idx_orders_branch         ON public.orders(branch_id);

-- Relational FK indexes
CREATE INDEX idx_admin_permissions_user ON public.admin_permissions(user_id);
CREATE INDEX idx_employee_rates_user    ON public.employee_rates(user_id);
CREATE INDEX idx_orders_customer        ON public.orders(customer_id);
CREATE INDEX idx_order_items_order      ON public.order_items(order_id);
CREATE INDEX idx_order_items_product    ON public.order_items(product_id);
CREATE INDEX idx_order_item_sizes_item  ON public.order_item_sizes(order_item_id);
CREATE INDEX idx_spks_order_item        ON public.spks(order_item_id);
CREATE INDEX idx_payments_order         ON public.payments(order_id);
CREATE INDEX idx_tasks_order_item       ON public.tasks(order_item_id);
CREATE INDEX idx_tasks_user             ON public.tasks(assigned_to_user);
CREATE INDEX idx_tasks_vendor           ON public.tasks(assigned_to_vendor);
CREATE INDEX idx_task_sizes_task        ON public.task_sizes(task_id);
CREATE INDEX idx_progress_logs_task     ON public.progress_logs(task_id);
CREATE INDEX idx_progress_logs_user     ON public.progress_logs(user_id);
CREATE INDEX idx_handovers_from_task    ON public.handovers(from_task_id);
CREATE INDEX idx_handovers_to_user      ON public.handovers(to_user_id);
CREATE INDEX idx_handovers_to_vendor    ON public.handovers(to_vendor_id);
CREATE INDEX idx_handover_sizes_handover ON public.handover_sizes(handover_id);

-- Financial tables: branch isolation + user
CREATE INDEX idx_cash_advances_branch  ON public.cash_advances(branch_id);
CREATE INDEX idx_cash_advances_user    ON public.cash_advances(user_id);
CREATE INDEX idx_salary_records_branch ON public.salary_records(branch_id);
CREATE INDEX idx_salary_records_user   ON public.salary_records(user_id);

CREATE INDEX idx_notifications_user    ON public.notifications(user_id);
-- Composite index untuk membaca notifikasi yang belum dibaca
CREATE INDEX idx_notifications_user_unread ON public.notifications(user_id, is_read) WHERE is_read = false;


-- ==========================================
-- SECTION 10: SUPABASE REALTIME
-- ==========================================

ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications, public.orders, public.tasks;


-- ==========================================
-- SECTION 11: ROW LEVEL SECURITY (RLS)
-- ==========================================

ALTER TABLE public.branches         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.branch_settings  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admin_permissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.size_groups      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vendors          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.employee_rates   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_item_sizes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.spks             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks            ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.task_sizes       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.progress_logs    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.handovers        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.handover_sizes   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cash_advances    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.salary_records   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications    ENABLE ROW LEVEL SECURITY;


-- ==========================================
-- SECTION 12: HELPER FUNCTIONS (SECURITY DEFINER)
-- Mencegah Infinite Recursion pada RLS.
-- ==========================================

-- Helper: mendapatkan role user saat ini dari tabel profiles.
-- SECURITY DEFINER memastikan query berjalan sebagai pemilik fungsi (bypass RLS tabel profiles),
-- sehingga tidak ada infinite recursion saat profiles memiliki RLS aktif.
CREATE OR REPLACE FUNCTION public.auth_user_role()
RETURNS user_role
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$;

-- Helper: mendapatkan branch_id efektif user saat ini.
-- [FIX-C1] Tambahkan SELECT di depan COALESCE (wajib untuk LANGUAGE sql).
-- Prioritas: acting_branch_id dari JWT app_metadata (untuk Owner yang act-as branch),
-- fallback ke branch_id dari tabel profiles.
CREATE OR REPLACE FUNCTION public.auth_branch_id()
RETURNS UUID
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public
AS $$
  SELECT COALESCE(
    (auth.jwt() -> 'app_metadata' ->> 'acting_branch_id')::uuid,
    (SELECT branch_id FROM public.profiles WHERE id = auth.uid())
  );
$$;


-- ==========================================
-- SECTION 13: RLS POLICIES
--
-- Prinsip utama:
-- [FIX-H1] Semua fungsi helper di-wrap (select func()) untuk caching initPlan PostgreSQL.
--           Ini mencegah pemanggilan fungsi per-row, meningkatkan performa hingga 100x.
-- [FIX-H5] Semua policy menggunakan TO authenticated untuk menutup akses dari role anon.
-- [FIX-C3] Semua FOR ALL dipecah menjadi policy per-operasi dengan RBAC guard.
-- ==========================================


-- ---- A. BRANCHES ----
-- Owner bisa akses semua branch. User lain hanya SELECT branch mereka sendiri.

CREATE POLICY "branches_select" ON public.branches
    FOR SELECT TO authenticated
    USING (true); -- Branch info non-confidential, tapi sudah tertutup untuk anon.

CREATE POLICY "branches_insert" ON public.branches
    FOR INSERT TO authenticated
    WITH CHECK ((select public.auth_user_role()) = 'owner');

CREATE POLICY "branches_update" ON public.branches
    FOR UPDATE TO authenticated
    USING ((select public.auth_user_role()) = 'owner')
    WITH CHECK ((select public.auth_user_role()) = 'owner');

-- Branches tidak bisa di-DELETE (data integritas).


-- ---- A.1 BRANCH SETTINGS ----
CREATE POLICY "branch_settings_select" ON public.branch_settings
    FOR SELECT TO authenticated
    USING (
        branch_id = (select public.auth_branch_id())
        OR (select public.auth_user_role()) = 'owner'
    );

CREATE POLICY "branch_settings_update" ON public.branch_settings
    FOR UPDATE TO authenticated
    USING (
        ((select public.auth_user_role()) = 'owner') OR
        (branch_id = (select public.auth_branch_id()) AND (select public.auth_user_role()) = 'boss')
    )
    WITH CHECK (
        ((select public.auth_user_role()) = 'owner') OR
        (branch_id = (select public.auth_branch_id()) AND (select public.auth_user_role()) = 'boss')
    );


-- ---- B. PROFILES ----
-- [FIX-H2] INSERT dibatasi untuk owner/boss saja (tidak boleh self-register).

CREATE POLICY "profiles_select" ON public.profiles
    FOR SELECT TO authenticated
    USING (
        (branch_id = (select public.auth_branch_id()))
        OR (select public.auth_user_role()) = 'owner'
        OR id = (select auth.uid()) -- user bisa lihat profil sendiri
    );

CREATE POLICY "profiles_insert" ON public.profiles
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (
            branch_id = (select public.auth_branch_id())
            OR (select public.auth_user_role()) = 'owner'
        )
    );

CREATE POLICY "profiles_update" ON public.profiles
    FOR UPDATE TO authenticated
    USING (
        (branch_id = (select public.auth_branch_id()) AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin'))
        OR id = (select auth.uid()) -- user bisa update profil sendiri
        OR (select public.auth_user_role()) = 'owner'
    )
    WITH CHECK (
        (branch_id = (select public.auth_branch_id()) AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin'))
        OR id = (select auth.uid())
        OR (select public.auth_user_role()) = 'owner'
    );

-- Profile tidak boleh di-DELETE langsung (CASCADE dari auth.users).


-- ---- C. ADMIN PERMISSIONS ----

CREATE POLICY "admin_permissions_select" ON public.admin_permissions
    FOR SELECT TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.profiles p
            WHERE p.id = admin_permissions.user_id
            AND (p.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "admin_permissions_insert" ON public.admin_permissions
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND EXISTS (
            SELECT 1 FROM public.profiles p
            WHERE p.id = admin_permissions.user_id
            AND (p.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "admin_permissions_update" ON public.admin_permissions
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND EXISTS (
            SELECT 1 FROM public.profiles p
            WHERE p.id = admin_permissions.user_id
            AND (p.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );


-- ---- D. MASTER DATA (Size Groups, Products, Vendors, Employee Rates) ----
-- Hanya owner/boss/admin yang bisa INSERT/UPDATE/DELETE.
-- Semua user dalam branch bisa SELECT (karyawan perlu lihat produk/vendor).

-- Size Groups
CREATE POLICY "size_groups_select" ON public.size_groups
    FOR SELECT TO authenticated
    USING (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner');

CREATE POLICY "size_groups_insert" ON public.size_groups
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "size_groups_update" ON public.size_groups
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "size_groups_delete" ON public.size_groups
    FOR DELETE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

-- Products
CREATE POLICY "products_select" ON public.products
    FOR SELECT TO authenticated
    USING (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner');

CREATE POLICY "products_insert" ON public.products
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "products_update" ON public.products
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "products_delete" ON public.products
    FOR DELETE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

-- Vendors
CREATE POLICY "vendors_select" ON public.vendors
    FOR SELECT TO authenticated
    USING (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner');

CREATE POLICY "vendors_insert" ON public.vendors
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "vendors_update" ON public.vendors
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "vendors_delete" ON public.vendors
    FOR DELETE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

-- Employee Rates (via JOIN ke profiles untuk branch check)
CREATE POLICY "employee_rates_select" ON public.employee_rates
    FOR SELECT TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.profiles p
            WHERE p.id = employee_rates.user_id
            AND (p.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "employee_rates_insert" ON public.employee_rates
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.profiles p
            WHERE p.id = employee_rates.user_id
            AND (p.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "employee_rates_update" ON public.employee_rates
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.profiles p
            WHERE p.id = employee_rates.user_id
            AND (p.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "employee_rates_delete" ON public.employee_rates
    FOR DELETE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND EXISTS (
            SELECT 1 FROM public.profiles p
            WHERE p.id = employee_rates.user_id
            AND (p.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );


-- ---- E. CUSTOMERS ----
-- Karyawan tidak boleh CRUD customer (SRS RBAC matrix).

CREATE POLICY "customers_select" ON public.customers
    FOR SELECT TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "customers_insert" ON public.customers
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "customers_update" ON public.customers
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "customers_delete" ON public.customers
    FOR DELETE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );


-- ---- F. ORDERS ----
-- [FIX-C3] DELETE dibatasi: hanya owner/boss, dan hanya untuk status draft/cancelled.
-- Karyawan tidak boleh akses orders sama sekali.

CREATE POLICY "orders_select" ON public.orders
    FOR SELECT TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "orders_insert" ON public.orders
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

CREATE POLICY "orders_update" ON public.orders
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    )
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );

-- [FIX-C3] Hard Delete hanya untuk status draft atau cancelled (SRS BR-06.2).
CREATE POLICY "orders_delete" ON public.orders
    FOR DELETE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        AND status IN ('draft', 'cancelled')
    );


-- ---- G. ORDER ITEMS & ORDER ITEM SIZES (Cascading dari Orders) ----

CREATE POLICY "order_items_select" ON public.order_items
    FOR SELECT TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.orders o
            WHERE o.id = order_items.order_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "order_items_insert" ON public.order_items
    FOR INSERT TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.orders o
            WHERE o.id = order_items.order_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "order_items_update" ON public.order_items
    FOR UPDATE TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.orders o
            WHERE o.id = order_items.order_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "order_items_delete" ON public.order_items
    FOR DELETE TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.orders o
            WHERE o.id = order_items.order_id
            AND (select public.auth_user_role()) IN ('owner', 'boss')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

-- Order Item Sizes (mengikuti policy order_items)
CREATE POLICY "order_item_sizes_select" ON public.order_item_sizes
    FOR SELECT TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = order_item_sizes.order_item_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "order_item_sizes_insert" ON public.order_item_sizes
    FOR INSERT TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = order_item_sizes.order_item_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "order_item_sizes_update" ON public.order_item_sizes
    FOR UPDATE TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = order_item_sizes.order_item_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "order_item_sizes_delete" ON public.order_item_sizes
    FOR DELETE TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = order_item_sizes.order_item_id
            AND (select public.auth_user_role()) IN ('owner', 'boss')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );


-- ---- H. SPKs (Cascading dari Orders) ----

CREATE POLICY "spks_select" ON public.spks
    FOR SELECT TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = spks.order_item_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "spks_insert" ON public.spks
    FOR INSERT TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = spks.order_item_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "spks_update" ON public.spks
    FOR UPDATE TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = spks.order_item_id
            AND (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );


-- ---- I. TASKS ----
-- [FIX-H3] Tambah branch isolation via cascading ke orders untuk owner/boss/admin.
-- Karyawan hanya bisa lihat task yang di-assign ke mereka.

CREATE POLICY "tasks_select" ON public.tasks
    FOR SELECT TO authenticated
    USING (
        assigned_to_user = (select auth.uid())
        OR (
            (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND EXISTS (
                SELECT 1 FROM public.order_items oi
                JOIN public.orders o ON o.id = oi.order_id
                WHERE oi.id = tasks.order_item_id
                AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
            )
        )
    );

CREATE POLICY "tasks_insert" ON public.tasks
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = tasks.order_item_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "tasks_update" ON public.tasks
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = tasks.order_item_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "tasks_delete" ON public.tasks
    FOR DELETE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND EXISTS (
            SELECT 1 FROM public.order_items oi
            JOIN public.orders o ON o.id = oi.order_id
            WHERE oi.id = tasks.order_item_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );


-- ---- J. TASK SIZES ----
-- [FIX-H3] Tambah cascading branch isolation.

CREATE POLICY "task_sizes_select" ON public.task_sizes
    FOR SELECT TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.tasks t
            JOIN public.order_items oi ON oi.id = t.order_item_id
            JOIN public.orders o ON o.id = oi.order_id
            WHERE t.id = task_sizes.task_id
            AND (
                t.assigned_to_user = (select auth.uid())
                OR (
                    (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
                    AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
                )
            )
        )
    );

CREATE POLICY "task_sizes_insert" ON public.task_sizes
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.tasks t
            JOIN public.order_items oi ON oi.id = t.order_item_id
            JOIN public.orders o ON o.id = oi.order_id
            WHERE t.id = task_sizes.task_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "task_sizes_update" ON public.task_sizes
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.tasks t
            JOIN public.order_items oi ON oi.id = t.order_item_id
            JOIN public.orders o ON o.id = oi.order_id
            WHERE t.id = task_sizes.task_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );


-- ---- K. PROGRESS LOGS (APPEND-ONLY) ----
-- INSERT: karyawan bisa untuk task mereka sendiri, atau manager.
-- Tidak ada UPDATE/DELETE (audit trail).

CREATE POLICY "progress_logs_select" ON public.progress_logs
    FOR SELECT TO authenticated
    USING (
        user_id = (select auth.uid())
        OR (
            (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND EXISTS (
                SELECT 1 FROM public.tasks t
                JOIN public.order_items oi ON oi.id = t.order_item_id
                JOIN public.orders o ON o.id = oi.order_id
                WHERE t.id = progress_logs.task_id
                AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
            )
        )
    );

CREATE POLICY "progress_logs_insert" ON public.progress_logs
    FOR INSERT TO authenticated
    WITH CHECK (
        user_id = (select auth.uid())
        AND EXISTS (
            SELECT 1 FROM public.tasks t
            WHERE t.id = progress_logs.task_id
            AND (
                t.assigned_to_user = (select auth.uid())
                OR (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            )
        )
    );


-- ---- L. HANDOVERS ----
-- [FIX-H3] Tambah cascading branch isolation.
-- [FIX-N1] Ganti LEFT JOIN → JOIN (from_task_id NOT NULL).

CREATE POLICY "handovers_select" ON public.handovers
    FOR SELECT TO authenticated
    USING (
        to_user_id = (select auth.uid())
        OR EXISTS (SELECT 1 FROM public.tasks t WHERE t.id = handovers.from_task_id AND t.assigned_to_user = (select auth.uid()))
        OR (
            (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND EXISTS (
                SELECT 1 FROM public.tasks t
                JOIN public.order_items oi ON oi.id = t.order_item_id
                JOIN public.orders o ON o.id = oi.order_id
                WHERE t.id = handovers.from_task_id
                AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
            )
        )
    );

CREATE POLICY "handovers_insert" ON public.handovers
    FOR INSERT TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.tasks t
            WHERE t.id = handovers.from_task_id
            AND (
                t.assigned_to_user = (select auth.uid())
                OR (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            )
        )
    );

CREATE POLICY "handovers_update" ON public.handovers
    FOR UPDATE TO authenticated
    USING (
        to_user_id = (select auth.uid()) -- penerima bisa update status (accept/reject)
        OR (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
    )
    WITH CHECK (
        to_user_id = (select auth.uid())
        OR (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
    );


-- ---- M. HANDOVER SIZES ----
-- [FIX-N1] Ganti LEFT JOIN → JOIN (from_task_id NOT NULL).
-- [FIX-H3] Cascading branch isolation.

CREATE POLICY "handover_sizes_select" ON public.handover_sizes
    FOR SELECT TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.handovers h
            JOIN public.tasks t ON t.id = h.from_task_id
            WHERE h.id = handover_sizes.handover_id
            AND (
                h.to_user_id = (select auth.uid())
                OR t.assigned_to_user = (select auth.uid())
                OR (
                    (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
                    AND EXISTS (
                        SELECT 1 FROM public.order_items oi
                        JOIN public.orders o ON o.id = oi.order_id
                        WHERE oi.id = t.order_item_id
                        AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
                    )
                )
            )
        )
    );

CREATE POLICY "handover_sizes_insert" ON public.handover_sizes
    FOR INSERT TO authenticated
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.handovers h
            JOIN public.tasks t ON t.id = h.from_task_id
            WHERE h.id = handover_sizes.handover_id
            AND (
                t.assigned_to_user = (select auth.uid())
                OR (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            )
        )
    );

CREATE POLICY "handover_sizes_update" ON public.handover_sizes
    FOR UPDATE TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.handovers h
            WHERE h.id = handover_sizes.handover_id
            AND (
                h.to_user_id = (select auth.uid())
                OR (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            )
        )
    );


-- ---- N. PAYMENTS (APPEND-ONLY) ----

CREATE POLICY "payments_select" ON public.payments
    FOR SELECT TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.orders o
            WHERE o.id = payments.order_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "payments_insert" ON public.payments
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
        AND EXISTS (
            SELECT 1 FROM public.orders o
            WHERE o.id = payments.order_id
            AND (o.branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );


-- ---- O. CASH ADVANCES ----
-- [FIX-H4] UPDATE hanya untuk owner/boss (tidak boleh self-approve).
-- [FIX-M2] Branch isolation langsung via branch_id kolom.

CREATE POLICY "cash_advances_select" ON public.cash_advances
    FOR SELECT TO authenticated
    USING (
        user_id = (select auth.uid())
        OR (
            (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "cash_advances_insert" ON public.cash_advances
    FOR INSERT TO authenticated
    WITH CHECK (
        user_id = (select auth.uid())
        AND branch_id = (select public.auth_branch_id())
    );

-- [FIX-H4] Hanya owner/boss yang bisa approve/reject kasbon.
CREATE POLICY "cash_advances_update" ON public.cash_advances
    FOR UPDATE TO authenticated
    USING (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    )
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );


-- ---- P. SALARY RECORDS (APPEND-ONLY) ----
-- [FIX-M2] Branch isolation langsung via branch_id kolom.

CREATE POLICY "salary_records_select" ON public.salary_records
    FOR SELECT TO authenticated
    USING (
        user_id = (select auth.uid())
        OR (
            (select public.auth_user_role()) IN ('owner', 'boss', 'admin')
            AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
        )
    );

CREATE POLICY "salary_records_insert" ON public.salary_records
    FOR INSERT TO authenticated
    WITH CHECK (
        (select public.auth_user_role()) IN ('owner', 'boss')
        AND (branch_id = (select public.auth_branch_id()) OR (select public.auth_user_role()) = 'owner')
    );


-- ---- Q. NOTIFICATIONS ----
-- [FIX-H6] INSERT tidak dibatasi oleh user_id — INSERT hanya via service_role (bypass RLS).
-- UPDATE hanya untuk field is_read (user marking baca).
-- DELETE tidak diizinkan (notifikasi adalah log).

CREATE POLICY "notifications_select" ON public.notifications
    FOR SELECT TO authenticated
    USING (user_id = (select auth.uid()));

-- UPDATE: user hanya boleh mark as read. Kolom lain tidak boleh diubah.
-- Enforcement kolom dilakukan di application layer (Flutter: hanya kirim {is_read: true}).
CREATE POLICY "notifications_update" ON public.notifications
    FOR UPDATE TO authenticated
    USING (user_id = (select auth.uid()))
    WITH CHECK (user_id = (select auth.uid()));

-- INSERT & DELETE hanya via service_role key (backend/Edge Function) — RLS bypass.


-- ==========================================
-- SECTION 13: UTILITY TRIGGERS
-- ==========================================

-- Trigger untuk otomatis membuat baris branch_settings saat branch baru ditambahkan.
CREATE OR REPLACE FUNCTION public.handle_new_branch()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.branch_settings (branch_id)
    VALUES (NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_branch_created
    AFTER INSERT ON public.branches
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_branch();
