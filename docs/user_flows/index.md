# [Fase 2 | SoT #4] User Flows Registry

**Project:** Konveksio
**Last Updated:** 2026-07-16
**Status:** ✅ FINAL (SoT #4 Approved)

## 1. Purpose
Direktori ini berisi seluruh dokumen *User Flows* (Aliran Pengguna) untuk aplikasi Konveksio. *User Flow* mendokumentasikan langkah demi langkah interaksi pengguna dengan sistem untuk mencapai tujuan bisnis tertentu, termasuk *main flow*, *alternative flow*, dan *exception flow*. Dokumen ini menjadi acuan utama untuk pembuatan purwarupa (*Prototype*, SoT #5) dan *Data Model* (SoT #6).

## 2. File Structure
Setiap *Use Case* (UC) didokumentasikan dalam satu file Markdown terpisah dengan format penamaan `userflow_uc_NNN.md`.

## 3. User Flow Catalog

| Use Case ID | Use Case Name | File Path | Status |
|-------------|---------------|-----------|--------|
| UC-000 | Login & Role Redirect | `./userflow_uc_000.md` | ✅ Final |
| UC-001 | Pembuatan Order & SPK | `./userflow_uc_001.md` | ✅ Final |
| UC-002 | Smart Bulk Assign | `./userflow_uc_002.md` | ✅ Final |
| UC-003 | Handover & Auto-Task | `./userflow_uc_003.md` | ✅ Final |
| UC-004 | Pengajuan Kasbon | `./userflow_uc_004.md` | ✅ Final |
| UC-005 | Generate Gaji Mingguan | `./userflow_uc_005.md` | ✅ Final |
| UC-006 | Update Progres Mandiri | `./userflow_uc_006.md` | ✅ Final |
| UC-007 | Owner Branch Context Mode | `./userflow_uc_007.md` | ✅ Final |
| UC-008 | Manajemen Vendor Eksternal | `./userflow_uc_008.md` | ✅ Final |

## 4. Requirement → User Flow Mapping
Pemetaan ini memastikan semua persyaratan bisnis (SRS v2.9) telah terakomodasi dalam *User Flow*.

| SRS Requirement | Description | Target Use Case |
|-----------------|-------------|-----------------|
| NFR-02.1, NFR-02.2 | Security, Auth, Role-based Access | UC-000 |
| BR-01.2, FR-10.1 | Branch Context Mode (Owner Full Access) | UC-007 |
| FR-06.1 - FR-06.5, F11 | Pencatatan Order Baru, Termin, & SPK Digital | UC-001 |
| FR-07.1 | Alokasi Tugas Awal (Smart Bulk Assign) | UC-002 |
| FR-07.2 - FR-07.4, FR-10.3 | Serah Terima Fisik, Auto-Task, Kotak Masuk | UC-003 |
| FR-08.1 - FR-08.2 | Pengajuan & Persetujuan Kasbon | UC-004 |
| FR-08.4 - FR-08.6 | Perhitungan Gaji dan Pembuatan Slip | UC-005 |
| FR-07.2 | Pencatatan progres tugas mandiri | UC-006 |
| FR-03.3, F12 | Manajemen Vendor Eksternal (CRUD) | UC-008 |

## 5. Page → User Flow Mapping
Pemetaan rute (dari Information Architecture) ke *Use Case* terkait.

| Page / Route | Role | Related Use Case |
|--------------|------|------------------|
| `/login` | Semua | UC-000 |
| `/owner/home` & `/owner/branch/:id` | Owner | UC-007 |
| `/boss/orders` & `/boss/orders/:id` | Boss Cabang, Owner* | UC-001, UC-003, UC-007 |
| `/boss/spk/:item_id` | Boss Cabang, Owner* | UC-001, UC-007 |
| `/boss/assign` | Boss Cabang, Owner* | UC-002, UC-007 |
| `/karyawan/tasks` & `/karyawan/handover` | Karyawan | UC-003, UC-006 |
| `/karyawan/inbox` & `/boss/inbox` | Karyawan & Boss | UC-003 |
| `/karyawan/home` (Tab Kasbon) | Karyawan | UC-004 |
| `/boss/home` (Tab Gaji) | Boss Cabang, Owner* | UC-005, UC-007 |
| `/boss/vendors` & `/boss/vendors/:id` | Boss Cabang, Owner* | UC-008 |
| `/boss/master/employees` & `/:id` | Boss Cabang, Owner* | — (Fase 5 UCIC) |
| `/boss/master/products` | Boss Cabang, Owner* | — (Fase 5 UCIC) |
| `/boss/master/customers` | Boss Cabang, Owner* | — (Fase 5 UCIC) |

## 6. Dependencies
- **UC-002 (Assign)** dan **UC-003 (Handover)** bergantung pada keberadaan order yang telah dibuat melalui **UC-001 (Order)**.
- **UC-005 (Generate Gaji)** bergantung pada akumulasi dari **UC-003 (Progress/Auto-Task)** dan pemotongan **UC-004 (Kasbon)**.
- **UC-007 (Branch Context Mode)** bergantung pada **UC-000 (Login)** dan menjadi *enabler* bagi Owner untuk menjalankan UC-001, UC-002, UC-003, UC-004, UC-005, dan UC-008 lintas cabang.
- **UC-008 (Manajemen Vendor)** bergantung pada konfigurasi divisi (F03) yang sudah ada. Vendor yang terdaftar menjadi pilihan penerima di **UC-003**.

## 7. Revision History
| Version | Date | Author | Notes |
|---------|------|--------|-------|
| 1.0 | 2026-07-15 | Antigravity AI | Initial registry setup (5 core flows) |
| 1.1 | 2026-07-15 | Antigravity AI | Tambah UC-007 (Branch Context Mode Owner) |
| 1.2 | 2026-07-16 | Antigravity AI | Audit Pre-Fase 3: Tambah UC-008 (Vendor), update mapping rute PAGE-016 s.d. PAGE-021, update SRS mapping F12, update dependencies |
