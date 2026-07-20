# [Fase 2 | SoT #4] UC-006: Update Progres Mandiri (Karyawan)

## 1. Metadata
- **ID:** UC-006
- **Name:** Update Progres Tugas Tanpa Handover
- **Actor:** Karyawan
- **Trigger:** Karyawan telah menyelesaikan sebagian tugas harian namun belum ingin/perlu menyerahkannya (Handover) ke divisi selanjutnya.
- **Pre-conditions:** Karyawan memiliki Tugas Aktif.

## 2. Main Flow (Skenario Utama)
1. Actor membuka halaman **Tugas Aktif** (`PAGE-010`).
2. Actor menekan tombol `[UPDATE PROGRES]` pada kartu tugas yang sedang dikerjakan.
3. Sistem memunculkan *Bottom Sheet Modal* form input Qty Aktual per Size.
4. Actor melihat informasi "Sisa Target" per size di atas setiap kolom input form.
5. Actor memasukkan angka Qty yang telah selesai (misal S=5, M=5).
6. Actor menekan tombol `[Simpan Progres]`.
7. Sistem memvalidasi bahwa Qty input ≤ sisa target.
8. Sistem menyimpan entitas *Progress Log* (append-only) dan memperbarui field `completed_qty` pada *Task Size*. Sisa target berkurang.
9. Sistem menutup *Bottom Sheet* dan menampilkan *snackbar* sukses.

## 3. Alternative Flows
**3.1. Progres Penuh (Selesai)**
- Pada langkah 6, Actor memasukkan angka Qty yang persis sama dengan sisa target.
- Pada langkah 9, sistem menandai Tugas tersebut berstatus "Selesai" (`completed`), dan menginstruksikan Actor untuk melakukan *Handover* (UC-003) agar barang berpindah.

## 4. Exception Flows
**4.1. Input Melebihi Sisa Target**
- Pada langkah 8, sistem mendeteksi input Qty (S=10) melebihi sisa target (S=8).
- Sistem memblokir aksi dan menampilkan pesan error merah: "Qty melebihi sisa target. Sisa maksimal untuk S adalah 8."

## 5. Postconditions
- Angka barang selesai (*completed quantity*) bertambah, dan sisa target berkurang.
- Data ini tercermin pada ringkasan Pcs Selesai di Dashboard Karyawan (`PAGE-008`).

## 6. Related Pages
- `PAGE-010`: `/karyawan/tasks`
- `MODAL-003`: `N/A` (Bottom Sheet Update Progress)
- `PAGE-008`: `/karyawan/home`

## 7. Acceptance Criteria
- [ ] Karyawan dapat menginput progres per size.
- [ ] Sistem menolak input progres yang melebihi sisa target tugas.
- [ ] Riwayat *update* progres terekam dan bisa dilihat oleh Boss Cabang (Traceability).

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-007 | TaskSize | TargetQty, CompletedQty | Num, Num | Melacak sisa target |
| ENT-011 | ProgressLog | QtyCompleted | Num | Riwayat update append-only |

## 9. Traceability
- **SRS Reference:** FR-07.2 (Pencatatan progres oleh pekerja).
