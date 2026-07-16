# SRS: Konveksio

**Document Version:** v3.0 | **Status:** ✅ FINAL (SoT #1 Approved) | **Last Updated:** 2026-07-16 | **Author:** Antigravity AI (Chain of Truth)

---

## 1. Introduction

### 1.1 Purpose
SRS ini adalah **System of Truth #1 (SoT-1)** dalam alur kerja *Chain of Truth* untuk aplikasi Konveksio. Dokumen ini menjadi rujukan tunggal yang mengikat untuk seluruh pengembangan V1 — dari desain database, implementasi backend Supabase, hingga pembangunan antarmuka Flutter. Setiap AI agent atau developer yang bekerja di proyek ini **wajib** membaca dokumen ini sebelum membuat keputusan teknis apapun.

### 1.2 Scope
Konveksio V1 mencakup manajemen operasional internal bisnis konveksi multi-cabang: siklus order, produksi paralel per divisi, penggajian borongan, kasbon karyawan, dan invoice digital.

**In Scope (V1):**
- Manajemen multi-cabang dengan isolasi data (Row Level Security).
- Pencatatan order, customer, dan katalog produk (dengan Size Group).
- Manajemen invoice dan pencatatan pembayaran bertahap.
- Tracking produksi dinamis (partial completion, handover antar divisi).
- Penggajian borongan per pcs dan manajemen kasbon dengan approval.
- Public link invoice (via PHP di shared hosting).
- Dashboard berbasis peran (Owner, Boss Cabang, Karyawan).

**Out of Scope (V1):**
- Laporan keuangan komprehensif (Laba Rugi, Arus Kas, Neraca).
- Manajemen stok/inventory bahan baku.
- Pemesanan online mandiri oleh customer.
- Aplikasi versi iOS dan Flutter Web.
- Integrasi payment gateway.

### 1.3 Stakeholders
| Stakeholder | Role | Involvement |
|-------------|------|-------------|
| Owner | Super Admin | Memantau semua cabang, konfigurasi awal, full access. |
| Boss Cabang | Manager Cabang | Mengelola order, tugas produksi, dan keuangan cabangnya. |
| Admin | Operator (hak dinamis) | Membantu input order & administrasi produksi. |
| Karyawan Produksi | Pelaksana | Update progres kerja, cek gaji dan kasbon sendiri. |

### 1.4 Definitions
| Term | Definition |
|------|-----------|
| Tenant / Cabang | Entitas operasional mandiri (contoh: Cabang Serang, Cabang Solo). |
| Size Group | Master data kelompok ukuran yang bisa dikonfigurasi (contoh: S/M/L/XL, SD/SMP/SMA, One Size). |
| Partial Completion | Karyawan dapat melaporkan penyelesaian sebagian dari total qty tugas yang diberikan. |
| Handover | Serah terima **barang fisik** dari satu divisi ke divisi berikutnya. Pengirim membuat Handover dengan menentukan **penerima spesifik (nama karyawan atau vendor)** dan **qty per size** yang diserahkan. Penerima mengkonfirmasi dengan menginput qty per size aktual yang diterima. Bersifat independen dari Assign. |
| Assign | Alokasi tugas produksi kepada karyawan tertentu: menentukan siapa mengerjakan apa, target qty, dan order mana. Digunakan sebagai alat **monitoring pipeline produksi**, bukan sebagai dasar langsung perhitungan gaji. Assign hanya wajib dilakukan di divisi pertama (kick-off); divisi berikutnya mendapat task otomatis dari konfirmasi Handover. |
| Bulk Assign | Fitur assign tugas ke **beberapa karyawan sekaligus** dalam satu aksi. Qty total dibagi secara merata atau sesuai angka yang disesuaikan manual oleh Boss/Admin. |
| Auto-Task | Task yang dibuat otomatis oleh sistem ketika seorang karyawan mengkonfirmasi Handover sebagai penerima. Tarif ongkos diambil dari master data karyawan penerima, qty per size dari yang dikonfirmasi diterima. |
| Vendor | Pihak eksternal (bukan karyawan tetap) yang menerima pekerjaan produksi saat kapasitas internal penuh. Di V1, vendor dicatat sebagai nama + biaya lump-sum per task tanpa akun aplikasi. |
| Kotak Masuk | Bagian di dashboard karyawan yang menampilkan Handover yang sudah dikirim pengirim dan menunggu konfirmasi penerima. Pekerjaan "datang" ke karyawan, bukan karyawan yang mengambil dari pool. |
| Upah Borongan | Pembayaran karyawan berdasarkan **jumlah pcs yang benar-benar diselesaikan** (dari Progress Log) × ongkos per pcs (tarif yang di-snapshot saat Assign atau Auto-Task). |
| Kasbon | Pinjaman dana di luar jadwal gaji; dipotong otomatis dari gaji mingguan. |
| Data Snapshot | Praktik menyalin nilai (misal tarif upah) ke dalam record transaksi pada saat transaksi dibuat, agar perubahan master data di masa depan tidak merubah histori. |
| Micro-deadline | Tenggat waktu per divisi dalam satu order, berbeda dari deadline global order. |
| Mutation Queue | Antrian perubahan data yang tersimpan lokal (SQLite) saat offline, untuk disinkronkan ke Supabase saat online. |
| Discrepancy | Selisih antara qty yang diserahkan dalam Handover dengan qty yang dikonfirmasi diterima oleh pihak penerima. |

### 1.5 References
- Chain of Truth Methodology (github.com/kasfulk/chain-of-truth)
- Konveksio Phase 1 Discovery (User Interview Logs, 2026-07-15)

---

## 2. Product Overview

### 2.1 Product Summary
> **"Biar Konveksio yang atur, kamu yang pantau."**

Konveksio adalah aplikasi Android *offline-first* berbasis SaaS untuk manajemen operasional bisnis konveksi. Dirancang dengan filosofi bahwa pekerjaan berulang dan birokratis di konveksi harus diambil alih oleh sistem — Boss Cabang tidak perlu jadi administrator produksi, cukup pantau dan putuskan. Aplikasi ini menjembatani kesenjangan komunikasi antara manajemen dan lantai produksi: memberikan transparansi *realtime* atas status pesanan, mengalirkan produksi secara estafet antar divisi tanpa perlu intervensi manual di setiap langkah, dan mengotomatisasi perhitungan upah borongan yang selama ini dikerjakan manual.

### 2.2 Business Goals
- **G1:** Go-live internal untuk 2 cabang (Serang & Solo) dalam **1 bulan** sejak pengembangan dimulai.
- **G2:** Menghilangkan kehilangan data order dan miskomunikasi status produksi antar divisi.
- **G3:** Mencapai kesiapan SaaS (multi-tenant untuk 10–20 konveksi lain) dalam **3 bulan**.

### 2.3 User Types / Roles
| Role | Description | Goals |
|------|-------------|-------|
| Owner | Pemilik bisnis, memiliki full access ke semua cabang | Melihat performa global semua cabang secara realtime. |
| Boss Cabang | Penanggung jawab satu cabang | Memastikan order selesai tepat waktu, approve kasbon, generate gaji. |
| Admin | Staff administrasi (hak akses dikonfigurasi oleh Boss Cabang) | Input data order, manajemen customer, administrasi produksi. |
| Karyawan Produksi | Tukang Potong/Jahit/Sablon/Finishing/dll. | Update progres kerja, melihat slip gaji dan saldo kasbon sendiri. |

### 2.4 Operating Environment
- **Frontend:** Flutter (Dart). Target V1: Android. iOS & Web masuk roadmap V2+.
- **Backend & Database:** Supabase Cloud (PostgreSQL, Auth JWT, Realtime WebSocket, Auto REST API).
- **File Storage:** Supabase Storage — untuk menyimpan gambar desain SPK (tampak depan, belakang, samping, atau detail lainnya).
- **Offline Storage:** SQLite via package `drift` di device pengguna. Gambar desain SPK di-cache lokal agar bisa diakses offline.
- **Push Notification:** Firebase Cloud Messaging (FCM).
- **Public Invoice:** PHP + DOMPDF di Shared Hosting, mengambil data dari Supabase REST API.
- **Min. Android Version:** Android 8.0 (API 26).

### 2.5 Assumptions
- Karyawan produksi di Cabang Serang dibayar dengan sistem borongan per pcs per divisi.
- Cabang Solo menggunakan model vendor/SPV: pembayaran lump-sum ke SPV, SPV mengatur internal karyawan.
- Semua karyawan produksi memiliki smartphone Android minimal untuk melaporkan progres.
- Setiap cabang beroperasi secara independen; tidak ada transfer order antar cabang.

### 2.6 Constraints
- **Data Isolation:** Data antar cabang terisolasi mutlak menggunakan Row Level Security (RLS) di Supabase. Satu pengguna tidak bisa mengakses data cabang lain.
- **Offline-First:** Pembuatan order dan update progres produksi harus bisa dilakukan tanpa koneksi internet.
- **Operasi Kritis Wajib Online:** Assign Tugas baru dan Generate Gaji wajib dalam kondisi online untuk mencegah konflik data sinkronisasi.
- **Budget:** Tidak menggunakan VPS; mengandalkan Supabase Free Tier dan Shared Hosting yang ada.
- **Tenant Scale:** Supabase Free Tier mendukung hingga ~20 tenant dengan data estimasi <500MB total.

---

## 3. System Features

### F01: Manajemen Cabang (Priority: High)
**Deskripsi:** Konfigurasi dasar entitas cabang sebagai fondasi isolasi data seluruh sistem.

**Functional Requirements:**
- FR-01.1: Owner dapat membuat, mengedit, dan menonaktifkan cabang.
- FR-01.2: Setiap cabang memiliki atribut: nama, alamat, nomor kontak.
- FR-01.3: Setiap pengguna (kecuali Owner) terikat pada satu `branch_id` dan tidak bisa berpindah cabang.

**Business Rules:**
- BR-01.1: Cabang yang sudah memiliki data aktif (order, karyawan) tidak dapat dihapus permanen — hanya bisa dinonaktifkan (Soft Delete).
- BR-01.2: Owner secara default memiliki **full access** ke semua data di semua cabang.

**Acceptance Criteria:**
- [ ] Owner membuat cabang baru → cabang muncul di daftar dan bisa digunakan untuk onboarding pengguna.
- [ ] Pengguna cabang Serang tidak bisa melihat data order cabang Solo.
- [ ] Menonaktifkan cabang tidak menghapus histori data.

---

### F02: Manajemen User, Role & Permissions (Priority: High)
**Deskripsi:** Manajemen akun pengguna dengan sistem hak akses dinamis untuk role Admin.

**Functional Requirements:**
- FR-02.1: Owner dan Boss Cabang dapat membuat akun pengguna baru di cabangnya.
- FR-02.2: Role yang tersedia: Owner, Boss Cabang, Admin, Karyawan Produksi.
- FR-02.3: Sistem menyediakan *Dynamic Permissions* untuk role Admin — Boss Cabang dapat mengaktifkan/menonaktifkan akses per modul (misal: "Boleh buat order", "Boleh lihat laporan").
- FR-02.4: Pengguna dapat dinonaktifkan tanpa menghapus data histori mereka.

**Business Rules:**
- BR-02.1: Karyawan Produksi secara default hanya dapat mengakses: tugas mereka, update progres, dan profil gaji/kasbon sendiri.
- BR-02.2: Boss Cabang tidak bisa membuat akun Owner — hanya Owner yang bisa membuat Owner lain.
- BR-02.3: Satu akun hanya terikat pada satu cabang (kecuali Owner).

**Acceptance Criteria:**
- [ ] Boss Cabang buat akun Admin baru, centang "Boleh buat order", uncentang "Boleh lihat laporan" → Admin bisa akses menu Order tapi tidak menu Laporan.
- [ ] Menonaktifkan akun karyawan → karyawan tidak bisa login, tapi riwayat kerja & gaji tetap tersimpan.

---

### F03: Manajemen Karyawan Produksi & Vendor (Priority: High)
**Deskripsi:** Pengelolaan profil pekerja internal, divisi, konfigurasi ongkos borongan, serta pencatatan vendor eksternal untuk kondisi kapasitas overload.

**Functional Requirements:**
- FR-03.1: Boss Cabang dapat CRUD data karyawan: nama, foto, divisi, ongkos per pcs per divisi, dan status aktif.
- FR-03.2: Satu karyawan dapat dikaitkan dengan lebih dari satu divisi (misal: bisa Cutting dan Jahit).
- FR-03.3: Boss Cabang dapat CRUD data **Vendor** eksternal: nama vendor, divisi keahlian, nomor WhatsApp kontak, dan catatan tarif (opsional, sebagai referensi).

**Business Rules:**
- BR-03.1: Karyawan tanpa divisi tidak dapat menerima assign tugas produksi.
- BR-03.2: Karyawan yang di-nonaktifkan tidak bisa menerima tugas baru, tapi riwayat kerja dan gaji tetap dapat dilihat.
- BR-03.3: Vendor **tidak memiliki akun aplikasi** — seluruh input progress dan konfirmasi handover vendor dilakukan oleh Boss Cabang atau Admin.

**Acceptance Criteria:**
- [ ] Boss Cabang tambah karyawan "Budi", divisi "Cutting", ongkos Rp 2.000/pcs → Budi muncul sebagai pilihan saat assign tugas divisi Cutting.
- [ ] Nonaktifkan Budi → Budi tidak muncul di pilihan assign tugas baru.
- [ ] Boss Cabang tambah vendor "CV Potong Jaya", divisi "Cutting", WA 08xxx → vendor muncul sebagai pilihan saat assign task ke vendor.

---

### F04: Katalog Produk & Size Groups (Priority: High)
**Deskripsi:** Master data produk yang tersedia di setiap cabang, dengan sistem grup ukuran yang fleksibel.

**Functional Requirements:**
- FR-04.1: Boss Cabang dapat CRUD katalog produk per cabang, dengan atribut: nama produk, kategori (Setelan/Non-Setelan), harga estimasi acuan (min–max), dan Size Group.
- FR-04.2: Boss Cabang dapat membuat dan mengelola Size Groups: nama grup + daftar ukuran di dalamnya (contoh: "Pakaian Standar" → S, M, L, XL, XXL, 3XL, 4XL, Custom).
- FR-04.3: Sistem menyediakan Size Group default saat cabang dibuat: "Pakaian Standar" dan "One Size".
- FR-04.4: Produk yang dinonaktifkan tidak muncul sebagai pilihan di form order baru.

**Business Rules:**
- BR-04.1: Setiap produk wajib memiliki Size Group. Produk tanpa ukuran menggunakan grup "One Size".
- BR-04.2: Size Group yang masih dipakai produk aktif tidak bisa dihapus.
- BR-04.3: Perubahan Size Group pada produk hanya berlaku untuk order baru; order yang sudah ada tidak terpengaruh.

**Acceptance Criteria:**
- [ ] Boss Cabang buat Size Group "Jenjang Sekolah" isi SD/SMP/SMA, assign ke produk "Tas Ransel" → saat order pilih Tas Ransel, muncul size picker SD/SMP/SMA.
- [ ] Produk "One Size" (misal: Dompet) → saat di order hanya muncul input qty tunggal.

---

### F05: Manajemen Customer (Priority: High)
**Deskripsi:** Database kontak pemesan untuk mempercepat proses pembuatan order.

**Functional Requirements:**
- FR-05.1: Boss Cabang dan Admin dapat CRUD data customer: nama lengkap, nomor WhatsApp, alamat pengiriman, dan catatan.
- FR-05.2: Nomor WhatsApp pada profil customer dapat diklik untuk membuka aplikasi WhatsApp secara langsung.
- FR-05.3: Halaman profil customer menampilkan riwayat semua order yang pernah dibuat.

**Business Rules:**
- BR-05.1: Customer data bersifat Soft Delete — tidak bisa dihapus permanen jika ada histori order.

**Acceptance Criteria:**
- [ ] Buat customer "CV Maju Jaya", simpan → saat buat order baru, "CV Maju Jaya" bisa dipilih dari daftar customer.
- [ ] Tap nomor WA customer → WhatsApp terbuka dengan nomor tersebut sudah terisi.

---

### F06: Manajemen Order & Tagihan (Priority: High)
**Deskripsi:** Inti sistem untuk mencatat pesanan, tagihan customer, dan pembayaran bertahap.

**Functional Requirements:**
- FR-06.1: Pembuatan order: pilih customer, tambahkan item produk dari katalog (qty per size, harga final per pcs), tanggal deadline, dan catatan.
- FR-06.2: Order memiliki state machine status yang eksplisit (lihat Business Rules BR-06.3).
- FR-06.3: Pencatatan pembayaran bertahap (DP, cicilan, pelunasan) dengan histori tanggal dan nominal.
- FR-06.4: Generate public link invoice berformat `[domain]/invoice/[unique-token]` untuk dikirim ke customer via WhatsApp.
- FR-06.5: Download PDF invoice secara langsung di HP (on-device rendering via Flutter, tanpa server).
- FR-06.6: Halaman detail order menampilkan **"Estimasi Margin"** = Total Harga Jual − (Σ qty_selesai_per_divisi × ongkos_snapshot) − Σ biaya_vendor_per_task. Nilai ini diperbarui secara dinamis seiring progress dan input biaya vendor, dan dapat berubah sampai order berstatus "Selesai". Hanya terlihat oleh Owner dan Boss Cabang.
- FR-06.7: Setiap Order Item dapat dilengkapi dengan **SPK (Surat Perintah Kerja)** — lihat F11.

**Business Rules:**
- BR-06.1: Pembuatan order dapat dilakukan secara offline; disinkronisasi ke Supabase saat koneksi tersedia.
- BR-06.2: Order hanya dapat dihapus bersih (Hard Delete) jika berstatus `draft` atau `cancelled` sebelum masuk produksi. Semua status lain menggunakan Soft Delete.
- BR-06.3: **State Machine Status Order** — transisi status yang valid:
  ```
  draft → confirmation → running → completed → shipped → done
                ↘ cancelled (hanya dari draft atau confirmation)
  ```
  > **Catatan i18n:** Nilai di atas adalah nilai enum database (Bahasa Inggris). UI menampilkan label Bahasa Indonesia:
  > `draft`→"Draft" | `confirmation`→"Konfirmasi" | `running`→"Produksi Berjalan" | `completed`→"Produksi Selesai" | `shipped`→"Dikirim" | `done`→"Selesai" | `cancelled`→"Batal"

  - `draft` → `confirmation`: oleh Boss Cabang/Admin setelah deal dengan customer.
  - `confirmation` → `running`: otomatis saat tugas produksi pertama di-assign.
  - `running` → `completed`: oleh Boss Cabang setelah semua divisi selesai.
  - `completed` → `shipped`: oleh Boss Cabang saat barang dikirim.
  - `shipped` → `done`: oleh Boss Cabang setelah lunas.
- BR-06.4: Total tagihan order dihitung otomatis dari (Qty × Harga Final) semua item.

**Acceptance Criteria:**
- [ ] Boss Cabang buat order offline → muncul di list order lokal → saat online, order sinkron ke Supabase.
- [ ] Tap "Kirim Invoice" → sistem generate link unik → Boss Cabang kirim link ke customer via WA.
- [ ] Customer buka link di browser → halaman invoice muncul dengan tombol "Download PDF".
- [ ] Order berstatus "Produksi Berjalan" tidak bisa dihapus — tombol hapus tidak muncul.

---

### F07: Tracking Produksi Dinamis (Priority: High)
**Deskripsi:** Alur kerja produksi berbasis partial completion dengan sistem handover antar divisi yang berurutan dan terverifikasi.

**Functional Requirements:**
- FR-07.1: **Smart Bulk Assign:** Boss Cabang/Admin mengalokasikan tugas produksi dengan memilih satu atau lebih karyawan sekaligus. Sistem menyarankan pembagian qty secara merata; Boss/Admin dapat menyesuaikan angka per karyawan sebelum konfirmasi. **Intervensi ini wajib di divisi pertama (kick-off)**, namun Boss Cabang/Admin tetap **dapat menggunakannya di divisi manapun kapan saja** untuk membagi paksa pekerjaan secara manual (misalnya redistribusi saat terjadi penumpukan/bottleneck).
- FR-07.2: **Update Progres:** Karyawan menginput qty yang telah diselesaikan (parsial diperbolehkan). Progress yang dicatat adalah **dasar perhitungan gaji**. Bisa dilakukan offline.
- FR-07.3: **Handover → Auto-Task (Model C):** Karyawan yang telah selesai membuat catatan serah terima dengan menentukan:
  - **Penerima spesifik**: nama karyawan (dari daftar aktif) atau nama vendor (dari master data). Tidak bisa ke "Divisi" global.
  - **Qty per size** yang diserahkan.
  **Logika Konfirmasi:**
  - **Ke Karyawan:** Penerima mendapat notif FCM real-time. Di Kotak Masuk, penerima input qty per size fisik aktual lalu tap `[TERIMA]` → sistem **otomatis membuat Task** (qty=dikonfirmasi, tarif=snapshot). Jika belum di-klik `[TERIMA]` (masih menggantung), pengirim bisa **Membatalkan (Tarik Kembali)**, atau Boss/Admin bisa melakukan **Re-route (Alihkan)** Handover tersebut ke karyawan lain.
  - **Ke Vendor:** Handover otomatis *by-pass* masuk ke Kotak Masuk Boss Cabang/Admin. Boss/Admin memvalidasi fisik lalu tap `[TERIMA]` atas nama vendor → memicu pembuatan Vendor Task (FR-07.6).
- FR-07.4: **Monitoring Pipeline:** Dashboard menampilkan pipeline produksi per order: qty di setiap divisi, progres aktual vs target, bottleneck, dan status micro-deadline per divisi.
- FR-07.5: **Akses SPK:** Karyawan yang menerima tugas dapat membuka SPK Order Item terkait langsung dari halaman tugas mereka, termasuk gambar desain (tersedia offline dari cache lokal).
- FR-07.6: **Vendor Task:** Boss Cabang/Admin dapat mengalokasikan task ke Vendor eksternal (bukan karyawan) saat kapasitas internal penuh. Boss/Admin menginput: nama vendor (dari master data), qty, dan biaya lump-sum. Progress vendor diinput oleh Boss/Admin; Handover dari vendor dikonfirmasi oleh Boss/Admin.

**Business Rules:**
- BR-07.1: Input progres tidak boleh melebihi qty tugas yang di-assign atau Auto-Task yang diterima. Jika dicoba, form memblokir dan tampil Toast: *"Progres melebihi target tugas."*
- BR-07.2: **Barang Cacat/Rework:** Pengembalian barang cacat (baik cacat produksi maupun bahan) diselesaikan secara fisik di luar aplikasi. Qty di aplikasi tidak perlu diubah karena mengacu pada qty order yang valid.
- BR-07.3: **Physical First + Size Detail:** Serah terima fisik harus disepakati per size sebelum dikonfirmasi di aplikasi. Pengirim input qty per size yang diserahkan; penerima input qty per size yang diterima secara fisik. Kedua data ini tersimpan di record Handover.
- BR-07.4: **Resolusi Discrepancy:** Jika qty yang diterima kurang dari yang diserahkan, sistem mencatat discrepancy. **Target order tidak boleh dikurangi.** Pengirim (misal Budi) **wajib menyusulkan** kekurangan tersebut. Selisih qty yang hilang/kurang dikembalikan menjadi beban kerja pengirim dan Boss Cabang dinotifikasi untuk memantau penyelesaiannya.
- BR-07.5: **Assign Tugas dan Auto-Task wajib online** untuk mencegah konflik data sinkronisasi.
- BR-07.6: **Auto-Task dari Handover:** Saat karyawan mengkonfirmasi Handover, sistem membuat Task baru secara otomatis. Qty per size Task = qty per size yang dikonfirmasi diterima. Tarif ongkos = snapshot dari master data karyawan penerima pada saat konfirmasi. Boss/Admin tetap dapat menambah atau memodifikasi task secara manual jika diperlukan.
- BR-07.7: **Vendor tidak punya akun:** Semua aksi terkait task vendor (input progress, konfirmasi handover) dilakukan oleh Boss Cabang atau Admin. Biaya vendor dicatat sebagai pengurang estimasi margin order.
- BR-07.8: **Handover ke penerima spesifik wajib.** Pengirim tidak dapat membuat Handover ke "Divisi" secara global. Jika ada beberapa penerima untuk satu batch pekerjaan, pengirim membuat Handover terpisah untuk masing-masing penerima dengan qty per size yang masing-masing sesuai.

**Acceptance Criteria:**
- [ ] Boss Cabang pilih divisi Cutting, centang Budi dan Andi, sistem suggest 50 pcs each → Boss konfirmasi → 2 Task Cutting terbuat sekaligus.
- [ ] Budi selesai potong → buat Handover ke Siti (Jahit): S=20, M=30 → Siti terima notif FCM real-time → Siti buka app, konfirmasi S=20, M=30 → sistem buat Auto-Task Jahit untuk Siti (S=20, M=30).
- [ ] Budi buat Handover ke Siti: S=20, M=30. Siti konfirmasi S=19, M=29 (beda 2 pcs) → discrepancy tercatat → Boss Cabang terima notif discrepancy.
- [ ] Boss assign task ke Vendor "CV Potong Jaya" S=50 M=100 L=50, biaya Rp 500.000 → task vendor muncul di pipeline monitoring.
- [ ] Karyawan mencoba input progres melebihi qty task → form menolak + Toast tampil.

---

### F08: Penggajian & Kasbon (Priority: High)
**Deskripsi:** Modul finansial karyawan: perhitungan upah borongan otomatis, pengajuan kasbon dengan approval, dan potongan kasbon dari gaji mingguan.

**Functional Requirements:**
- FR-08.1: **Kasbon:** Boss Cabang mengatur persentase maksimal potongan kasbon per karyawan di halaman pengaturan (default: 50% dari Gaji Kotor). Karyawan mengajukan nominal kasbon beserta alasan (pilihan: Kebutuhan Harian, Sekolah Anak, Listrik/Air, Kesehatan, Lainnya). Boss Cabang dapat Tolak, Setujui Penuh, atau Setujui sebagian (ubah nominal).
- FR-08.2: **Penggajian:** Sistem menghitung upah otomatis berdasarkan **Progress Log**: Total Pcs Selesai yang dilaporkan karyawan × Ongkos per Pcs (tarif yang di-snapshot saat Assign). Penghitungan mencakup seluruh Progress Log yang telah terkonfirmasi **hingga saat Generate Gaji ditekan** — tidak menunggu order selesai.
- FR-08.3: Boss Cabang menekan tombol **"Generate Gaji Minggu Ini"** → sistem memotong kasbon yang sudah disetujui dari gaji kotor → menghasilkan slip gaji digital.
- FR-08.4: Karyawan dapat melihat slip gaji mingguan dan saldo total kasbon mereka sendiri.
- FR-08.5: Model Vendor/SPV (Cabang Solo): Boss Cabang mencatat pembayaran lump-sum ke SPV, tanpa detail per karyawan.

**Business Rules:**
- BR-08.1: **Limit Potongan Kasbon:** Potongan kasbon per minggu tidak melebihi persentase yang dikonfigurasi Boss Cabang. Sisa kasbon yang belum terpotong dilanjutkan ke minggu berikutnya.
- BR-08.2: **Sistem Solo:** Karyawan di cabang dengan model Vendor/SPV tidak memiliki akses fitur kasbon individual. Seluruh transaksi finansial dicatat sebagai pembayaran ke entitas SPV.
- BR-08.3: **Data Snapshot:** Ongkos per pcs (tarif) disalin dan dikunci ke dalam record tugas saat tugas di-assign. Perubahan tarif ongkos di master data karyawan tidak merubah tarif tugas yang sudah ada. Qty gaji tetap mengacu pada Progress Log (qty selesai aktual), bukan target qty Assign.
- BR-08.4: **Generate Gaji wajib online** untuk memastikan data progres seluruh karyawan sudah tersinkronisasi sebelum dihitung.
- BR-08.5: **Jadwal Penggajian:** Generate Gaji dilakukan setiap **Sabtu sore**. Sistem menghitung seluruh pcs yang sudah diselesaikan dan tercatat dalam Progress Log hingga saat tombol ditekan. Karyawan yang baru menyelesaikan pcs setelah tombol ditekan akan masuk ke perhitungan minggu berikutnya.

**Acceptance Criteria:**
- [ ] Karyawan ajukan kasbon Rp 200.000 → Boss Cabang modifikasi jadi Rp 150.000 → Karyawan terima notif "Kasbon disetujui sebagian: Rp 150.000".
- [ ] Generate Gaji: Gaji Kotor Rp 300.000, Kasbon Rp 200.000, Limit 50% → sistem potong maks Rp 150.000 → Gaji bersih Rp 150.000, sisa kasbon Rp 50.000 dilanjut minggu depan.
- [ ] Ubah ongkos potong Budi dari Rp 2.000 ke Rp 2.500 → tugas Cutting yang sudah berjalan tetap terhitung Rp 2.000.

---

### F09: Notifikasi Realtime (Priority: Medium)
**Deskripsi:** Sistem notifikasi berbasis FCM untuk memastikan setiap aktor mendapat informasi yang relevan tanpa harus membuka aplikasi.

**Functional Requirements:**
- FR-09.1: Notifikasi dikirim untuk event berikut:
  - **Tugas baru di-assign** → ke karyawan yang di-assign
  - **Handover masuk** → ke penerima spesifik (real-time, 1 notif per Handover). Jika ke vendor, notif masuk ke Boss Cabang/Admin.
  - **Konfirmasi Handover** → ke pengirim (agar tahu bahwa penyerahannya diterima)
  - **Discrepancy Handover** → ke Boss Cabang
  - **Pengajuan Kasbon masuk** → ke Boss Cabang
  - **Hasil approval Kasbon** → ke Karyawan pengaju
  - **Hampir Deadline Order** → ke Boss Cabang + Karyawan aktif di order
- FR-09.2: Notifikasi **"Hampir Deadline"** dikirim **dua kali**: (1) saat pertama kali terdeteksi sisa waktu ≤ 3 hari, dan (2) pada H-1 sebelum deadline. Penerima: Boss Cabang **dan seluruh Karyawan yang memiliki tugas aktif** pada order tersebut.
- FR-09.3: Sistem menyimpan riwayat notifikasi di database dengan kolom `is_read` dan `read_at`.
- FR-09.4: Notifikasi yang belum dibaca ditampilkan sebagai badge/indikator di aplikasi.

**Business Rules:**
- BR-09.1: Notifikasi hanya dikirim ke pengguna yang relevan sesuai cabang dan role mereka (tidak ada cross-branch notification).
- BR-09.2: Notifikasi deadline **tidak dikirim** jika order sudah berstatus `completed`, `shipped`, atau `done`.

**Acceptance Criteria:**
- [ ] Karyawan menerima notif FCM saat tugas baru di-assign → buka aplikasi → tugas muncul di dashboard.
- [ ] Boss Cabang terima notif kasbon → approve → Karyawan terima notif hasil approval dalam < 5 detik.
- [ ] Order dengan deadline 2 hari lagi dan status "Produksi Berjalan" → Boss Cabang **dan** Karyawan yang punya tugas aktif di order itu masing-masing terima notif "Hampir Deadline".
- [ ] Order yang sama, H-1 deadline → pihak yang sama masing-masing terima 1 notif lagi.
- [ ] Order berstatus "Produksi Selesai" → notif deadline tidak dikirim meski deadline belum lewat.

---

### F10: Dashboard Role-Based (Priority: High)
**Deskripsi:** Halaman utama berorientasi aksi yang berbeda untuk setiap peran, dengan format Grid Menu untuk navigasi cepat.

**Functional Requirements:**
- FR-10.1: **Dashboard Owner:** Summary global semua cabang (total order aktif, total invoice belum lunas, order stuck per cabang), Kartu Cabang (menampilkan ringkasan performa tiap cabang). Owner dapat mengetuk Kartu Cabang untuk masuk ke **Branch Context Mode** — sebuah mode operasional di mana UI beralih menjadi identik dengan tampilan Boss Cabang pada cabang tersebut. Dalam mode ini, Owner dapat membuat Order, melakukan Smart Assign, mengakses Kotak Masuk, dan fungsi operasional lainnya. Header aplikasi menampilkan *context indicator* ("Sedang di: Cabang X") dan tombol keluar konteks. **Generate Gaji dalam Branch Context Mode** memerlukan dialog konfirmasi tambahan karena merupakan operasi finansial yang sensitif (lihat BR-01.2).
- FR-10.2: **Dashboard Boss Cabang:** Summary cabang sendiri (order aktif, produksi berjalan, invoice overdue), peringatan order deadline < 3 hari, peringatan tugas stuck > 48 jam, Grid Menu akses cepat ke semua modul.
- FR-10.3: **Dashboard Karyawan:** Dirancang untuk memotivasi dan memudahkan aksi cepat, terdiri dari:
  - **Sapaan + Motivasi Divisi**: Sapaan personal (nama karyawan) + pesan motivasi berbasis data total qty antrian divisi saat ini (misal: *"Ada 480 pcs menunggu dijahit — ayo gas! 🔥"*). Intensitas pesan menyesuaikan volume antrian.
  - **Kotak Masuk (Handover Menunggu Konfirmasi)**: Daftar Handover yang masuk dan belum dikonfirmasi. Setiap item menampilkan: pengirim, order terkait, qty per size yang diserahkan, serta dua tombol:
    - **[TERIMA]**: Konfirmasi qty per size aktual (memicu Auto-Task).
    - **[TOLAK]**: Menolak seluruh barang (wajib input alasan, misal "Barang cacat fatal / salah pesanan"). Jika ditolak, barang kembali menjadi tanggung jawab pengirim dan Boss dinotifikasi.
  - **Tugas Aktif**: Daftar task yang sedang dikerjakan beserta form update progres cepat per size.
  - **Ringkasan Minggu Ini**: Total pcs selesai minggu ini, estimasi upah saat ini, dan proyeksi upah jika target tertentu tercapai.

**Business Rules:**
- BR-10.1: Peringatan "Hampir Deadline" muncul jika sisa waktu order ≤ 3 hari dan produksi belum selesai.
- BR-10.2: Peringatan "Stuck" muncul jika tugas aktif tidak ada update progres selama > 48 jam.

**Acceptance Criteria:**
- [ ] Boss Cabang buka app → langsung lihat "2 order hampir deadline" dan "1 tugas stuck" di dashboard tanpa harus buka menu lain.
- [ ] Karyawan buka app → tampil sapaan dan pesan motivasi sesuai volume antrian divisi → tampil Kotak Masuk jika ada Handover menunggu → tampil tugas aktif dan bisa update progres per size dari dashboard.
- [ ] Siti terima notif FCM Handover → buka app → Kotak Masuk menampilkan Handover dari Budi (S=20, M=30) → Siti tap [TERIMA] → input S=20, M=30 → Auto-Task terbuat → Kotak Masuk kosong kembali.

---

### F11: SPK Digital — Surat Perintah Kerja (Priority: High)
**Deskripsi:** Dokumen teknis produksi per Order Item yang menjadi pegangan karyawan di lantai produksi. SPK memuat spesifikasi lengkap: instansi/klien, bahan, warna, model, dan gambar desain tampak depan & belakang.

**Functional Requirements:**
- FR-11.1: Boss Cabang/Admin dapat membuat SPK untuk setiap Order Item saat atau setelah order dibuat.
- FR-11.2: SPK memuat field: nama instansi/klien, jenis bahan, warna, model/style, catatan khusus, gambar desain tampak depan (opsional), gambar desain tampak belakang (opsional).
- FR-11.3: Gambar desain SPK dapat diunggah dari galeri HP atau kamera langsung. Sebelum diunggah ke Supabase Storage, Flutter melakukan **kompresi otomatis client-side** (format WEBP, dimensi maks 1920 px di sisi terpanjang) sehingga ukuran file tersimpan maksimal **≤ 1 MB** per gambar. Kualitas gambar tetap tajam di layar HP.
- FR-11.4: Karyawan yang memiliki tugas aktif pada order tersebut dapat membuka SPK dari halaman tugas mereka (Read-only).
- FR-11.5: Gambar desain SPK di-cache secara lokal di HP karyawan saat tugas di-assign, agar dapat diakses tanpa koneksi internet di lantai produksi.
- FR-11.6: SPK dapat dicetak atau diunduh sebagai PDF oleh Boss Cabang/Admin.

**Business Rules:**
- BR-11.1: SPK bersifat **opsional** per Order Item — order tetap bisa dibuat dan diproses tanpa SPK. Namun Boss Cabang akan mendapat pengingat jika order masuk ke status "Produksi Berjalan" tanpa SPK terlampir.
- BR-11.2: SPK hanya dapat diubah selama order belum berstatus "Produksi Selesai". Setelah itu, SPK dikunci sebagai rekaman historis.
- BR-11.3: Gambar SPK disimpan di Supabase Storage dengan akses terkontrol (hanya pengguna cabang terkait yang bisa mengakses URL gambar).
- BR-11.4: Karyawan Solo (model SPV) tetap dapat melihat SPK sebagai referensi produksi, meskipun tidak memiliki fitur kasbon.

**Acceptance Criteria:**
- [ ] Boss Cabang buat SPK untuk Order Item "Kaos Sekolah SDN 01": isi bahan Cotton Combed 30s, warna Putih, model Polo, upload gambar depan & belakang → tersimpan.
- [ ] Karyawan Budi (Cutting) terima tugas → buka halaman tugas → tap "Lihat SPK" → muncul spesifikasi + gambar desain tanpa perlu internet.
- [ ] Order masuk "Produksi Berjalan" tanpa SPK → Boss Cabang dapat pengingat "SPK belum dilengkapi untuk [nama produk]".
- [ ] Setelah order "Produksi Selesai" → tombol edit SPK tidak muncul (read-only).

---

## 4. Data Requirements
| Object | Description | Owner | Lifecycle |
|--------|-------------|-------|-----------|
| Branch | Cabang operasional | Owner | Dibuat Owner, dinonaktifkan jika tidak operasional |
| User | Akun pengguna aplikasi | Owner / Boss Cabang | Dibuat Boss, dinonaktifkan saat keluar kerja (Soft Delete) |
| Employee | Profil karyawan produksi | Boss Cabang | Dibuat dan dikelola Boss Cabang, Soft Delete |
| Customer | Data pemesan | Boss / Admin | Dibuat saat order pertama, Soft Delete |
| Product | Item di katalog cabang | Boss Cabang | Dibuat Boss, Soft Delete jika dihentikan |
| Size Group | Konfigurasi kelompok ukuran | Boss Cabang | Dibuat Boss, tidak bisa dihapus jika masih dipakai produk |
| Order | Pesanan dari customer | Boss / Admin | `draft` → ... → `done` (lihat State Machine F06 BR-06.3) |
| Order Item | Item produk dalam satu order | Sistem (dari Order) | Mengikuti lifecycle Order |
| **SPK** | Surat Perintah Kerja per Order Item | Boss / Admin | Dibuat saat atau setelah order dibuat, dikunci setelah status order `completed` |
| Payment | Rekaman pembayaran per termin | Boss / Admin | Append-only, tidak bisa dihapus |
| Task | Tugas produksi per divisi — alat monitoring target & alokasi karyawan | Boss / Admin / Sistem (Auto-Task) | Dibuat dari Assign atau Auto-Task dari Handover, status: `running` → `completed` |
| Vendor Task | Task produksi yang dialokasikan ke vendor eksternal | Boss / Admin | Dibuat saat kapasitas internal penuh, ditutup setelah handover vendor dikonfirmasi |
| Progress Log | Catatan update progres karyawan | Karyawan | Append-only, audit trail |
| Handover | Serah terima barang fisik antar divisi | Karyawan / Boss | Dibuat pengirim, dikonfirmasi penerima. Status: `pending` → `accepted`/`rejected` |
| Kasbon | Pengajuan pinjaman karyawan | Karyawan | Diajukan → Di-review Boss → status: `pending` → `approved`/`rejected` |
| Salary Record | Slip gaji mingguan | Sistem (dari Generate) | Generated setiap Sabtu, Read-only setelah dibuat |
| Notification | Riwayat notifikasi | Sistem | Append-only, tandai is_read |
| **Vendor** | Data vendor eksternal produksi | Boss Cabang | Dibuat Boss, Soft Delete |

### 4.2 Ownership Rules
- Semua objek bisnis memiliki kolom `branch_id` yang di-enforce oleh RLS di Supabase. Ini mencakup seluruh tabel transaksional termasuk `cash_advances` dan `salary_records` (didenormalisasi sejak Fase 4 — Schema v2).
- Owner dapat READ semua data di semua cabang. Owner dapat WRITE di semua cabang kecuali operasi yang secara eksplisit dibatasi (misal: generate gaji harus dilakukan oleh Boss Cabang yang mengenal kondisi lapangan cabangnya).
- **BR-01.2 (Branch Context Mode):** Mekanisme implementasi *full access* Owner di UI adalah melalui *Branch Context Switching*. Owner memilih satu cabang dari Global Dashboard, sistem mengaktifkan konteks cabang tersebut dengan menyuntikkan `acting_branch_id` ke dalam token/session, lalu UI beralih ke tampilan identik dengan Boss Cabang. RLS Supabase akan membaca `acting_branch_id` ini dan mengizinkan operasi baca/tulis Owner pada cabang terpilih. Saat Owner keluar dari konteks, `acting_branch_id` dihapus dari session.
- Payment dan Progress Log bersifat **append-only** — tidak ada mekanisme update atau delete.

### 4.3 Data Retention Rules
- Seluruh data inti menggunakan **Soft Delete** (`is_active = false` atau `deleted_at`).
- **Hard Delete diperbolehkan hanya untuk:** Order berstatus `draft` atau `cancelled` (nilai enum database; UI menampilkan "Draft" dan "Batal").
- Data Salary Record dan Payment tidak bisa dihapus dalam kondisi apapun — ini adalah catatan finansial permanen (append-only, tidak ada RLS policy untuk UPDATE/DELETE).

### 4.4 Data Validation Rules
- Nomor WhatsApp Customer: hanya angka, diawali `08` atau `628`, panjang 10–15 digit.
- Qty Order Item: bilangan bulat positif, minimum 1.
- Harga Final Order Item: bilangan desimal positif, tidak boleh 0.
- Progress qty: tidak boleh melebihi sisa qty tugas yang belum dilaporkan.
- Nominal kasbon: tidak boleh melebihi limit mingguan yang dikonfigurasi Boss Cabang untuk karyawan tersebut.
- Deadline order: tidak boleh di masa lalu saat order baru dibuat.
- Gambar SPK: format input JPG/PNG/WEBP, dikompres otomatis client-side (Flutter) sebelum upload ke format WEBP, dimensi maks 1920 px, ukuran tersimpan **≤ 1 MB** per file, resolusi minimum 400×400 px.

---

## 5. External Interfaces

### 5.1 UI Requirements
- Bahasa antarmuka: **Bahasa Indonesia** secara keseluruhan.
- Navigasi utama: **Grid Menu** (2×3 atau 3×3) di halaman dashboard setiap role.
- Input kasbon tidak menggunakan dropdown; menggunakan komponen pilihan yang lebih natural (dibahas di Fase 3 Design System).
- Responsif untuk layar Android 5–7 inci.
- Mendukung mode operasi dengan satu tangan (thumb-friendly layout) untuk karyawan produksi.

### 5.2 External Systems
| Sistem | Tujuan | Protokol |
|--------|--------|----------|
| Supabase (PostgreSQL) | Penyimpanan data utama | REST API (HTTPS) / Supabase Realtime (WebSocket) |
| Supabase Auth | Autentikasi pengguna | JWT Token via HTTPS |
| **Supabase Storage** | **Menyimpan gambar desain SPK** | **HTTPS (presigned URL)** |
| Firebase Cloud Messaging | Push notification | FCM SDK (Android) |
| Shared Hosting PHP | Render halaman public invoice | HTTP/HTTPS (request dari browser customer) |
| DOMPDF (di PHP) | Generate PDF invoice | Library PHP, berjalan di Shared Hosting |
| Flutter `pdf` package | Generate PDF invoice on-device | Dart package, berjalan di HP pengguna |

### 5.3 Communication Requirements
- Semua komunikasi antara Flutter app dan Supabase menggunakan **HTTPS** dan **JWT** yang dirotasi secara berkala.
- Public invoice link menggunakan **UUID v4** sebagai token — tidak sequential, tidak guessable.
- Supabase Realtime digunakan untuk update dashboard Boss Cabang secara live.
- Gambar desain SPK diakses via **presigned URL** dari Supabase Storage dengan masa berlaku terbatas. URL hanya bisa di-generate oleh pengguna yang terautentikasi di cabang yang sama.

---

## 6. Non-Functional Requirements

### 6.1 Performance
- Halaman dashboard utama harus termuat dalam < 2 detik (dari data SQLite lokal).
- Sinkronisasi background ke Supabase tidak boleh membekukan UI thread.
- Halaman public invoice (PHP) harus termuat dalam < 3 detik.

### 6.2 Security
- Autentikasi menggunakan JWT Supabase Auth; token disimpan secara aman di device storage Flutter.
- Row Level Security (RLS) di PostgreSQL adalah lapisan otorisasi utama — tidak boleh ada query yang bypass RLS.
- Public invoice token (UUID) hanya berlaku untuk data invoice yang aktif. Token yang sudah kadaluarsa atau di-revoke tidak bisa diakses.

### 6.3 Availability
- Supabase Cloud Free Tier: uptime ~99.9% (SLA tidak dijamin). Untuk V1 internal, ini dapat diterima.
- Aplikasi tetap bisa digunakan secara penuh untuk operasi baca (lihat tugas, cek gaji) saat Supabase tidak dapat dijangkau, karena data tersedia di SQLite lokal.
- **Risiko Inaktif:** Supabase Free Tier akan mem-*pause* project secara otomatis setelah 1 minggu tanpa aktivitas query. Untuk V1 internal yang digunakan harian, risiko ini dapat diabaikan. Mitigasi: jika ada periode libur panjang, Boss Cabang buka app sekali untuk men-trigger aktivitas.

### 6.4 Reliability
- Mutation Queue di SQLite memastikan tidak ada data yang hilang saat offline. Saat koneksi kembali, antrean diproses secara berurutan.
- Operasi kritis (Assign Tugas, Generate Gaji) menampilkan pesan error yang jelas jika koneksi tidak tersedia.

### 6.5 Scalability
- Arsitektur single-project Supabase dengan RLS mendukung hingga ~20 tenant dengan estimasi data total < 500 MB (batas Free Tier).
- Migrasi ke Supabase Pro ($25/bulan) tersedia kapan saja jika pertumbuhan data melebihi batas.

### 6.6 Maintainability
- Kode Flutter mengikuti arsitektur layered (UI, ViewModel/BLoC, Repository, Data Source).
- Skema database Supabase didokumentasikan di SoT #4 (Data Model) sebelum implementasi.

### 6.7 Usability
- Karyawan produksi baru harus bisa memahami cara update progres dalam ≤ 5 menit tanpa pelatihan formal.
- Setiap aksi destruktif (hapus, batalkan) menampilkan dialog konfirmasi sebelum dieksekusi.
- Pesan error ditulis dalam bahasa Indonesia yang mudah dipahami, bukan kode teknis.

---

## 7. Permissions and Access Control (RBAC Matrix)

> Owner memiliki **full access** ke semua cabang dan semua objek data. Tabel di bawah mendefinisikan akses untuk role lainnya dalam satu cabang.

| Objek Bisnis | Boss Cabang | Admin (Default) | Karyawan Produksi |
|---|---|---|---|
| **Cabang & Konfigurasi** | R, U (cabangnya) | - | - |
| **Katalog Produk & Size Group** | C, R, U, D | R | - |
| **Data Customer** | C, R, U, D | C, R, U | - |
| **Order & Tagihan** | C, R, U, D | C, R, U | - |
| **Assign Tugas Produksi (Kick-off)** | C, R, U, D | C, R, U (jika diberi izin) | R (tugas sendiri saja) |
| **Update Progress** | R, U (semua) | R, U (semua) | C, U (tugas sendiri saja) |
| **Buat Handover** | C, R (semua) | C, R (semua) | C (tugas divisi sendiri) |
| **Konfirmasi Handover (→ Auto-Task)** | C (semua) | C (semua) | C (karyawan aktif divisi penerima) |
| **Vendor Task** | C, R, U (semua) | C, R, U (jika diberi izin) | - |
| **SPK Digital** | C, R, U (selama belum Produksi Selesai) | C, R, U (jika diberi izin) | R (tugas aktifnya saja) |
| **Kelola Data Karyawan** | C, R, U, D | R | R (profil sendiri) |
| **Pengajuan Kasbon** | R, U (approve) | - | C (mengajukan milik sendiri) |
| **Konfigurasi Limit Kasbon** | C, R, U | - | - |
| **Generate Penggajian** | C, R | - | R (slip gaji sendiri saja) |
| **Notifikasi** | R, U (is_read) | R, U (is_read) | R, U (milik sendiri) |
| **Laporan & Dashboard** | R (cabangnya) | Tergantung Dynamic Permissions | R (data diri sendiri) |
| **Estimasi Margin per Order** | R (detail order) | - | - |

---

## 8. Feature Inventory

| Feature ID | Nama Fitur | Priority | Depends On | Status |
|---|---|---|---|---|
| F01 | Manajemen Cabang | High | — | Planned |
| F02 | Manajemen User, Role & Permissions | High | F01 | Planned |
| F03 | Manajemen Karyawan Produksi | High | F01, F02 | Planned |
| F04 | Katalog Produk & Size Groups | High | F01 | Planned |
| F05 | Manajemen Customer | High | F01 | Planned |
| F06 | Manajemen Order & Tagihan | High | F04, F05 | Planned |
| F07 | Tracking Produksi Dinamis | High | F03, F06, F11 | Planned |
| F08 | Penggajian & Kasbon | High | F03, F07 | Planned |
| F09 | Notifikasi Realtime (FCM) | Medium | F06, F07, F08 | Planned |
| F10 | Dashboard Role-Based | High | F06, F07, F08 | Planned |
| F11 | SPK Digital (Surat Perintah Kerja) | High | F06 | Planned |
| F12 | Manajemen Vendor (Simple) | Medium | F03, F07 | Planned |

---

## 9. Open Questions

> Semua Open Questions telah diselesaikan.

| ID | Pertanyaan | Keputusan |
|----|------------|----------|
| OQ-01 | Tampilkan estimasi margin per order? | **Ya**, ditampilkan di halaman detail order untuk Owner dan Boss Cabang saja. Admin dan Karyawan tidak melihat info ini. |
| OQ-02 | Kapan notifikasi Hampir Deadline dikirim? | **Dua kali**: saat pertama terdeteksi ≤ 3 hari, dan lagi di H-1 deadline. |

---

## 10. Future Considerations (V2+)

- **SaaS Multi-Tenant Onboarding:** Sistem registrasi mandiri untuk konveksi baru (tanpa perlu dibuatkan manual oleh Owner).
- **Laporan Keuangan:** Laba Rugi per periode, Arus Kas, dan Breakdown Margin aktual per Order.
- **Manajemen Stok Bahan Baku:** Tracking kain, benang, dan aksesoris dengan penurunan otomatis saat order dibuat.
- **Pemesanan Online Customer:** Form order mandiri untuk customer via web/link.
- **Platform iOS & Flutter Web:** Ekspansi platform setelah V1 Android stabil.
- **Integrasi Payment Gateway:** Untuk pembuktian pembayaran DP via transfer bank.
- **Manajemen Pengeluaran & Nota:** Upload foto nota pengeluaran operasional per cabang, dengan nominal, kategori, dan rekap bulanan.
- **Vendor Mode Lengkap (V2):** Akun aplikasi untuk vendor, tracking per pcs, laporan pembayaran vendor, dan integrasi vendor ke slip gaji/keuangan.

---

## 11. Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-07-15 | Antigravity AI | Initial version berdasarkan Phase 1 Discovery |
| 1.1 | 2026-07-15 | Antigravity AI | Resolusi edge cases: snapshot gaji, aturan hapus order, RBAC matrix, limitasi kasbon cabang Solo |
| 2.0 | 2026-07-15 | Antigravity AI | Restrukturisasi ke standar CoT 11-section; tambah Section 5, 8, 9, 10; Acceptance Criteria per fitur; State Machine Order (BR-06.3); aturan sync conflict (BR-07.5, BR-08.4); Owner full access; limit kasbon configurable; Data Validation Rules |
| 2.1 | 2026-07-15 | Antigravity AI | Close OQ-01 (margin per order → tampil untuk Owner & Boss saja) dan OQ-02 (notif deadline 2x: saat terdeteksi + H-1); update F09 dan RBAC |
| 2.2 | 2026-07-15 | Antigravity AI | Audit putaran 3: tambah FR-06.6 (estimasi margin formula), BR-08.5 (definisi minggu Senin–Minggu), notif deadline ke Karyawan (FR-09.2 + BR-09.2), AC F09 diperluas, hapus duplikat margin di Section 10, catatan risiko Supabase pause di 6.3 |
| 2.3 | 2026-07-15 | Antigravity AI | Tambah F11 SPK Digital (fitur wajib V1): FR, BR, AC, RBAC, Core Objects, Validation Rules, Supabase Storage di tech stack & external systems, presigned URL di 5.3, dependency F07 diupdate |
| 2.4 | 2026-07-15 | Antigravity AI | Ubah kebijakan gambar SPK: kompresi client-side Flutter (WEBP 1920px, ≤1MB tersimpan); tambah Manajemen Pengeluaran & Nota ke Future Considerations (V2) |
| 2.5 | 2026-07-15 | Antigravity AI | Audit putaran 4: fix header v2.5, perbaiki validasi gambar 5MB→≤1MB (Section 4.4 + FR-11.3), restore heading Section 4, tambah SPK di RBAC Matrix, tambah BR-07.6 (Handover independen dari Assign), update FR-08.2 + BR-08.5 (Generate Gaji Sabtu sore, tidak tunggu order selesai), fix BR-01.2 (full access), update Core Objects clarification |
| 2.6 | 2026-07-15 | Antigravity AI | Koreksi fundamental: Assign = alat monitoring (bukan dasar gaji); dasar gaji = Progress Log qty selesai aktual; revisi Definisi Assign & Upah Borongan; revisi FR-07.1–3 + BR-07.6 + BR-08.3; RBAC dipecah jadi 4 baris produksi dengan aturan akses yang jelas |
| 2.7 | 2026-07-15 | Antigravity AI | Tambah filosofi app (tagline); Smart Bulk Assign + Split Distribution (FR-07.1); Model C Auto-Task dari Handover (FR-07.3 + BR-07.6–7); Vendor Simple V1 (FR-03.3, FR-07.6, BR-03.3, BR-07.7, F12); update formula margin (FR-06.6 + biaya vendor); Vendor di Core Objects + RBAC + Feature Inventory; Vendor Mode Lengkap masuk V2 |
| 2.8 | 2026-07-15 | Antigravity AI | Handover wajib ke penerima spesifik (bukan divisi global) + qty per size (FR-07.3 + BR-07.3 + BR-07.8); Auto-Task qty per size (BR-07.6); notifikasi Handover real-time ke penerima spesifik (FR-09.1); Dashboard Karyawan: Kotak Masuk + Motivasi Divisi + Personal Stats (FR-10.3); AC F07 + F10 diperbarui; definisi Handover, Kotak Masuk, Auto-Task diperbarui |
| 2.9 | 2026-07-15 | Antigravity AI | Audit 5 Edge Cases: Tambah Batal/Re-route untuk Handover menggantung (FR-07.3); Handover Vendor di-route ke Kotak Masuk Admin/Boss (FR-07.3, FR-09.1); Wajib susulkan Discrepancy (BR-07.4); Tambah tombol TOLAK di Kotak Masuk (FR-10.3); Penegasan fungsi redistribusi Smart Bulk Assign (FR-07.1) |
| 3.0 | 2026-07-16 | Antigravity AI | **Sinkronisasi Database Schema v2 (Fase 4 Hardened):** (1) Semua nilai enum di-update ke Bahasa Inggris — `order_status`: draft/confirmation/running/completed/shipped/done/cancelled; `task_status`: running/completed; `handover_status`: pending/accepted/rejected. (2) State machine BR-06.3 diperbarui dengan nilai enum database + catatan i18n mapping ke UI. (3) BR-09.2 update referensi status. (4) Section 4.2 dikonfirmasi `cash_advances` & `salary_records` kini memiliki `branch_id` langsung (denormalisasi). (5) Section 4.3 Hard Delete rules update enum. (6) Core Objects table diperbarui dengan nilai enum dan lifecycle yang benar. |
