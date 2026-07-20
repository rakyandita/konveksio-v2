# Phase 7: Test Plan (Testing & Validation)

**Project:** Konveksio v2
**Phase:** 7
**Status:** In Progress

## 1. Tujuan
Memastikan seluruh alur bisnis yang didefinisikan pada dokumen *User Flows* (UC-000 hingga UC-013) dan kontrak API/basis data pada *System Logics* (UCIC) telah diimplementasikan dengan benar pada fase sebelumnya (Fase 6). 

## 2. Cakupan Pengujian (Scope)
### In-Scope
1. **Functional Testing:** Menguji interaksi UI dan navigasi berdasarkan skenario pada User Flows (SoT #4).
2. **Integration Testing:** Memastikan interaksi antara UI, Provider (State Management), dan Supabase berjalan lancar (SoT #7).
3. **Automated Unit/Widget Testing:** Memvalidasi fungsi perhitungan khusus (seperti kalkulasi gaji, kalkulasi persentase kasbon, dan akumulasi progress) agar stabil.
4. **Role-Based Access Control (RBAC):** Memastikan bahwa hak akses Boss Cabang, Karyawan, dan Owner (termasuk *Branch Context Mode*) beroperasi dengan aman dan terisolasi.

### Out-of-Scope
- Stress/Load Testing (karena aplikasi ini dirancang untuk tim internal terbatas).
- Security Penetration Testing tingkat lanjut di luar pengujian Row Level Security (RLS) Supabase yang standar.

## 3. Strategi Pengujian (Test Approach)

1. **Persiapan Data Uji:**
   - Karena telah terintegrasi dengan Supabase asli, pengujian akan menggunakan Cabang Uji atau Data Dummy pada environment *Development*.
   - Tidak ada modifikasi langsung pada *production database*.

2. **Eksekusi Pengujian Otomatis (Automated):**
   - Menulis *Unit Test* dengan Dart (`flutter test`) untuk layer *Repository*.
   - Mengeksekusi pengujian pada `TaskRepository` dan `SalaryRepository`.

3. **Eksekusi Pengujian Manual (Manual/UAT):**
   - Melalui verifikasi visual dan klik-per-klik menggunakan Emulator/Chrome *debug mode*.
   - Mencocokkan perilaku sistem dengan purwarupa *HiFi* (SoT #5).

4. **Kriteria Kelulusan (Acceptance Criteria):**
   - 100% *Test Cases* dengan prioritas *High/Critical* harus memiliki status **PASS**.
   - Tidak boleh ada *error* kompilasi atau `flutter analyze` yang tertinggal.
   - Peringatan (*Warning*) pada UI (misal *RenderFlex overflow*) harus diminimalkan.

## 4. Peran dan Tanggung Jawab
- **Agent (AI):** Menulis skrip pengujian otomatis, menyiapkan data dummy via *Repository*, mengeksekusi *Automated Tests*, serta mendokumentasikan hasil pengujian.
- **User:** Memvalidasi hasil pengujian UI secara manual (UAT), mengonfirmasi skenario, dan memberikan persetujuan final (Sign-off).
