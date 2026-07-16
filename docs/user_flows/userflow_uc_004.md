# UC-004: Pengajuan Kasbon

## 1. Metadata
- **ID:** UC-004
- **Name:** Pengajuan & Persetujuan Kasbon (Cash Advance)
- **Actor:** Karyawan (Pengaju), Boss Cabang / Admin (Penyetuju)
- **Trigger:** Karyawan membutuhkan uang muka sebelum hari pembagian gaji.
- **Pre-conditions:** Karyawan memiliki status aktif dan limit kasbon yang mencukupi (tidak overlimit).

## 2. Main Flow (Skenario Utama)
1. Karyawan menavigasi ke halaman **Akun & Gaji** (Tab 4) di aplikasi mereka dan memilih menu "Kasbon".
2. Sistem menampilkan sisa Limit Kasbon Karyawan saat ini secara *real-time*.
3. Karyawan menekan tombol `[Ajukan Kasbon Baru]`.
4. Karyawan menginput nominal pengajuan (misal: Rp 100.000).
5. Sistem memvalidasi bahwa nominal input tidak melebihi sisa Limit Kasbon.
6. Karyawan menekan `[Kirim Pengajuan]`.
7. Status entitas kasbon menjadi "Menunggu Persetujuan". Sistem mengirim notifikasi *push* ke aplikasi Boss Cabang.
8. Boss Cabang membuka menu **Keuangan & SDM > Approval Kasbon**.
9. Boss melihat rincian pengajuan karyawan beserta catatan performa dan sisa limitnya.
10. Boss menekan `[SETUJUI]`.
11. Sistem mencatat transaksi kasbon sebagai aktif (Approved). Sistem otomatis mengurangi (reserve) saldo dompet kasbon karyawan.
12. Karyawan menerima notifikasi bahwa kasbon telah disetujui dan dapat mengambil fisik uangnya di kasir/admin.

## 3. Alternative Flows
**3.1. Penolakan oleh Boss**
- Pada langkah 10, Boss memilih untuk menekan `[TOLAK]`.
- Sistem meminta Boss memberikan alasan singkat (opsional, misal: "Belum ada progres kerja minggu ini").
- Status kasbon menjadi "Ditolak". Limit kasbon karyawan yang sebelumnya terkunci sementara (reserved) akan dikembalikan utuh. Notifikasi dikirim ke karyawan.

**3.2. Pencatatan Kasbon Manual oleh Admin (Bypass)**
- Karyawan tidak membawa HP dan meminta kasbon secara lisan langsung di ruang admin/kasir.
- Admin menavigasi ke menu **Keuangan > Detail Karyawan > Tambah Kasbon Manual**.
- Admin menginput nominal dan menekan `[Simpan]`.
- Kasbon langsung berstatus "Disetujui" tanpa perlu melewati proses status "Menunggu Persetujuan". Limit tetap dipotong.

## 4. Exception Flows
**4.1. Input Melebihi Limit**
- Pada langkah 4, Karyawan menginput nominal berlebih.
- Sistem mengecek *Current Gross Salary* (Gaji Sementara) minggu ini dan mengalikannya dengan `max_kasbon_percentage` (default 50%) dari `branch_settings`.
- Jika input Karyawan melampaui limit tersebut, sistem mendeteksi secara *real-time* dan mematikan (disable) tombol submit.
- Muncul teks *error inline* warna merah (Destructive): "Nominal melebihi sisa limit Anda (Maks Rp X)."

## 5. Postconditions
- Kasbon tercatat dengan status "Disetujui" atau "Ditolak".
- Saldo dompet limit karyawan terpotong jika disetujui.

## 6. Related Pages
- `PAGE-008`: `/karyawan/home` (Tab Kasbon)
- Halaman internal Boss (belum masuk spesifik ke route map, bagian dari Keuangan)

## 7. Acceptance Criteria
- [ ] Sistem tidak mengizinkan (*disable submit*) jika nominal pengajuan > sisa limit.
- [ ] Pengajuan yang sedang dalam status "Menunggu Persetujuan" harus langsung mengunci (*reserve*) saldo limit tersebut sementara agar karyawan tidak melakukan spam pengajuan berulang.
- [ ] Kasbon yang disetujui secara otomatis menjadi komponen pemotong di slip gaji minggu tersebut (terintegrasi ke UC-005).

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-006 | Employee | KasbonLimit, ReservedKasbon | Num, Num | Limit maksimal yang diatur oleh Boss |
| ENT-010 | CashAdvance | EmployeeID, Amount, Status | Rel, Num, Str | Status: Pending, Approved, Rejected |

## 9. Traceability
- **SRS Reference:** FR-08.1 (Manajemen Kasbon & Pengajuan), FR-08.2 (Approval & Restriksi Limit).
