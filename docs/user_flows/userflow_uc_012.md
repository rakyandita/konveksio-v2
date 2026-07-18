# [Fase 2 | SoT #4] UC-012: Katalog Produk & Size Groups

## 1. Metadata
- **ID:** UC-012
- **Name:** Manajemen Katalog Produk & Size Groups
- **Actor:** Boss Cabang, Admin
- **Trigger:** Actor menekan menu "Katalog Produk" dari Grid Menu Dashboard.
- **Pre-conditions:** Pengguna login sebagai Boss atau Admin.

## 2. Main Flow (Skenario Utama: Tambah Size Group)
1. Actor membuka halaman Katalog (`PAGE-027`).
2. Sistem menampilkan daftar produk dan Size Group (tab terpisah).
3. Actor beralih ke tab "Size Group" dan menekan `[+ Tambah Grup]`.
4. Sistem menampilkan form Tambah Size Group.
5. Actor mengisi: Nama Grup (misal "Pakaian Anak") dan Daftar Ukuran (misal "S, M, L, XL").
6. Actor menekan `[Simpan]`.
7. Sistem memvalidasi nama tidak kosong dan ukuran minimal 1.
8. Sistem menyimpan ke tabel `size_groups` (dengan sizes disimpan sebagai JSONB array).
9. Sistem me-refresh daftar Size Group.

## 3. Alternative Flows
**3.1. Tambah Produk Baru**
- Actor di tab "Produk", menekan `[+ Tambah Produk]`.
- Actor mengisi: Nama Produk, Kategori (Setelan/Non-Setelan), Rentang Harga (Min-Max).
- Actor memilih Size Group (dropdown dari tabel `size_groups`). (Catatan: FR-04.3 menyediakan grup default "One Size").
- Actor menekan `[Simpan]`.
- Sistem menyimpan ke tabel `products` dan me-refresh daftar produk.

**3.2. Edit/Nonaktifkan Produk**
- Actor memilih produk, menekan Edit.
- Actor dapat mengubah atribut produk atau memilih Nonaktifkan (`is_active = false`).
- Jika dinonaktifkan, produk tidak muncul lagi di pilihan pembuatan Order, namun Order lama tetap menyimpan referensi produk tersebut dengan aman.

## 4. Exception Flows
**4.1. Hapus Size Group Sedang Digunakan**
- Actor mencoba menghapus/menonaktifkan Size Group yang sedang digunakan oleh suatu Produk aktif.
- Sistem mengecek relasi (FK restriction/application level check).
- Sistem menampilkan error: "Grup Ukuran ini masih digunakan oleh Produk aktif, tidak bisa dihapus." (BR-04.2).

## 5. Postconditions
- Produk baru muncul di dropdown pemilihan item saat membuat Order Baru (`PAGE-004`).
- Size picker di Order Baru akan menyesuaikan dengan Size Group yang melekat pada produk.

## 6. Related Pages
- `PAGE-002`, `PAGE-003` (Dashboard)
- `PAGE-027`: `/catalog`

## 7. Acceptance Criteria
- [ ] Size Group menyimpan kumpulan ukuran dalam JSONB array.
- [ ] Produk tanpa ukuran wajib diarahkan menggunakan grup default "One Size".
- [ ] Produk bersifat Soft Delete.
- [ ] Mengubah Size Group di produk tidak mengubah data Order yang sudah terbuat sebelumnya (Order item sizes meng-copy ukuran statik, tidak lookup dinamis).

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-014 | SizeGroups | name, sizes | String, JSONB | |
| ENT-015 | Products | name, category, size_group_id, price_min, price_max, is_active | String/Enum/UUID/Int/Bool | |

## 9. Traceability
- **SRS Reference:** F04 (Katalog Produk & Size Groups).
- **Pages:** PAGE-027.
