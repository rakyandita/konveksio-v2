# [Fase 5 | SoT #7] System Logics (UCIC) Registry

**Project:** Konveksio
**Last Updated:** 2026-07-16
**Status:** ✅ FINAL (SoT #7 Approved)

## 1. Purpose
Direktori ini berisi Use Case Integration Contracts (UCIC). Ini adalah spesifikasi teknis (SoT #7) yang menjembatani User Flows (SoT #4) dengan implementasi Frontend/Backend. Kontrak ini menjamin tidak ada miskomunikasi format API antara klien (Flutter) dan server (Supabase).

## 2. File Structure
Setiap Use Case (UC) didokumentasikan dalam file terpisah dengan format `sys_uc_NNN.md`.

## 3. System Logic Catalog

| Use Case ID | Use Case Name | File Path | API Strategy | Status |
|-------------|---------------|-----------|--------------|--------|
| UC-000 | Login & Role Redirect | `./sys_uc_000.md` | Supabase Auth SDK | ✅ Final |
| UC-001 | Pembuatan Order & SPK | `./sys_uc_001.md` | Postgres RPC (ACID) | ✅ Final |
| UC-002 | Smart Bulk Assign | `./sys_uc_002.md` | Postgres RPC (ACID) | ✅ Final |
| UC-003 | Handover & Auto-Task | `./sys_uc_003.md` | Supabase Client SDK | ✅ Final |
| UC-004 | Pengajuan Kasbon | `./sys_uc_004.md` | Supabase Client SDK | ✅ Final |
| UC-005 | Generate Gaji Mingguan | `./sys_uc_005.md` | Postgres RPC (Bulk Compute)| ✅ Final |
| UC-006 | Update Progres Mandiri | `./sys_uc_006.md` | Supabase Client SDK | ✅ Final |
| UC-007 | Owner Branch Context Mode | `./sys_uc_007.md` | Supabase Client SDK | ✅ Final |
| UC-008 | Manajemen Vendor Eksternal | `./sys_uc_008.md` | Supabase Client SDK | ✅ Final |

## 4. API Overview

- **Base Platform:** Supabase (PostgREST & RPC)
- **Auth Model:** Supabase Auth (JWT)
- **Error Format:** Default PostgREST Error (JSON) `{"code": "...", "message": "...", "details": "..."}`
- **Security:** Seluruh akses dikunci secara native via Row Level Security (RLS) di database. `branch_id` dipaksa (hard-limit) melalui fungsi RLS `auth_branch_id()`.

## 5. Revision History
| Version | Date | Author | Notes |
|---------|------|--------|-------|
| 1.0 | 2026-07-16 | Antigravity AI | Initial UCIC generation (9 Use Cases) |
