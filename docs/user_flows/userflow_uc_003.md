# UC-003: Handover & Auto-Task

## 1. Metadata
- **ID:** UC-003
- **Name:** Handover Fisik & Pembuatan Auto-Task (Model C)
- **Actor:** Karyawan (Pengirim), Karyawan (Penerima), Boss Cabang (Vendor / Resolusi)
- **Trigger:** Karyawan telah selesai mengerjakan tugasnya dan menyerahkan fisik barang ke tahap produksi selanjutnya.
- **Pre-conditions:** Pengirim memiliki Tugas Aktif (Task) yang belum diserahterimakan sepenuhnya.

## 2. Main Flow (Skenario Utama Karyawan → Karyawan)
1. Pengirim (Budi) menekan tombol `[Buat Handover]` dari halaman Detail Tugasnya.
2. Pengirim memilih Penerima Spesifik dari daftar nama Karyawan aktif (misal: Siti).
3. Pengirim menginput jumlah Qty per Size yang diserahkan secara fisik (misal S=10, M=15).
4. Pengirim menekan `[Kirim Handover]`.
5. Sistem mengubah status barang menjadi "Menunggu Konfirmasi" dan mengirim *push notification* (FCM) ke HP Siti.
6. Penerima (Siti) membuka menu **Kotak Masuk (Inbox)**.
7. Siti menekan item Handover dari Budi.
8. Siti menghitung fisik barang dan menginput Qty Aktual per Size yang diterimanya (misal S=10, M=15).
9. Siti menekan tombol `[TERIMA]`.
10. Sistem mencocokkan Qty Pengirim = Qty Penerima. Data cocok (*No Discrepancy*).
11. Sistem mencatat Handover sukses dan mengirim notifikasi kembali ke Budi ("Penyerahan Diterima").
12. **Auto-Task:** Sistem secara otomatis menciptakan *Task* baru untuk Siti dengan target S=10, M=15 dan mengunci tarif borongan (*snapshot*) Siti pada detik itu.

## 3. Alternative Flows
**3.1. Handover ke Vendor (Vendor Route)**
- Pada langkah 2, Budi memilih entitas "Vendor" (misal CV Sablon Jaya).
- Budi menginput Qty per Size dan menekan `[Kirim]`.
- Sistem **me-route** notifikasi ke Kotak Masuk Boss Cabang/Admin, bukan ke vendor (BR-07.7).
- Boss Cabang membuka Kotak Masuk, memvalidasi surat jalan fisik ke vendor, lalu menekan `[TERIMA]` atas nama vendor.
- Sistem membuat *Vendor Task* (bukan *Task* biasa) yang biayanya lump-sum.

**3.2. Tarik Kembali / Batal (Sender Cancel Flow)**
- Pada langkah 5, Handover berstatus "Menunggu Konfirmasi" (`pending`).
- Budi menyadari ada salah hitung. Siti belum membuka aplikasinya.
- Budi masuk ke menu Riwayat Handover dan menekan tombol `[Tarik Kembali / Batal]`.
- Sistem membatalkan Handover dengan menghapus record tersebut (Hard Delete diperbolehkan untuk status `pending`). Barang kembali ke tanggung jawab Budi. Notifikasi di HP Siti ditarik/di-update jika memungkinkan.

**3.3. Boss Cabang Re-route (Admin Intervention)**
- Siti mendadak izin 3 hari dan tidak merespon Kotak Masuknya.
- Boss Cabang masuk ke Dashboard, melihat ada peringatan Handover dari Budi ke Siti berstatus *stuck*.
- Boss menekan tombol `[Alihkan / Re-route]` pada Handover tersebut dan memilih karyawan lain (Rina).
- Sistem memindahkan item Handover tersebut ke Kotak Masuk Rina.

## 4. Exception Flows
**4.1. Tolak Barang (Reject Flow)**
- Pada langkah 8, Siti melihat fisik barang salah pesanan/rusak fatal secara massal.
- Siti tidak menekan `[TERIMA]`, melainkan menekan tombol `[TOLAK]`.
- Sistem meminta Siti memilih/mengetik alasan penolakan (misal: "Barang cacat parah").
- Siti menekan konfirmasi tolak. Status Handover menjadi "Ditolak".
- Sistem mengembalikan tanggung jawab barang fisik ke pengirim (Budi). Budi dan Boss mendapat notifikasi insiden.

**4.2. Discrepancy (Selisih Fisik Kurang)**
- Pada langkah 8, Siti menghitung fisik dan hanya menemukan S=10, M=14 (kurang 1 pcs dari klaim Budi 15).
- Siti menginput aktual (S=10, M=14), lalu menekan `[TERIMA]`.
- Sistem mendeteksi selisih/discrepancy (BR-07.4).
- Sistem membuat Auto-Task untuk Siti sebesar angka aktual (S=10, M=14).
- Sistem **mengembalikan 1 pcs yang hilang ke sisa beban kerja Budi**.
- Budi wajib mencari 1 pcs tersebut dan menyusulkannya lewat Handover baru kelak.
- Sistem memunculkan *Alert Discrepancy* di Dashboard Boss Cabang untuk pengawasan lapangan.

## 5. Postconditions
- Tanggung jawab pengerjaan fisik pindah ke Karyawan Penerima.
- Auto-Task tercipta untuk Karyawan Penerima.

## 6. Related Pages
- `PAGE-010`: `/karyawan/tasks`
- `PAGE-013`: `/karyawan/handover`
- `PAGE-009`: `/karyawan/inbox`
- `PAGE-007`: `/boss/inbox`

## 7. Acceptance Criteria
- [ ] Pengirim tidak bisa mengirim Handover dengan angka Qty melebihi sisa tugas yang belum diserahkannya.
- [ ] Auto-Task langsung muncul di daftar "Tugas Aktif" penerima sesaat setelah mengklik `[TERIMA]`.
- [ ] Jika penerima adalah vendor, form Kotak Masuk hanya muncul di akun Boss/Admin.
- [ ] Selisih kurang saat penerimaan (Discrepancy) otomatis dikembalikan ke pengirim tanpa mengurangi *Target Order* global.
- [ ] Tombol `[TOLAK]` diwajibkan menyertakan alasan teks.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-008 | Handover | SenderID, ReceiverID, VendorID | UUID | Penerima bisa NULL jika ke vendor |
| ENT-009 | HandoverSize| Size Label, QtySent, QtyReceived| Str, Num | Pemecahan qty per size dari handover |
| ENT-008 | Handover | Status, RejectReason | String | pending, accepted, rejected |
| ENT-007 | Task | QtyPerSize, RateSnapshot | JSON, Num | Dibuat saat Accepted (Model C) |

## 9. Traceability
- **SRS Reference:** FR-07.3 (Handover & Batal/Re-route), BR-07.4 (Discrepancy), FR-10.3 (Kotak Masuk & Tolak), FR-07.6 (Vendor Task).
