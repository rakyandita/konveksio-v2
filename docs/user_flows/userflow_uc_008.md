# [Fase 2 | SoT #4] UC-008: Manajemen Vendor Eksternal

## 1. Metadata
- **ID:** UC-008
- **Name:** Manajemen Data Vendor Eksternal
- **Actor:** Boss Cabang, Owner (dalam Branch Context Mode)
- **Trigger:** Boss Cabang perlu mendaftarkan vendor eksternal baru ke dalam sistem agar dapat digunakan sebagai penerima Handover dan pemegang Vendor Task (UC-003 Alt Flow 3.1).
- **Pre-conditions:** Pengguna telah login sebagai Boss Cabang — atau sebagai Owner yang aktif dalam Branch Context Mode (telah melewati `PAGE-015`).

## 2. Main Flow (Skenario Utama)
1. Actor mengetuk Tab Beranda lalu menavigasi ke menu **Master Data > Vendor** (`PAGE-016`) pada Grid Menu.
2. Sistem menampilkan daftar semua vendor yang terdaftar di cabang ini.
3. Actor menekan tombol `[Tambah Vendor]`.
4. Sistem menampilkan form input vendor baru (`PAGE-017` versi Create).
5. Actor mengisi data vendor:
   - **Nama Vendor** (wajib): Nama usaha atau nama kontak penanggung jawab.
   - **Divisi Keahlian** (wajib): Pilih dari daftar divisi produksi yang sudah dikonfigurasi.
   - **Nomor WhatsApp** (wajib): Format internasional, divalidasi agar bisa digunakan sebagai deep-link WA.
   - **Catatan Tarif** (opsional): Teks bebas, misal "Rp 500/pcs untuk qty > 500".
6. Actor menekan `[Simpan Vendor]`.
7. Sistem memvalidasi input (nama dan WA tidak boleh kosong).
8. Sistem menyimpan vendor dan menampilkan snackbar: "Vendor berhasil ditambahkan."
9. Sistem mengarahkan kembali ke `PAGE-016`. Vendor baru muncul di daftar.

## 3. Alternative Flows
**3.1. Edit Vendor yang Sudah Ada**
- Dari `PAGE-016`, Actor mengetuk baris vendor yang ingin diubah.
- Sistem membuka `PAGE-017` dalam mode Edit.
- Actor mengubah data yang diperlukan dan menekan `[Simpan Perubahan]`.
- *Catatan: Perubahan tarif hanya bersifat referensi — tidak mempengaruhi Vendor Task yang sudah berjalan.*

**3.2. Nonaktifkan Vendor (Soft Delete)**
- Dari `PAGE-017`, Actor menekan `[Nonaktifkan Vendor]`.
- Sistem menampilkan dialog konfirmasi: "Vendor ini tidak akan muncul sebagai pilihan penerima Handover baru. Riwayat task vendor tetap tersimpan. Nonaktifkan?"
- Actor mengkonfirmasi. Vendor berstatus Inactive dan tidak muncul di dropdown Handover baru.

## 4. Exception Flows
**4.1. Duplikasi Nama Vendor**
- Pada langkah 7, sistem mendeteksi nama vendor yang sama sudah ada (case-insensitive).
- Sistem menampilkan peringatan inline: "Vendor dengan nama ini sudah terdaftar. Pastikan tidak terduplikat."
- Sistem tetap memperbolehkan penyimpanan (bukan hard-block).

**4.2. Format Nomor WA Tidak Valid**
- Pada langkah 7, nomor WA tidak diawali 08 atau +62.
- Sistem menampilkan error inline: "Format nomor WA tidak valid. Gunakan format 08xxx atau +62xxx."
- Submit diblokir sampai nomor diperbaiki.

**4.3. Hapus Permanen Vendor yang Sedang Digunakan (Hard Delete)**
- Actor (via UI tersembunyi atau API) mencoba menghapus vendor yang sudah pernah menerima task.
- Sistem database mencegah operasi ini melalui foreign key constraint / backend logic.
- Sistem mereturn error: "Vendor sudah memiliki riwayat tugas dan tidak dapat dihapus permanen. Gunakan fitur Nonaktifkan."

## 5. Postconditions
- Entitas Vendor tersimpan dengan `branch_id`, `name`, `division`, `whatsapp`, `notes`, `is_active`.
- Vendor aktif dapat dipilih sebagai penerima Handover (UC-003 Alt Flow 3.1).

## 6. Related Pages
- `PAGE-016`: `/boss/vendors` (Daftar Vendor)
- `PAGE-017`: `/boss/vendors/:id` (Detail / Edit Vendor)

## 7. Acceptance Criteria
- [ ] Vendor baru langsung muncul sebagai pilihan penerima Handover di UC-003.
- [ ] Vendor yang dinonaktifkan tidak muncul di dropdown pilihan penerima Handover baru.
- [ ] Riwayat Vendor Task dari vendor yang dinonaktifkan tetap terlihat di histori produksi.
- [ ] Tap nomor WA vendor membuka WhatsApp langsung.
- [ ] Perubahan catatan tarif vendor tidak mengubah biaya Vendor Task yang sudah tersimpan.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-012 | Vendor | Name, Division, WhatsApp | String | Wajib diisi |
| ENT-012 | Vendor | Notes, IsActive, BranchID | String, Bool, UUID | BranchID untuk RLS |

## 9. Traceability
- **SRS Reference:** FR-03.3 (Manajemen Vendor), BR-03.3, F12 (Manajemen Vendor Simple), BR-07.7.
- **Menutup Gap:** SRS-02 dan IA-05 dari Audit Pre-Fase 3 (2026-07-16).
