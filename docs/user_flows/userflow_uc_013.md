# [Fase 2 | SoT #4] UC-013: Manajemen Customer

## 1. Metadata
- **ID:** UC-013
- **Name:** Manajemen Customer (Pemesan)
- **Actor:** Boss Cabang, Admin
- **Trigger:** Actor menekan menu "Customer" dari Grid Menu.
- **Pre-conditions:** Pengguna login sebagai Boss atau Admin.

## 2. Main Flow (Skenario Utama: Tambah Customer Baru)
1. Actor membuka halaman Customer (`PAGE-013`).
2. Sistem menampilkan daftar customer (diurutkan alfabetis atau yang terbaru), beserta kolom pencarian.
3. Actor menekan `[+ Tambah Customer]`.
4. Sistem menampilkan form Tambah Customer.
5. Actor mengisi: Nama Lengkap, No WhatsApp, Alamat Pengiriman, dan Catatan (opsional).
6. Actor menekan `[Simpan]`.
7. Sistem memvalidasi No WhatsApp (format angka, min 10 digit, awalan 08/628).
8. Sistem menyimpan ke tabel `customers`.
9. Sistem menampilkan toast success dan me-refresh daftar.

## 3. Alternative Flows
**3.1. Klik Nomor WA Customer**
- Actor melihat detail profil customer di list.
- Actor menekan tombol/icon WhatsApp di sebelah nomor.
- Sistem membuka intent URL (misal: `https://wa.me/628xxx`).
- Aplikasi WhatsApp terbuka dengan nomor tersebut (FR-05.2).

**3.2. Lihat Riwayat Order Customer**
- Actor menekan nama customer di daftar.
- Sistem menampilkan halaman Detail Customer.
- Di bagian bawah, sistem menampilkan riwayat order yang pernah dibuat oleh customer ini.

**3.3. Nonaktifkan Customer**
- Actor menekan Edit pada profil customer.
- Actor menekan `[Nonaktifkan]`.
- Sistem meng-update `is_active = false` (Soft Delete) (BR-05.1).

## 4. Exception Flows
**4.1. Format WhatsApp Salah**
- Pada langkah 7, jika nomor diisi "abc" atau kurang dari 10 digit.
- Sistem menampilkan inline error: "Format WhatsApp tidak valid. Gunakan awalan 08 atau 628 dengan min 10 angka."

## 5. Postconditions
- Customer baru muncul di dropdown pemilihan customer saat membuat Order Baru (`PAGE-004`).

## 6. Related Pages
- `PAGE-013`: `/customers`
- `PAGE-004`: (Order Baru - mereferensikan customer)

## 7. Acceptance Criteria
- [ ] Validasi nomor WhatsApp ketat (angka saja, awalan 08/628, panjang 10-15 digit).
- [ ] Tombol WhatsApp berfungsi dengan memformat ulang 08 menjadi 628 secara otomatis (jika perlu) untuk intent.
- [ ] Penghapusan bersifat Soft Delete untuk mempertahankan histori order.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-016 | Customers | name, phone, address, is_active | String/Bool | |

## 9. Traceability
- **SRS Reference:** F05 (Manajemen Customer).
- **Pages:** PAGE-013.
