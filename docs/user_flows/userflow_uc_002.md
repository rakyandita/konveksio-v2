# UC-002: Smart Bulk Assign

## 1. Metadata
- **ID:** UC-002
- **Name:** Smart Bulk Assign
- **Actor:** Boss Cabang, Admin, Owner (dalam Branch Context Mode)
- **Trigger:** Boss/Admin memutuskan untuk memulai produksi pada Order yang siap, atau mendistribusi ulang tugas di divisi tengah yang mengalami bottleneck.
- **Pre-conditions:** Terdapat Order Item dengan sisa Qty yang belum di-assign. **Wajib online** (SRS BR-07.5).

## 2. Main Flow (Skenario Utama)
1. Actor membuka halaman **Order** atau **Produksi (Kanban)**.
2. Actor memilih Order Item yang ingin dialokasikan ke karyawan divisi pertama (misal: *Cutting*).
3. Actor menekan tombol `[Smart Assign]`.
4. Sistem menampilkan form dengan informasi sisa Qty yang belum di-assign (Total Qty Order Item).
5. Actor memilih satu atau lebih Karyawan (dari daftar karyawan aktif di cabang tersebut, misal: Budi dan Joko).
6. Sistem secara otomatis membagi sisa Qty secara merata per *size* ke setiap karyawan yang dipilih sebagai rekomendasi awal (misal 100 pcs dibagi 2 = 50 per orang).
7. Actor dapat menyesuaikan angka Qty per Size secara manual jika diperlukan (misal: mengurangi Budi menjadi 40, menambah Joko menjadi 60).
8. Actor menekan `[Konfirmasi Assign]`.
9. Sistem memvalidasi total Qty yang dialokasikan (tidak melebihi sisa target Order).
10. Sistem membuat entitas **Task** (Tugas) untuk masing-masing karyawan terpilih dengan menyimpan *snapshot* tarif (ongkos) dari master data pada saat itu.
11. Sistem mengirim notifikasi *push* (FCM) ke aplikasi Budi dan Joko ("Anda mendapat tugas baru...").
12. Jika ini adalah alokasi pertama untuk Order ini, status Order berubah dari `draft`/`confirmation` menjadi `running`.

## 3. Alternative Flows
**3.1. Assign Parsial (Sebagian Saja)**
- Pada langkah 7, Actor sengaja menginput total Qty yang lebih kecil dari sisa target (misal target 100, hanya di-assign 50).
- Sistem menyimpan Task sebesar 50 pcs.
- Halaman Detail Order menunjukkan "Sisa Belum Assign: 50 pcs".
- Actor dapat mengulangi alur ini kapan saja untuk menghabiskan sisa kuota.

**3.2. Intervensi Manual (Redistribusi Bottleneck)**
- Di tengah produksi (misal divisi *Jahit*), ada tugas yang tertunda. Actor ingin mendistribusikan paksa ke penjahit lain.
- Meskipun bukan di divisi pertama, Actor membuka Order Item dan menggunakan tombol `[Smart Assign]` ke divisi Jahit.
- Sistem memproses langkah 4-11 secara identik untuk menciptakan Task baru bagi penjahit pengganti. (FR-07.1).

## 4. Exception Flows
**4.1. Total Input Melebihi Target**
- Pada langkah 7, Actor mengedit input manual sedemikian rupa sehingga Budi = 60, Joko = 50 (Total 110), padahal target hanya 100.
- Sistem langsung mendeteksi secara *real-time* dan men-disable tombol `[Konfirmasi Assign]`.
- Muncul indikator merah *inline*: "Total melebihi target (Selisih +10)".

**4.2. Koneksi Internet Terputus**
- Sesuai aturan BR-07.5, proses assign *wajib online*.
- Pada langkah 8, koneksi putus saat menghubungi Supabase.
- Sistem menampilkan toast error: "Gagal menyimpan. Fitur Assign membutuhkan koneksi internet aktif," dan menahan pembuatan tugas.

## 5. Postconditions
- Entitas Task tercipta untuk setiap karyawan yang dipilih.
- Sisa target `Assigned Qty` dari Order Item berkurang.

## 6. Related Pages
- `PAGE-004`: `/boss/orders/:id`
- `PAGE-006`: `/boss/assign`
- `PAGE-010`: `/karyawan/tasks` (Bagi karyawan)

## 7. Acceptance Criteria
- [ ] Fitur membagi angka (per size) secara rata otomatis saat jumlah orang bertambah/berkurang di pilihan.
- [ ] Tombol *submit* terkunci (disabled) jika kalkulasi total Qty melebihi target tersedia.
- [ ] Task yang dihasilkan wajib menyertakan nilai `rate` (ongkos) pada detik itu (*snapshot*).
- [ ] Karyawan menerima notifikasi di aplikasinya seketika setelah assign selesai.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-003 | OrderItem | Target Qty, Assigned Qty | Number | Acuan batas atas (*ceiling*) |
| ENT-006 | Employee | ID, Name, Division, Rate | UUID, Str, Num | Memfilter karyawan aktif saja |
| ENT-007 | Task | EmployeeID, ItemID, QtyPerSize, RateSnapshot | Rel, JSON, Num | Diciptakan massal (*bulk insert*) |

## 9. Traceability
- **SRS Reference:** FR-07.1 (Smart Bulk Assign), BR-07.5 (Assign Wajib Online).
