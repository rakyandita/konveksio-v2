# UC-001: Pembuatan Order & SPK

## 1. Metadata
- **ID:** UC-001
- **Name:** Pembuatan Order Baru & SPK Digital
- **Actor:** Boss Cabang, Admin, Owner (dalam Branch Context Mode)
- **Trigger:** Pelanggan (Customer) setuju melakukan pemesanan dan telah membayar DP (jika ada).
- **Pre-conditions:** Pengguna telah login sebagai Boss Cabang / Admin — atau sebagai Owner yang aktif dalam Branch Context Mode (telah melewati `PAGE-015`).

## 2. Main Flow (Skenario Utama)
1. Actor menavigasi ke halaman **Order** atau tap tombol `[Tambah Order]` dari Dashboard.
2. Actor memilih tipe pembuatan order (Pelanggan Baru atau Pelanggan Lama).
3. Jika Pelanggan Baru, Actor menginput nama dan nomor WhatsApp.
4. Actor memasukkan detail **Order Item** (Nama produk, target deadline).
5. Actor memasukkan distribusi **Qty per Size** (misal S: 10, M: 20).
6. Actor memasukkan detail pembayaran awal (Nominal DP atau Lunas).
7. Actor menekan tombol `[Buat Order]`.
8. Sistem memvalidasi input dan menyimpan data Order (State: *Draft*).
9. Sistem mengarahkan Actor ke halaman **Detail Order**.
10. Di halaman Detail Order, Actor memilih item dan menekan `[Buat SPK]`.
11. Actor menginput spesifikasi (Bahan, Warna, Model) dan mengunggah gambar desain (opsional).
12. Jika ada gambar, sistem melakukan kompresi gambar secara lokal (*client-side*) hingga ≤ 1 MB, lalu mengunggahnya ke Supabase Storage.
13. Sistem menyimpan data SPK. Order siap dilanjutkan ke tahap "Antrian" produksi.

## 3. Alternative Flows
**3.1. Pembuatan Order Tanpa SPK**
- Pada langkah 9 (setelah order berhasil dibuat), Actor memilih untuk tidak langsung membuat SPK dan keluar dari layar.
- Sistem tetap memungkinkan order diproses (SPK bersifat opsional, lihat BR-11.1). Namun sistem akan memberikan *alert/warning* di Dashboard jika order masuk tahap "Produksi Berjalan" tanpa SPK.

**3.2. Penambahan Item Baru pada Order yang Sama**
- Actor membuka Order yang sudah berstatus Draft/Antrian.
- Actor menekan `[Tambah Item]`.
- Sistem menambahkan item tersebut ke dalam order yang sama, tanpa perlu membuat entitas Customer baru.

## 4. Exception Flows
**4.1. Resolusi Gambar Terlalu Kecil / Format Tidak Mendukung**
- Pada langkah 11, Actor mengunggah gambar resolusi di bawah 400x400 px atau format bukan JPG/PNG/WEBP.
- Sistem menolak unggahan dan menampilkan pesan error (warna `--color-destructive`): "Gambar minimal 400x400 px dan harus berformat JPG/PNG/WEBP."
- Actor harus memilih gambar lain.

**4.2. Koneksi Internet Terputus Saat Upload SPK**
- Pada langkah 12, unggahan gagal karena jaringan terputus.
- Sistem menampilkan *snackbar* error dan tombol `[Coba Lagi]`.
- Input teks SPK (Bahan, Warna) tersimpan di form *state* hingga unggahan gambar berhasil.

## 5. Postconditions
- Entitas Order baru tersimpan di *database* dengan status "Draft" atau "Antrian".
- Jika SPK menyertakan gambar, gambar tersimpan di *cloud storage*.

## 6. Related Pages
- `PAGE-003`: `/boss/orders`
- `PAGE-004`: `/boss/orders/:id`
- `PAGE-005`: `/boss/spk/:item_id`

## 7. Acceptance Criteria
- [ ] Order baru dapat dibuat dengan minimal 1 item produk dan alokasi qty per size.
- [ ] Sistem memblokir *submit* jika total qty order = 0 atau target *deadline* berada di masa lalu.
- [ ] SPK dapat disimpan dengan teks saja, atau dengan teks + gambar (opsional).
- [ ] Ukuran file gambar yang tersimpan dipastikan **≤ 1 MB** melalui kompresi lokal (Flutter).

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-001 | Customer | Name, WhatsApp | String | Wajib divalidasi format WA-nya |
| ENT-002 | Order | Total Qty, Total Price | Number | Dihitung otomatis dari Order Item |
| ENT-003 | OrderItem | Product Name, Deadline | String, Date | - |
| ENT-004 | OrderItemSize | Size Label, Qty | String, Number | Array, misal: [{S, 10}, {M, 20}] |
| ENT-005 | SPK | Material, Color, Design URLs | String | Terikat ke OrderItem |

## 9. Traceability
- **SRS Reference:** FR-06.1, FR-06.3, F11 (SPK Digital), BR-11.1 (SPK Opsional), BR-11.3 (Storage).
