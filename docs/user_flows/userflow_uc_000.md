# [Fase 2 | SoT #4] UC-000: Login & Role-based Redirect

## 1. Metadata
- **ID:** UC-000
- **Name:** Autentikasi Pengguna & Pengalihan Role
- **Actor:** Semua Pengguna (Owner, Boss Cabang, Admin, Karyawan Produksi)
- **Trigger:** Pengguna membuka aplikasi saat sesi (session) tidak aktif atau pertama kali install.
- **Pre-conditions:** Aplikasi terhubung ke internet (untuk validasi token saat login pertama).

## 2. Main Flow (Skenario Utama)
1. Actor membuka aplikasi Konveksio.
2. Sistem memeriksa status *session* (token JWT di secure storage). Karena tidak ada *session* aktif, sistem menampilkan Halaman Login (`PAGE-000`).
3. Actor memasukkan **Nomor HP** dan **PIN** (6 digit).
4. Actor menekan tombol `[Masuk]`.
5. Sistem memanggil `supabase.auth.signInWithPassword({ phone, password: PIN })`.
6. Server Supabase mengembalikan *token* JWT beserta data *Role* pengguna di `user_metadata` (owner / boss / admin / employee).
7. Sistem menyimpan token JWT ke *secure storage* Flutter.
8. Sistem mengarahkan (redirect) Actor ke Dashboard masing-masing sesuai *Role* (`PAGE-001` untuk Owner, `PAGE-002` untuk Boss/Admin, `PAGE-008` untuk Karyawan).

## 3. Alternative Flows
**3.1. Session Sudah Aktif**
- Pada langkah 2, sistem menemukan *token JWT* yang masih valid di secure storage.
- Sistem melewati Halaman Login dan langsung melompat ke langkah 8 (Redirect ke Dashboard sesuai role).

**3.2. Reset PIN (Lupa PIN)**
- Pada langkah 3, Actor menekan tombol `[Lupa PIN]`.
- Sistem mengirimkan OTP via **WhatsApp / SMS** ke Nomor HP yang terdaftar (menggunakan Supabase Auth OTP).
- Actor memasukkan OTP dan mengatur PIN baru.
- Sistem melanjutkan ke langkah 5.

## 4. Exception Flows
**4.1. Kredensial Salah**
- Pada langkah 5, Supabase Auth menolak otentikasi.
- Sistem menampilkan *error inline* warna merah: "Nomor HP atau PIN salah." (pesan generik — tidak menyebut mana yang salah, SRS Section 6.2).
- Actor harus memasukkan ulang. Setelah 5 percobaan gagal, tampilkan opsi `[Lupa PIN]`.

**4.2. Akun Dinonaktifkan**
- Pada langkah 6, `is_active = false` pada profil karyawan.
- Sistem menampilkan *dialog error*: "Akun Anda telah dinonaktifkan. Silakan hubungi Boss Cabang Anda."
- Token tidak disimpan; session tidak dibuat.

## 5. Postconditions
- Token JWT tersimpan aman di *secure storage* Flutter (`flutter_secure_storage`).
- Aplikasi berada pada rute Dashboard (Home) dari masing-masing role.

## 6. Related Pages
- `PAGE-000`: `/login`
- `PAGE-001`: `/owner/home`
- `PAGE-002`: `/boss/home`
- `PAGE-008`: `/karyawan/home`

## 7. Acceptance Criteria
- [ ] Pengguna tidak bisa melewati halaman Login tanpa token JWT yang valid.
- [ ] Pengguna selalu diarahkan ke Dashboard yang tepat sesuai dengan level aksesnya (Karyawan tidak bisa masuk ke Dashboard Boss; Admin diarahkan ke PAGE-002 sama dengan Boss).
- [ ] Pesan error kredensial salah bersifat generik ("Nomor atau PIN salah") — tidak mengungkap mana yang salah (SRS Section 6.2).
- [ ] Setelah 5 percobaan gagal, tombol `[Lupa PIN]` ditonjolkan.

## 8. Data Used
| Entity ID | Entity | Attributes | Type | Note |
|-----------|--------|------------|------|------|
| ENT-000 | User | Phone, PIN/OTP | String | - |
| ENT-000 | User | Role, Token | String | Owner/Boss/Karyawan |

## 9. Traceability
- **SRS Reference:** F01 (Manajemen Cabang — RLS), F02 (Manajemen User & Role), Section 6.2 (Security: JWT, secure storage), Section 6.1 (Perf: dashboard < 2 detik).
- **Pages:** PAGE-000, PAGE-001, PAGE-002, PAGE-008.
