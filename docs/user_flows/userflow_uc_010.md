# [Fase 2 | SoT #4] UC-010: Manajemen User & Role

## 1. Metadata
- **ID:** UC-010
- **Name:** Manajemen User (Boss Cabang & Admin)
- **Actor:** Owner, Boss Cabang
- **Trigger:** Actor menekan menu "Manajemen User" dari Dashboard.
- **Pre-conditions:** Pengguna login sebagai Owner (mengelola Boss) atau Boss Cabang (mengelola Admin).

## 2. Main Flow (Skenario Utama: Boss Membuat Admin)
1. Actor (Boss Cabang) membuka halaman Manajemen User (`PAGE-025`).
2. Sistem menampilkan daftar pengguna (Admin & Boss) pada cabang saat ini.
3. Actor menekan tombol `[+ Tambah Pengguna]`.
4. Sistem memunculkan form Tambah Pengguna.
5. Actor memasukkan field: Nama Lengkap, Nomor WA, Role (otomatis terpilih 'Admin'), dan PIN sementara.
6. Sistem menampilkan konfigurasi Hak Akses (Dynamic Permissions untuk Admin).
7. Actor mencentang hak akses (misal: "Boleh buat order", "Boleh lihat laporan").
8. Actor menekan `[Simpan]`.
9. Sistem memanggil Edge Function untuk membuat user di Supabase Auth dan tabel `profiles`.
10. Sistem menyimpan record hak akses ke tabel `admin_permissions`.
11. Sistem menampilkan toast success: "Pengguna berhasil ditambahkan" dan me-refresh daftar.

## 3. Alternative Flows
**3.1. Edit Hak Akses Admin**
- Pada langkah 3, Actor memilih akun Admin dari daftar dan memilih Edit.
- Sistem menampilkan form edit hak akses.
- Actor mencentang/menghapus centang permission.
- Sistem menyimpan ke `admin_permissions`.

**3.2. Owner Membuat Boss Cabang**
- Owner masuk ke Branch Context cabang tertentu.
- Owner menekan `[+ Tambah Pengguna]`, Role diisi "Boss Cabang".
- Bagian Hak Akses (Dynamic Permissions) disembunyikan (karena Boss punya full akses cabang).
- Sistem menyimpan data ke `profiles` dengan role 'boss'.

**3.3. Nonaktifkan User**
- Actor menekan opsi `[Nonaktifkan]` pada user tertentu.
- Sistem memunculkan konfirmasi.
- Sistem meng-update `is_active = false` pada profil user (Soft Delete).

## 4. Exception Flows
**4.1. Nomor WA Sudah Terdaftar**
- Pada langkah 9, jika Supabase Auth mereturn error nomor telepon sudah digunakan.
- Sistem menampilkan error: "Nomor WA ini sudah terdaftar di sistem."
- Actor harus menggunakan nomor lain.

## 5. Postconditions
- Akun pengguna baru siap login dengan nomor WA dan PIN.
- Pengaturan Dynamic Permissions (untuk Admin) tersimpan dan berlaku secara instan.

## 6. Related Pages
- `PAGE-001`, `PAGE-002` (Dashboard)
- `PAGE-025`: `/settings/users`

## 7. Acceptance Criteria
- [ ] Nomor WA harus divalidasi panjang dan formatnya.
- [ ] Admin yang tidak diberi hak "Boleh buat order" tidak dapat mengakses menu order.
- [ ] Akun yang dinonaktifkan tidak dapat login, tapi riwayat pekerjaannya tetap aman.
- [ ] Owner bisa membuat Boss Cabang, tapi Boss Cabang tidak bisa membuat Owner.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-000 | User | phone, role, is_active | String/Bool | |
| ENT-010 | AdminPerm | can_manage_orders, can_view_reports | Bool | |

## 9. Traceability
- **SRS Reference:** F02 (Manajemen User, Role & Permissions).
- **Pages:** PAGE-025.
