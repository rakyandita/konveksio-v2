# [Fase 2 | SoT #4] UC-009: Manajemen Cabang

## 1. Metadata
- **ID:** UC-009
- **Name:** Manajemen Cabang
- **Actor:** Owner
- **Trigger:** Owner mengetuk Tab Profil lalu menekan menu "Pengaturan Cabang".
- **Pre-conditions:** Pengguna sudah login sebagai Owner (`PAGE-001`).

## 2. Main Flow (Skenario Utama)
1. Actor membuka halaman Pengaturan Cabang (`PAGE-024`).
2. Sistem menampilkan daftar seluruh cabang beserta status aktifnya.
3. Actor menekan tombol `[+ Tambah Cabang]`.
4. Sistem memunculkan form Tambah Cabang.
5. Actor mengisi field: Nama Cabang, Alamat, dan Nomor Kontak.
6. Actor menekan tombol `[Simpan]`.
7. Sistem memvalidasi input (tidak ada kolom kosong).
8. Sistem menyimpan record baru ke tabel `branches` dan membuat entri default di `branch_settings`.
9. Sistem menampilkan _toast success_: "Cabang berhasil ditambahkan".
10. Sistem kembali ke daftar cabang dan me-refresh daftar.

## 3. Alternative Flows
**3.1. Nonaktifkan Cabang (Soft Delete)**
- Pada langkah 3, Actor memilih satu cabang dari daftar dan menekan tombol `[Nonaktifkan]`.
- Sistem memunculkan dialog konfirmasi: "Yakin menonaktifkan cabang ini?".
- Actor menekan `[Ya, Nonaktifkan]`.
- Sistem mengupdate status `is_active = false` (Soft Delete).
- Sistem menampilkan _toast success_ dan me-refresh daftar cabang.

**3.2. Edit Cabang**
- Pada langkah 3, Actor menekan tombol `[Edit]` pada salah satu cabang.
- Sistem memunculkan form Edit Cabang dengan data yang sudah terisi.
- Actor mengubah data dan menekan `[Simpan]`.
- Sistem menyimpan perubahan dan me-refresh daftar.

## 4. Exception Flows
**4.1. Input Tidak Valid**
- Pada langkah 7, jika Nama Cabang kosong.
- Sistem menampilkan error di bawah form: "Nama cabang wajib diisi".
- Actor harus memperbaiki input sebelum bisa menyimpan.

## 5. Postconditions
- Cabang baru tercipta dan bisa digunakan untuk mendaftarkan Boss/Karyawan baru di cabang tersebut.
- Cabang yang dinonaktifkan tidak akan bisa diakses, tetapi data historis tetap aman.

## 6. Related Pages
- `PAGE-001`: `/owner/home`
- `PAGE-024`: `/owner/branches` (Daftar & Form Cabang)

## 7. Acceptance Criteria
- [ ] Form pembuatan cabang wajib memvalidasi nama cabang (tidak boleh kosong).
- [ ] Menonaktifkan cabang tidak menghapus data historis (Soft delete dengan is_active = false).
- [ ] Daftar cabang diurutkan berdasarkan alfabetis atau cabang terbaru.
- [ ] Cabang otomatis mendapatkan setting default (`branch_settings`) saat pertama kali dibuat.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-009 | Branches | nama, alamat, telepon, is_active | String/Bool | |

## 9. Traceability
- **SRS Reference:** F01 (Manajemen Cabang).
- **Pages:** PAGE-024.
