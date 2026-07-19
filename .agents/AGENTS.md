# Aturan Global Antigravity Agent (Konveksio)

## 1. Kepatuhan Absolut Chain of Truth (CoT) & Source of Truth (SoT)
- DILARANG MENGARANG (HALUSINASI) arsitektur, UI, skema database, atau *API contract*. Segala sesuatu yang diimplementasikan harus memiliki jejak balik (*Traceability*) ke dokumen SoT lokal.
- **Wajib Baca Dokumen Lintas Lapis:** Sebelum membuat *Implementation Plan* untuk fitur apapun, Agent WAJIB melakukan pembacaan (`view_file`) secara eksplisit pada seluruh pilar SoT:
  1. `docs/srs.md` (Software Requirements Specification - Untuk batasan sistem & requirement absolut).
  2. `docs/information_architecture.md` (Untuk struktur navigasi & hirarki tata letak halaman).
  3. `docs/design_system.md` (Untuk token warna mutlak, tipografi, spasi, dan gaya komponen UI).
  4. `docs/data_model.md` (Untuk skema database Supabase, relasi tabel, tipe data, dan konvensi penamaan).
  5. `docs/user_flows/` (Untuk alur logika bisnis spesifik per *Use Case*).
  6. `docs/system_logics/` (Untuk *State Management*, sekuriti, dan *API Contract* per *Use Case*).
  7. `docs/prototype/` (Untuk memverifikasi bentuk visual, tata letak, dan komponen asli dari purwarupa).
- **Verifikasi Blueprint:** Agent dilarang menggunakan *layouting* atau arsitektur generik dari memori. Harus mengikuti struktur yang didefinisikan secara harfiah dalam 7 lapis dokumen di atas.

## 2. Aturan Gated Workflow (Paling Penting!)
- AGENT DILARANG KERAS mengeksekusi penulisan kode sumber (`write_to_file` pada `.dart`, dll) sebelum menyajikan dokumen **Implementation Plan**.
- Setiap kali ada perintah "implementasi", Agent WAJIB berhenti di fase perencanaan dan meminta User me-review Plan tersebut. Tanpa kata eksplisit seperti "Setuju", Agent dilarang keras mengubah kode proyek.

## 3. Aturan Sitasi (Source-Driven)
- Setiap penggunaan sintaks *framework* khusus (seperti Riverpod 2/3 `Notifier`, GoRouter, Supabase Auth), Agent WAJIB menyertakan URL tautan resmi ke dokumentasi terbaru di dalam Spec-nya. Jika tidak bisa memberikan sumber URL resmi, dilarang merakit kode.

## 4. Asumsi Eksplisit
- Agent wajib menuliskan bagian "ASUMSI YANG SAYA BUAT" di awal pesannya setiap kali memulai task, agar User bisa memverifikasinya terhadap 7 dokumen SoT di atas sebelum dieksekusi.

## 5. Bahasa
- Seluruh dokumen operasional (Plan, Task, Walkthrough, Audit Report) dan komunikasi wajib dibuat secara eksklusif dalam bahasa Indonesia.

## 6. Hard Constraints & Policies
- **Hard Block Policy:** Jika satu atau lebih dokumen SOT di atas belum tersedia di folder proyek, DILARANG melakukan coding atau file generation.
- **SOT Development Mode:** Jika SOT belum lengkap, tugas utama Agent adalah melakukan wawancara kepada user untuk mengumpulkan data dan men-generate dokumen SOT tersebut.
- **No Side-Quests:** Jika user meminta fitur di luar cakupan SOT, Agent WAJIB menolak dan meminta user memperbarui dokumen SOT terlebih dahulu. Jika user tetap memaksa maka Agent tetap wajib menolak.
- **SOT Impact Analysis:** Jika user meminta perubahan fitur atau arsitektur yang mengharuskan modifikasi dokumen SOT, Agent WAJIB melakukan pengecekan menyeluruh terhadap seluruh pilar dokumen SOT (SRS, IA, Design System, Data Model, User Flows, System Logics, Prototype) untuk melihat dampak perubahannya (*blast radius*). Agent harus memberikan penjelasan detail kepada user mengenai file SOT apa saja yang terdampak beserta rincian perubahannya untuk setiap file. Eksekusi perubahan hanya boleh dilakukan setelah user menyetujui analisis dampak tersebut.
- **Mandatory Logging:** Setiap respon yang melibatkan perubahan kode/file harus menyertakan tabel Requirement Log di bagian akhir dengan format persis seperti ini (sesuaikan isi barisnya dengan tugas yang sedang dikerjakan):

  ## 📊 REQUIREMENT LOG

  | ID | Phase | Source Ref | Requirement Name | Status |
  | --- | --- | --- | --- | --- |
  | R-01 | Phase 0 | All SOTs | Validasi Dokumen Utama | [PENDING/DONE] |
  | R-02 | Phase 1 | SRS | Project Scaffolding | [PENDING/PROGRESS/DONE] |
  | R-03 | Phase 2 | IA | Layout & Navigation | [PENDING/PROGRESS/DONE] |
- **Strict Validation:** Agent harus selalu melakukan cross-check antara kode yang ditulis dengan User Flow dan Design System.
- **Visual Verification & Auto-Reload:** 
  - Setiap kali Agent selesai mengimplementasikan perubahan UI/kode, Agent WAJIB memverifikasinya secara visual. 
  - Agent harus menjalankan `flutter analyze` untuk mengecek error sintaks.
  - **PENTING:** Agent harus mengecek apakah aplikasi sedang berjalan. Jika user tidak sedang menjalankan terminal `flutter run`, maka **Agent WAJIB menjalankan `flutter run -d chrome` (atau emulator)** sebagai *background task*.
  - Jika aplikasi sudah berjalan (baik oleh user maupun Agent), setiap kali ada perubahan, Agent **WAJIB** mengirimkan input `r` (hot reload) atau `R` (hot restart) ke proses yang berjalan agar hasil implementasi terupdate. Agent yang memantau dan me-reload, bukan menyuruh user.
- **Context-Aware Responses:** Jika instruksi User berupa pertanyaan (terutama yang diakhiri dengan tanda tanya `?` atau berformat investigasi seperti "Kenapa ini terjadi?", "Bagaimana menurutmu?"), Agent harus menyadari bahwa User sedang meminta diskusi atau analisis, BUKAN tindakan. Pada titik ini, Agent **HANYA BOLEH** menganalisa, menjelaskan, atau memberikan saran.
- **Strictly No Action (ABSOLUTE RULE):** Jika prompt User mengandung kalimat pertanyaan (ditandai dengan adanya karakter `?`), Agent **DILARANG MUTLAK** memanggil tools yang mengubah state atau file (seperti `replace_file_content`, `multi_replace_file_content`, `write_to_file`, atau `run_command` dengan efek samping). Agent HANYA diizinkan merespon menggunakan teks biasa (menjawab, menganalisa, atau meminta konfirmasi). Tidak ada pengecualian untuk aturan ini.
- **Explicit Confirmation:** Jika Agent menyimpulkan bahwa perubahan kode diperlukan berdasarkan hasil analisis tersebut, Agent **WAJIB** mempresentasikan idenya dan mengonfirmasi kembali kepada User (misal: "Saya menemukan penyebabnya, apakah Anda ingin saya memperbaikinya sekarang?"). Jangan pernah mengeksekusi perubahan dari inisiatif sendiri saat User hanya bertanya.
