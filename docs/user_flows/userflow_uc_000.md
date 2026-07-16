# UC-000: Login & Role-based Redirect

## 1. Metadata
- **ID:** UC-000
- **Name:** Autentikasi Pengguna & Pengalihan Role
- **Actor:** Semua Pengguna (Owner, Boss Cabang, Admin, Karyawan)
- **Trigger:** Pengguna membuka aplikasi saat sesi (session) tidak aktif atau pertama kali install.
- **Pre-conditions:** Aplikasi terhubung ke internet.

## 2. Main Flow (Skenario Utama)
1. Actor membuka aplikasi Konveksio.
2. Sistem memeriksa status *session*. Karena tidak ada *session* aktif, sistem menampilkan Halaman Login (`PAGE-000`).
3. Actor memasukkan Nomor HP dan PIN (atau OTP).
4. Actor menekan tombol `[Masuk]`.
5. Sistem memvalidasi kredensial ke server.
6. Server mengembalikan *token* otentikasi beserta data *Role* pengguna (Owner / Boss / Karyawan).
7. Sistem mengarahkan (redirect) Actor ke Dashboard masing-masing sesuai *Role* (`PAGE-001` untuk Owner, `PAGE-002` untuk Boss, `PAGE-008` untuk Karyawan).

## 3. Alternative Flows
**3.1. Session Sudah Aktif**
- Pada langkah 2, sistem menemukan *token session* yang masih valid.
- Sistem melewati Halaman Login dan langsung melompat ke langkah 7 (Redirect ke Dashboard sesuai role).

**3.2. Lupa PIN**
- Pada langkah 3, Actor menekan tombol `[Lupa PIN]`.
- Sistem mengirimkan OTP via WhatsApp ke Nomor HP yang terdaftar.
- Actor memasukkan OTP dan mengatur PIN baru.
- Sistem melanjutkan ke langkah 5.

## 4. Exception Flows
**4.1. Kredensial Salah**
- Pada langkah 5, server menolak otentikasi.
- Sistem menampilkan *error inline* warna merah (`--color-destructive`): "Nomor HP atau PIN salah."
- Actor harus memasukkan ulang.

**4.2. Akun Dinonaktifkan**
- Pada langkah 5, akun karyawan ternyata sudah dinonaktifkan oleh Boss Cabang (karena *resign*).
- Sistem menampilkan *dialog error*: "Akun Anda telah dinonaktifkan. Silakan hubungi Boss Cabang Anda."

## 5. Postconditions
- Terdapat sesi (token) yang aktif tersimpan di penyimpanan lokal (*secure storage*).
- Aplikasi berada pada rute Dashboard (Home) dari masing-masing role.

## 6. Related Pages
- `PAGE-000`: `/login`
- `PAGE-001`: `/owner/home`
- `PAGE-002`: `/boss/home`
- `PAGE-008`: `/karyawan/home`

## 7. Acceptance Criteria
- [ ] Pengguna tidak bisa melewati halaman Login tanpa token yang valid.
- [ ] Pengguna selalu diarahkan ke Dashboard yang tepat sesuai dengan level aksesnya (Karyawan tidak bisa masuk ke Dashboard Boss).
- [ ] Pesan error kredensial salah bersifat generik ("Nomor atau PIN salah") untuk keamanan.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-000 | User | Phone, PIN/OTP | String | - |
| ENT-000 | User | Role, Token | String | Owner/Boss/Karyawan |

## 9. Traceability
- **SRS Reference:** NFR-02.1 (Security & Auth), NFR-02.2 (Role-based Access).
