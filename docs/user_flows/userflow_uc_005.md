# UC-005: Generate Gaji Mingguan

## 1. Metadata
- **ID:** UC-005
- **Name:** Generate Gaji Mingguan (Payroll)
- **Actor:** Boss Cabang, Owner (dalam Branch Context Mode)
- **Trigger:** Tiba hari akhir pekan (periode potong buku) di mana Boss perlu membagikan dan mencetak slip gaji karyawan.
- **Pre-conditions:**
  1. Terdapat tugas (*Task*) yang sudah diselesaikan dan direkap dalam minggu tersebut.
  2. **[WAJIB — RISK-05]** Tidak ada *Mutation Queue* yang masih pending di perangkat. Jika ada, sistem menampilkan dialog: *"Ada data progres yang belum tersinkronisasi. Tunggu sinkronisasi selesai agar kalkulasi gaji akurat."* dan memblokir proses Generate Gaji hingga antrean kosong.

## 2. Main Flow (Skenario Utama)
1. Boss Cabang menavigasi ke menu **Keuangan & SDM > Generate Gaji**.
2. Boss memilih periode cut-off (tanggal awal - tanggal akhir, default: 1 minggu terakhir).
3. Boss menekan tombol `[Hitung Gaji]`.
4. Sistem melakukan agregasi (*query*) seluruh Task yang berstatus "Selesai / Diterima" pada periode tersebut, dan mengalikannya dengan Tarif *Snapshot* yang terkunci pada masing-masing task.
5. Sistem menarik data seluruh transaksi Kasbon yang berstatus "Disetujui" (Approved) pada periode yang sama.
6. Sistem menampilkan daftar tabel Karyawan dengan kolom: Total Upah Kotor, Total Kasbon, dan Total Upah Bersih.
7. Boss memeriksa angka-angka tersebut untuk *Review* (Pratinjau).
8. Boss menekan `[Simpan & Terbitkan Slip]`.
9. Sistem menyimpan entitas *Payroll* secara permanen untuk periode tersebut.
10. Transaksi Kasbon yang berhasil memotong gaji akan diubah statusnya menjadi "Lunas" (*Settled*).
11. Sistem mengirim notifikasi kepada seluruh karyawan yang masuk daftar bahwa Slip Gaji mereka sudah terbit.
12. Karyawan dapat membuka menu **Akun & Gaji** untuk melihat rincian komponen slip gajinya.

## 3. Alternative Flows
**3.1. Penyesuaian / Bonus Manual**
- Pada langkah 7 (saat Review), Boss melihat ada karyawan yang berprestasi (misal lembur) atau perlu didenda (misal merusak barang).
- Boss menekan ikon `[+ Penyesuaian]` di baris karyawan tersebut.
- Boss menginput nominal (positif untuk bonus, negatif untuk denda) dan teks keterangan.
- Sistem langsung memperbarui Total Upah Bersih karyawan tersebut.
- Boss melanjutkan ke langkah 8.

**3.2. Owner Trigger Generate Gaji dalam Branch Context Mode (UF-10)**
- Owner aktif dalam Branch Context Mode pada salah satu cabang.
- Owner menavigasi ke menu Keuangan & SDM > Generate Gaji.
- Pada langkah 7 (Review), sebelum Owner menekan `[Simpan & Terbitkan Slip]`, sistem menampilkan **Dialog Konfirmasi Ekstra** (sesuai Design System Section 5.7 Lapisan 3):
  > *"⚠️ Anda akan menerbitkan slip gaji sebagai **Owner** yang mewakili cabang ini. Tindakan ini tidak dapat dibatalkan dan akan tercatat dalam audit log dengan identitas Anda. Lanjutkan?"*
- Owner menekan `[Ya, Terbitkan]`.
- Alur kembali ke langkah 9 dan seterusnya (identik dengan alur Boss Cabang).

**3.3. Penggajian Sistem Vendor (Vendor Lump Sum)**
- Sebelum masuk ke langkah 1, sistem mengecek `branch_settings.payment_system` milik cabang tersebut.
- Jika nilainya adalah `vendor_lump_sum`, maka konteks halaman berubah dari "Generate Gaji Karyawan" menjadi **"Generate Tagihan Vendor"**.
- Pada langkah 4, alih-alih mengagregasi data karyawan internal, sistem mengagregasi *Task* yang di- *assign* kepada entitas **Vendor** yang telah berstatus "Selesai".
- Langkah 5, 6, dan 7 berubah menjadi *Review Tagihan Vendor*, di mana yang dipotong bukan Kasbon Karyawan, melainkan uang DP (Down Payment) jika pernah diberikan kepada Vendor tersebut.
- Hasil cetak (Langkah 9) bukan Slip Gaji, melainkan **Bukti Pencairan Tagihan Vendor**.

## 4. Exception Flows
**4.1. Upah Minus (Kasbon Lebih Besar dari Upah Kotor)**
- Pada langkah 6, sistem mendeteksi Total Kasbon Karyawan > Total Upah Kotor yang dikerjakannya minggu ini.
- Baris karyawan tersebut di-*highlight* dengan warna peringatan. Total Upah Bersih diset minimal menjadi "Rp 0" (tidak ada uang tunai yang dibawa pulang).
- Sisa saldo Kasbon yang tidak ter-cover oleh upah minggu ini akan di-*carry over* (dibawa) sebagai hutang aktif yang akan memotong periode minggu berikutnya.
- Slip gaji menerangkan rincian pemotongan dan sisa hutang kasbon.

## 5. Postconditions
- Gaji mingguan terkalkulasi dan slip gaji tercetak secara permanen.
- Kasbon terpotong (menjadi lunas).

## 6. Related Pages
- Halaman internal Boss (bagian Keuangan)
- `PAGE-008`: `/karyawan/home` (Tab Riwayat Slip Gaji)

## 7. Acceptance Criteria
- [ ] Sistem mengkalkulasi upah HANYA dari Task yang secara sah sudah diserahterimakan (berstatus Handover Accepted) di rentang tanggal tersebut.
- [ ] Kalkulasi upah menggunakan tarif *snapshot* dari tabel Task, BUKAN tarif master data saat ini, untuk mencegah perubahan historis jika tarif di masa depan naik.
- [ ] Kasbon yang memotong gaji harus otomatis berstatus "Lunas" agar tidak memotong dua kali di minggu depan.
- [ ] Slip gaji yang sudah diterbitkan bersifat kekal (*immutable*).

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-007 | Task | Status, CompletedDate, Qty, Rate | Str, Date, Num, Num | Filter berdasar tgl selesai |
| ENT-009 | Kasbon | Status, Date, Amount | Str, Date, Num | Filter Approved & Unsettled |
| ENT-010 | Payroll | EmployeeID, Period, Gross, Deduction, Net | Rel, Str, Num, Num, Num | Rekam jejak permanen (Immutable) |

## 9. Traceability
- **SRS Reference:** FR-08.4 (Kalkulasi Otomatis Gaji Mingguan), FR-08.5 (Pemotongan Kasbon), FR-08.6 (Digital Slip Gaji).
