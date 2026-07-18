# [Fase 2 | SoT #4] UC-011: Manajemen Karyawan Produksi & Vendor

## 1. Metadata
- **ID:** UC-011
- **Name:** Manajemen Karyawan Produksi
- **Actor:** Boss Cabang, Admin (jika diberi izin)
- **Trigger:** Actor membuka menu "Karyawan & Vendor" dari Grid Menu.
- **Pre-conditions:** Pengguna login dengan role Boss atau Admin.

## 2. Main Flow (Skenario Utama: Tambah Karyawan)
1. Actor membuka halaman Manajemen Karyawan (`PAGE-026`).
2. Sistem menampilkan daftar karyawan produksi dan daftar vendor (di tab terpisah).
3. Actor menekan `[+ Tambah Karyawan]`.
4. Sistem menampilkan form Tambah Karyawan.
5. Actor mengisi: Nama Lengkap, Nomor WA (opsional), PIN sementara.
6. Actor menekan `[+ Tambah Divisi]`.
7. Actor memilih divisi (misal: "Cutting") dan mengisi tarif ongkos borongan (misal: Rp 2.000 / pcs).
8. Actor menekan `[Simpan]`.
9. Sistem memanggil Edge Function untuk membuat Auth, profil, dan record `employee_rates`.
10. Sistem menampilkan toast "Karyawan ditambahkan" dan me-refresh daftar.

## 3. Alternative Flows
**3.1. Edit Karyawan & Ubah Tarif**
- Pada langkah 3, Actor menekan nama karyawan dan memilih `[Edit]`.
- Actor mengubah ongkos borongan (misal dari Rp 2.000 menjadi Rp 2.500).
- Sistem menyimpan perubahan. *(Catatan: Sesuai SRS BR-08.3, ini tidak memengaruhi task yang sudah berjalan).*

**3.2. Tambah Vendor Eksternal**
- Actor membuka tab "Vendor".
- Actor menekan `[+ Tambah Vendor]`.
- Actor mengisi: Nama Vendor (misal CV Sablon Maju), Divisi, dan No WhatsApp.
- Sistem menyimpan ke tabel `vendors`. (Vendor tidak dibuatkan akun Auth).

**3.3. Nonaktifkan Karyawan (Resign/Keluar)**
- Actor menekan `[Nonaktifkan]` pada profil karyawan.
- Sistem meng-update `is_active = false`. Karyawan tersebut tidak akan muncul lagi di opsi Assign Tugas.

## 4. Exception Flows
**4.1. Karyawan Tanpa Divisi**
- Pada langkah 8, jika Actor tidak menambahkan satupun divisi.
- Sistem menyimpan karyawan tersebut, tetapi menampilkan peringatan: "Karyawan ini tidak memiliki divisi, tidak bisa diberikan tugas produksi." (SRS BR-03.1).

## 5. Postconditions
- Karyawan baru bisa login dengan HP dan PIN.
- Karyawan muncul di dropdown pilihan "Assign Tugas" sesuai divisinya.

## 6. Related Pages
- `PAGE-002`: Dashboard Boss
- `PAGE-026`: `/employees`

## 7. Acceptance Criteria
- [ ] Tarif ongkos karyawan bisa ditentukan per divisi, memungkinkan satu orang merangkap dua divisi dengan tarif berbeda.
- [ ] Vendor hanya dicatat kontaknya (tanpa PIN/Auth).
- [ ] Menonaktifkan karyawan menggunakan mekanisme Soft Delete, riwayat progress dan gaji tetap ada.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-011 | Profiles | name, role, is_active | String/Bool | role = 'employee' |
| ENT-012 | EmpRates | division, rate_per_pcs | Enum/Int | |
| ENT-013 | Vendors | name, division, phone | String | |

## 9. Traceability
- **SRS Reference:** F03 (Manajemen Karyawan Produksi & Vendor).
- **Pages:** PAGE-026.
