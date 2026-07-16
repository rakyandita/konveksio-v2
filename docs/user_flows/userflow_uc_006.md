# UC-006: Update Progres Mandiri (Karyawan)

## 1. Metadata
- **ID:** UC-006
- **Name:** Update Progres Tugas Tanpa Handover
- **Actor:** Karyawan
- **Trigger:** Karyawan telah menyelesaikan sebagian tugas harian namun belum ingin/perlu menyerahkannya (Handover) ke divisi selanjutnya.
- **Pre-conditions:** Karyawan memiliki Tugas Aktif.

## 2. Main Flow (Skenario Utama)
1. Actor membuka halaman **Tugas Aktif** (`PAGE-010`).
2. Actor memilih tugas yang sedang dikerjakan. Sistem membuka **Detail Tugas** (`PAGE-011`).
3. Actor melihat sisa target Qty per size yang harus dikerjakan.
4. Actor menekan tombol `[Update Progres]`.
5. Sistem menampilkan form input Qty Aktual per Size.
6. Actor memasukkan angka Qty yang telah selesai (misal S=5, M=5).
7. Actor menekan tombol `[Simpan Progres]`.
8. Sistem memvalidasi bahwa Qty input ≤ sisa target.
9. Sistem menyimpan progres dan mengurangi sisa target tugas.
10. Sistem menampilkan *snackbar* sukses.

## 3. Alternative Flows
**3.1. Progres Penuh (Selesai)**
- Pada langkah 6, Actor memasukkan angka Qty yang persis sama dengan sisa target.
- Pada langkah 9, sistem menandai Tugas tersebut berstatus "Selesai", dan menginstruksikan Actor untuk melakukan *Handover* (UC-003) agar barang berpindah.

## 4. Exception Flows
**4.1. Input Melebihi Sisa Target**
- Pada langkah 8, sistem mendeteksi input Qty (S=10) melebihi sisa target (S=8).
- Sistem memblokir aksi dan menampilkan pesan error merah: "Qty melebihi sisa target. Sisa maksimal untuk S adalah 8."

## 5. Postconditions
- Angka barang selesai (*completed quantity*) bertambah, dan sisa target berkurang.
- Data ini tercermin pada ringkasan Pcs Selesai di Dashboard Karyawan (`PAGE-008`).

## 6. Related Pages
- `PAGE-010`: `/karyawan/tasks`
- `PAGE-011`: `/karyawan/tasks/:id`
- `PAGE-008`: `/karyawan/home`

## 7. Acceptance Criteria
- [ ] Karyawan dapat menginput progres per size.
- [ ] Sistem menolak input progres yang melebihi sisa target tugas.
- [ ] Riwayat *update* progres terekam dan bisa dilihat oleh Boss Cabang (Traceability).

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-003 | Task | RemainingQty, CompletedQty | JSON | - |
| ENT-004 | TaskProgress | QtyInput | JSON | Riwayat update |

## 9. Traceability
- **SRS Reference:** FR-07.2 (Pencatatan progres oleh pekerja).
