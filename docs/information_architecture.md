# [Fase 2 | SoT #2] Information Architecture (IA)

**Project:** Konveksio
**Role:** Owner, Boss Cabang / Admin, Karyawan Produksi
**Last Updated:** 2026-07-16
**Status:** ✅ FINAL (SoT #2 Approved)
**Traceability:** Turunan dari [SRS v3.0](./srs.md)

## 1. Overview
Dokumen ini mendefinisikan struktur navigasi, hierarki halaman, dan arsitektur informasi aplikasi Konveksio. Aplikasi ini menggunakan pendekatan *role-based rendering* (satu aplikasi, namun menampilkan pengalaman navigasi yang sepenuhnya berbeda sesuai tingkat *role* pengguna yang masuk).

## 2. Global Navigation Strategy
- **Karyawan Produksi:** Menggunakan **Bottom Navigation Bar** untuk akses cepat dengan satu tangan di lapangan (*thumb-friendly*).
- **Boss Cabang / Admin:** Menggunakan **Dashboard Grid Menu** di halaman Beranda (akses cepat ke fungsi prioritas), ditambah **Side Drawer (Hamburger Menu)** untuk fitur-fitur administratif lengkap yang jarang diakses.
- **Owner:** Menggunakan **Dashboard Global** dengan dua mode: **(1) Mode Pantau** (Global Dashboard default) dan **(2) Mode Konteks Cabang** (*Branch Context Mode*) — di mana Owner dapat masuk ke konteks operasional satu cabang dan mengakses UI yang identik dengan Boss Cabang, termasuk membuat Order.

## 3. Sitemap & Page Hierarchy

### 3.1. Role: Owner (Super Admin)
```text
[Owner Root]
├── Auth
│   └── Login & Role Redirect
├── Beranda (Global Dashboard) ← Mode Pantau Default
│   ├── Metrik Omzet Global
│   ├── Perbandingan Performa Cabang
│   └── Kartu Cabang (tap untuk masuk konteks)
├── [Branch Context Mode] ← Aktif setelah tap Kartu Cabang
│   └── [UI IDENTIK DENGAN BOSS CABANG]
│       ├── Order & SPK (termasuk Buat Order)
│       ├── Produksi (Smart Assign, Kanban)
│       ├── Kotak Masuk
│       ├── Keuangan & SDM
│       │   └── Generate Gaji *[ada konfirmasi tambahan]
│       └── Master Data
├── Cabang
│   ├── Daftar Cabang
│   ├── Detail Cabang
│   └── Form Tambah/Edit Cabang
├── Akun & Akses
│   ├── Daftar Boss Cabang/Admin
│   └── Form Tambah/Edit Boss Cabang
└── Pengaturan
    └── Logout
```

### 3.2. Role: Boss Cabang / Admin
```text
[Boss Root]
├── Beranda (Dashboard Cabang)
│   ├── Ringkasan Order & Produksi
│   ├── Alert Box (Deadline < 3 Hari, Tugas Stuck)
│   ├── Quick Action: [Tambah Order]
│   └── Grid Menu (Akses ke semua modul)
│
├── Order (Pesanan)
│   ├── Daftar Order
│   │   └── Tab filter: Draft | Konfirmasi | Produksi | Selesai | Dikirim | Selesai(done) | Batal
│   │       > (Label UI Bahasa Indonesia. Nilai enum database: draft | confirmation | running | completed | shipped | done | cancelled)
│   ├── Form Tambah/Edit Order
│   └── Detail Order
│       ├── Info Pemesan & Item
│       ├── SPK Digital (View/Upload)
│       └── Riwayat Pembayaran (Termin)
│
├── Produksi
│   ├── Pipeline / Kanban Board (PAGE-028)
│   ├── Daftar Tugas (Karyawan & Vendor)
│   ├── Form Smart Bulk Assign (PAGE-006)
│   └── Kelola Discrepancy (Resolusi Selisih Fisik)
│
├── Kotak Masuk (Inbox Boss)
│   ├── Konfirmasi Handover Vendor
│   └── Konfirmasi Handover Ditolak / Stuck
│
├── Keuangan & SDM
│   ├── Approval Kasbon Karyawan
│   ├── Generate Gaji (Slip Gaji Mingguan)
│   └── Detail Karyawan (Limit Kasbon)
│
├── Master Data
│   ├── Katalog Produk & Size Group
│   ├── Master Karyawan & Divisi (Setup Ongkos Borongan)
│   └── Master Vendor
│
└── Pengaturan
    ├── Pengaturan Cabang (Profil, Invoice, Kasbon, Sistem Upah)
    ├── Pengaturan Admin (Akses Modul)
    └── Logout
```

### 3.3. Role: Karyawan Produksi
*Struktur navigasi ini melekat pada Bottom Navigation Bar yang selalu muncul di layar Karyawan.*

```text
[Karyawan Root]
├── Beranda (Tab 1)
│   ├── Sapaan Personal & Motivasi Divisi
│   ├── Ringkasan Pcs Selesai (Minggu Ini)
│   └── Proyeksi Upah
│
├── Produksi (Tab 2) - Mobile Kanban Swipeable
│   ├── Kolom 1: MASUK (Handover masuk, tombol Terima/Tolak)
│   ├── Kolom 2: PROSES (Tugas aktif, form update progres)
│   └── Kolom 3: SELESAI (Tugas yang sudah selesai 100%)
│
├── Keuangan (Tab 3)
│   ├── Form Pengajuan & Riwayat Kasbon
│   └── Riwayat Slip Gaji Mingguan
│
└── Profil (Tab 4)
    ├── Detail Data Karyawan
    └── Logout
```

## 4. Route Mapping (Flutter Navigation)
Setiap layar krusial dipetakan dengan Identifier ID (Route Name). Mapping ini akan menjadi referensi bagi **User Flows** dan integrasi **Frontend (GoRouter/AutoRoute)** nantinya.

> **Catatan Branch Context Mode:** Rute `PAGE-003` s.d. `PAGE-007` (semua rute `/boss/*` kecuali `/boss/home`) juga dapat diakses oleh **Owner** yang sedang aktif dalam *Branch Context Mode*. Token autentikasi Owner akan membawa parameter `acting_branch_id` untuk menegakkan RLS Supabase pada cabang yang dipilih.

| Page ID | Route Name | Deskripsi | Parameter URL/Args | Akses Role | Masuk Dari | Feature ID |
|---------|------------|-----------|--------------------|------------|------------|------------|
| PAGE-000 | `/login` | Halaman otentikasi (No Auth) | - | Semua | *Splash Screen* | F02 |
| PAGE-001 | `/owner/home` | Dashboard Super Admin (Global) | - | Owner | PAGE-000 | F10 |
| PAGE-015 | `/owner/branch/:id` | Pintu masuk Branch Context Mode | `branch_id` | Owner | PAGE-001 | F10 |
| PAGE-002 | `/boss/home` | Dashboard Boss Cabang | - | Boss | PAGE-000 | F10 |
| PAGE-003 | `/boss/orders` | Daftar Order | `?tab=produksi` | Boss, Owner* | PAGE-002, PAGE-015 | F11 |
| PAGE-004 | `/boss/orders/:id` | Detail Order | `order_id` | Boss, Owner* | PAGE-003 | F11 |
| PAGE-005 | `/boss/spk/:item_id` | View/Edit SPK | `item_id` | Boss, Owner* | PAGE-004 | F11 |
| PAGE-006 | `/boss/assign` | Smart Bulk Assign | `order_item_id` | Boss, Owner* | PAGE-004 | F07 |
| PAGE-007 | `/boss/inbox` | Kotak Masuk Vendor/Resolusi | - | Boss, Owner* | PAGE-002, PAGE-015 | F07 |
| PAGE-008 | `/karyawan/home` | Dashboard Karyawan | - | Karyawan | PAGE-000 | F10 |
| PAGE-009 | `/karyawan/inbox` | Kotak Masuk Handover | - | Karyawan | PAGE-008 (Tab 2) | F07 |
| PAGE-010 | `/karyawan/tasks` | Daftar Tugas Aktif | - | Karyawan | PAGE-008 (Tab 3) | F07 |
| PAGE-011 | `/karyawan/tasks/:id`| Detail Tugas & Update | `task_id` | Karyawan | PAGE-010 | F07 |
| PAGE-012 | `/karyawan/spk/:id` | SPK Viewer (Offline Support)| `item_id` | Karyawan | PAGE-011 | F11 |
| PAGE-013 | `/karyawan/handover` | Form Buat Handover | `task_id` | Karyawan | PAGE-011 | F07 |
| PAGE-014 | `/settings` | Pengaturan & Logout | - | Semua | Beranda/Tab 4 | F02 |
| PAGE-016 | `/boss/vendors` | Daftar Vendor Eksternal | - | Boss, Owner* | PAGE-002, PAGE-015 | F12 |
| PAGE-017 | `/boss/vendors/:id` | Detail / Edit Vendor | `vendor_id` | Boss, Owner* | PAGE-016 | F12 |
| PAGE-018 | `/boss/master/employees` | Daftar Karyawan & Divisi | - | Boss, Owner* | PAGE-002, PAGE-015 | F03 |
| PAGE-019 | `/boss/master/employees/:id` | Detail / Edit Karyawan | `employee_id` | Boss, Owner* | PAGE-018 | F03 |
| PAGE-020 | `/boss/master/products` | Katalog Produk & Size Group | - | Boss, Owner* | PAGE-002, PAGE-015 | F04 |
| PAGE-021 | `/boss/master/customers` | Daftar Customer | - | Boss, Owner* | PAGE-002, PAGE-015 | F05 |
| PAGE-022 | `/boss/settings/branch` | Pengaturan Cabang (Limit, Sistem) | - | Boss, Owner* | PAGE-014 | F01 |
| PAGE-023 | `/boss/settings/admin` | Pengaturan Admin (Akses) | - | Boss, Owner* | PAGE-014 | F02 |
| PAGE-024 | `/boss/finance/kasbon` | Approval Kasbon Karyawan | - | Boss, Owner* | PAGE-002, PAGE-015 | F08 |
| PAGE-025 | `/boss/finance/salary` | Generate Gaji & Slip Mingguan | - | Boss, Owner* | PAGE-002, PAGE-015 | F08 |
| PAGE-026 | `/karyawan/kasbon` | Pengajuan & Riwayat Kasbon | - | Karyawan | PAGE-008 (Tab 4) | F08 |
| PAGE-027 | `/karyawan/salary` | Riwayat Slip Gaji Mingguan | - | Karyawan | PAGE-008 (Tab 4) | F08 |
| PAGE-028 | `/boss/pipeline` | Kanban Board Produksi | - | Boss, Owner* | PAGE-002, PAGE-015 | F07 |

*Owner\*: Hanya dapat mengakses rute ini ketika aktif dalam **Branch Context Mode** (telah melewati PAGE-015). Di luar konteks tersebut, Owner akan di-redirect kembali ke PAGE-001.

## 5. Traceability
- Dokumen ini adalah turunan langsung dari **[SRS v3.0](./srs.md)** (SoT #1).
- Perubahan v1.1: Penambahan *Branch Context Mode* (PAGE-015) untuk menyelaraskan klausul **BR-01.2** (Owner full access) dari SRS yang sebelumnya tidak terakomodasi di IA.
- Perubahan v1.2: Update traceability ke SRS v3.0. Tambah catatan i18n di Tab Order (Section 3.2) — label UI Bahasa Indonesia tetap dipertahankan di IA (presentation layer), sementara nilai enum database Bahasa Inggris didokumentasikan sebagai komentar referensi. Perubahan ini selaras dengan prinsip *Separation of Concerns*: database layer (Bahasa Inggris) vs. presentation layer (Bahasa Indonesia).
- Dokumen ini menjadi pedoman pemetaan layar bagi pembuatan **User Flows** (SoT #4) dan komponen layar pada **HiFi Prototype** (SoT #5).
- Perubahan v1.3 (Recovery Audit): (1) Tab filter order diperbaiki — pisahkan `shipped` dan `done` yang sebelumnya digabung (`shipped/done`). (2) Tambah 4 rute yang hilang: PAGE-024 (`/boss/finance/kasbon`), PAGE-025 (`/boss/finance/salary`), PAGE-026 (`/karyawan/kasbon`), PAGE-027 (`/karyawan/salary`) — semua ada di sitemap Section 3.2 & 3.3 namun tidak ada di Route Mapping table. (3) Update status dokumen ke Audited (Recovery v1).
