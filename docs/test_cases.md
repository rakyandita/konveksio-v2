# Test Cases Catalog

**Project:** Konveksio v2
**Phase:** 7 (Testing & Validation)

Dokumen ini berisi katalog *Test Cases* yang diturunkan secara langsung dari *User Flows* (SoT #4) dan *System Logics* (SoT #7).

| Test ID | Kategori / Use Case | Deskripsi Pengujian | Kriteria Kelulusan (Acceptance Criteria) | Tipe |
|---------|---------------------|---------------------|------------------------------------------|------|
| TC-001 | UC-000 (Auth) | Login dengan akun *Boss Cabang* | Pengguna berhasil masuk dan diarahkan ke `/boss/home` | Manual UI |
| TC-002 | UC-000 (Auth) | Login dengan akun *Karyawan* | Pengguna berhasil masuk dan diarahkan ke `/karyawan/home` | Manual UI |
| TC-003 | UC-000 (Auth) | Login dengan kredensial salah | Aplikasi menampilkan pesan *error* sesuai spesifikasi | Manual UI |
| TC-004 | UC-001 (Order) | Menambahkan Order Baru dan SPK | Order berhasil tersimpan ke tabel `orders` dan tampil pada halaman Daftar Order | Manual UI |
| TC-005 | UC-002 (Assign) | Smart Bulk Assign ke Karyawan | Karyawan tujuan akan melihat tugas pada halaman Inbox-nya | Manual UI |
| TC-006 | UC-003 (Task) | Menerima Tugas (Handover) | Status tugas berubah menjadi *In Progress* pada *database* | Manual UI |
| TC-007 | UC-004 (Kasbon) | Mengajukan Kasbon melebihi batas (Karyawan) | Aplikasi menolak input atau menahan validasi *submit* | Manual UI |
| TC-008 | UC-004 (Kasbon) | Menyetujui Kasbon (Boss) | Status kasbon menjadi *Approved*, memotong sisa limit | Manual UI |
| TC-009 | UC-005 (Gaji) | Generate Slip Gaji Mingguan | Sistem mengakumulasi seluruh `progress_logs` yang di-*approve* dikurangi *Kasbon* | Manual UI |
| TC-010 | UC-006 (Progress) | Submit Progress secara parsial | Nilai `completed_qty` bertambah tanpa melebihi total target | Manual UI |
| TC-011 | UC-007 (Owner) | Pergantian Cabang (Branch Context) | Data yang ditampilkan pada *dashboard* dan seluruh rute beralih sesuai cabang yang dipilih | Manual UI |
| TC-012 | UC-009 (Branch) | Tambah/Edit Cabang | Owner berhasil merubah detail cabang pada `/owner/branches` | Manual UI |
| TC-013 | UC-011 (Karyawan) | Kelola Data Karyawan (Boss) | Perubahan nomor WA atau data profil tersimpan sukses | Manual UI |
| TC-014 | UC-012 (Produk) | Tambah Katalog Produk & Size | Master produk berhasil didaftarkan | Manual UI |

*Catatan: Test Cases di atas berfokus pada integrasi aliran utama (Happy Path) dan Edge Case terpenting.*
