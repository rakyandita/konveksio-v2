# UC-007: Owner Masuk Branch Context Mode

## 1. Metadata
- **ID:** UC-007
- **Name:** Owner Masuk ke Branch Context Mode (Operasional Cabang)
- **Actor:** Owner
- **Trigger:** Owner perlu melakukan aksi operasional (misal: membuat Order, Smart Assign) di salah satu cabang.
- **Pre-conditions:** Owner sudah login dan berada di Global Dashboard (`PAGE-001`).

## 2. Main Flow (Skenario Utama)
1. Owner membuka **Global Dashboard** (`PAGE-001`).
2. Owner melihat daftar **Kartu Cabang** yang menampilkan ringkasan performa tiap cabang (total order aktif, produksi berjalan).
3. Owner mengetuk **Kartu Cabang** yang ingin dioperasikan (misal: Cabang Jakarta).
4. Sistem menampilkan dialog konfirmasi ringan: *"Anda akan masuk ke mode operasional Cabang Jakarta. Semua tindakan Anda akan tercatat atas nama Anda di cabang ini."*
5. Owner menekan `[Masuk]`.
6. Sistem mengaktifkan `acting_branch_id` di session dan merender ulang UI. **Tiga perubahan visual langsung aktif:**
   - **Lapisan 1 (Header):** Warna header berubah dari Emerald (`#0D9488`) menjadi **Amber** (`#D97706`), menampilkan teks `⚡ Mode Operasional · Cabang Jakarta` dan tombol `[Keluar]` di kanan.
   - **Lapisan 2 (Role Chip):** Chip `👑 OWNER` (latar Amber Muda, sticky di bawah header) selalu tampil selama mode aktif.
   - **Lapisan 3 (Dialog Extra):** Aktif pada saat Owner mencoba aksi destruktif/finansial (Generate Gaji, Hapus Order, dll.).
7. UI konten di bawah header menjadi **identik dengan tampilan Boss Cabang** pada Cabang Jakarta.
8. Owner dapat menjalankan semua fungsi Boss Cabang (Buat Order, Assign, Inbox, dll.).

## 3. Alternative Flows
**3.1. Keluar dari Branch Context Mode**
- Kapan saja dalam *Branch Context Mode*, Owner mengetuk tombol `[Keluar]` di header.
- Sistem menghapus `acting_branch_id` dari session.
- UI kembali ke **Global Dashboard** Owner (`PAGE-001`).

**3.2. Pindah Konteks ke Cabang Lain**
- Owner sedang dalam konteks Cabang Jakarta dan ingin beralih ke Cabang Bandung.
- Owner menekan `[Keluar]` terlebih dahulu (kembali ke Global Dashboard).
- Owner mengetuk Kartu Cabang Bandung dan mengulangi Main Flow.
- *Catatan: Tidak ada perpindahan konteks langsung antar cabang tanpa melewati Global Dashboard untuk mencegah kebingungan.*

## 4. Exception Flows
**4.1. Generate Gaji dalam Branch Context Mode**
- Owner mencoba menekan `[Generate Gaji]` dalam Branch Context Mode.
- Sistem menampilkan **dialog konfirmasi tambahan**: *"Anda akan menerbitkan slip gaji sebagai Owner yang mewakili Cabang Jakarta. Tindakan ini akan mengirimkan notifikasi ke seluruh karyawan Cabang Jakarta dan tidak dapat dibatalkan. Lanjutkan?"*
- Owner harus menekan `[Ya, Terbitkan]` secara eksplisit untuk melanjutkan.

**4.2. Session Expired dalam Branch Context Mode (RISK-04)**
- Token sesi Owner kadaluarsa saat sedang aktif dalam Branch Context Mode (contoh: setelah idle lama).
- Sistem mendeteksi token tidak valid pada request berikutnya.
- Sistem **menghapus `acting_branch_id` dari session** dan mengarahkan Owner ke Halaman Login (`PAGE-000`).
- Setelah Owner berhasil login ulang, sistem selalu mengarahkan ke **Global Dashboard Owner** (`PAGE-001`) — bukan kembali ke Branch Context Mode sebelumnya.
- *Alasan:* Re-masuk ke Branch Context Mode secara otomatis berisiko jika Owner tidak menyadari token sudah diperbarui. Memulai dari Global Dashboard memberikan Owner kendali penuh.

## 5. Postconditions
- `acting_branch_id` aktif dalam session Owner.
- Semua operasi tulis (Order, Assign, dll.) tercatat dengan `created_by = owner_id` dan `branch_id = acting_branch_id`.
- Audit log merekam bahwa aksi dilakukan oleh Owner dalam Branch Context Mode.

## 6. Related Pages
- `PAGE-001`: `/owner/home` (Global Dashboard)
- `PAGE-015`: `/owner/branch/:id` (Pintu masuk Branch Context Mode)
- `PAGE-003` s.d. `PAGE-007`: Semua rute operasional Boss yang dapat diakses Owner dalam mode ini.

## 7. Acceptance Criteria
- [ ] **Lapisan 1 (Header):** Saat Owner aktif dalam Branch Context Mode, header berubah warna menjadi Amber (`#D97706`) dan menampilkan `⚡ Mode Operasional · [Nama Cabang]` beserta tombol `[Keluar]`.
- [ ] **Lapisan 1 (Header):** Saat Owner keluar dari Branch Context Mode, header kembali ke warna Emerald (`#0D9488`) dan label mode hilang.
- [ ] **Lapisan 2 (Role Chip):** Chip `👑 OWNER` berwarna Amber Muda muncul *sticky* di bawah header dan tidak ikut scroll selama Branch Context Mode aktif.
- [ ] **Lapisan 3 (Dialog Extra):** Aksi Generate Gaji, Hapus Draft Order, dan Tolak Handover massal selalu menampilkan dialog konfirmasi tambahan dengan kalimat identitas Owner.
- [ ] Semua data yang ditulis Owner dalam Branch Context Mode memiliki `branch_id` yang tepat (bukan null).
- [ ] Owner tidak bisa mengakses rute operasional Boss (`/boss/*`) tanpa melewati `PAGE-015` terlebih dahulu.
- [ ] **[RISK-04]** Jika session Owner expired dalam Branch Context Mode, sistem mengarahkan ke Login dan setelah re-login diarahkan ke Global Dashboard (`PAGE-001`), bukan kembali ke Branch Context Mode.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-000 | User (Owner) | Session, acting_branch_id | String | Disuntikkan saat masuk konteks, dihapus saat keluar |
| ENT-011 | Branch | ID, Name | UUID, String | Cabang yang dipilih |

## 9. Traceability
- **SRS Reference:** BR-01.2 (Branch Context Mode / Full Access Mechanism), FR-10.1 (Dashboard Owner & Branch Context Mode).
