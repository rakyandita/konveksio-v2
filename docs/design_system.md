# [Fase 2 | SoT #3] Design System

**Project:** Konveksio
**Platform:** Mobile App (Flutter)
**Last Updated:** 2026-07-16
**Status:** ✅ FINAL (SoT #3 Approved)

## 1. Core Principles
Berdasarkan analisis `ui-ux-pro-max` untuk aplikasi *productivity factory dashboard*:
- **Sleek, Premium & Serious:** Antarmuka bergaya profesional layaknya dashboard perbankan modern.
- **High-Density Bento Grids:** Menyajikan data secara padat dan terstruktur (Bento UI) di satu layar untuk meminimalisir *scroll* berlebih, cocok untuk operasional pabrik yang butuh efisiensi.
- **Soft Drop Shadows & Subtle Depth:** Meninggalkan aturan *flat design* kaku. Mengizinkan penggunaan bayangan halus (*soft shadows*) untuk menciptakan ilusi elevasi dan kedalaman (*depth*) layaknya antarmuka macOS/Apple.
- **Thumb-Friendly:** Area tap *minimum 44x44pt*, tombol aksi utama (*CTA*) selalu diletakkan di bagian bawah layar.
- **Keterbacaan Maksimal:** Kontras tinggi untuk penggunaan di lingkungan pabrik, dengan tipografi yang tebal dan jelas.

## 2. Color Palette
Tema warna disesuaikan berdasarkan persetujuan pengguna (Biru Emerald sebagai *Primary*).

| Token | Hex | Penggunaan |
|-------|-----|------------|
| `--color-primary` | `#0D9488` | Warna merek utama (Biru Emerald/Teal), Header Normal, Tombol Aksi Utama (CTA). |
| `--color-on-primary` | `#FFFFFF` | Teks di atas warna Primary. |
| `--color-secondary` | `#0F172A` | Aksen warna gelap (Navy), untuk ikon, border tegas, elemen sekunder. |
| `--color-background` | `#F8FAFC` | Warna latar belakang dasar aplikasi (Off-white/Light Gray). |
| `--color-surface` | `#FFFFFF` | Latar belakang Card atau form input. |
| `--color-foreground` | `#020617` | Warna teks utama (Judul, teks konten). |
| `--color-muted` | `#64748B` | Warna teks sekunder, hint form, atau informasi minor. |
| `--color-destructive` | `#DC2626` | Pesan error, tombol TOLAK Handover, Discrepancy. |
| `--color-success` | `#16A34A` | Pesan sukses, notifikasi tersimpan, progres selesai. |
| `--color-border` | `#E2E8F0` | Garis batas (*divider*), outline form. |
| `--color-branch-context` | `#D97706` | **Khusus Branch Context Mode.** Warna Amber/Kuning Tua untuk header saat Owner aktif dalam mode operasional. |
| `--color-on-branch-context` | `#FFFFFF` | Teks di atas warna Branch Context (header Amber). |

## 3. Typography
- **Font Family:** `Plus Jakarta Sans` (Bersih, modern, sangat terbaca terutama untuk angka).
- **Scale:**
  - `H1 (Heading 1)`: 24sp, Bold (Untuk sapaan, judul halaman besar)
  - `H2 (Heading 2)`: 20sp, SemiBold (Judul Card, nama Order)
  - `Body 1`: 16sp, Regular (Teks utama, nama komponen)
  - `Body 2`: 14sp, Regular (Deskripsi, teks sekunder)
  - `Caption`: 12sp, Medium (Label navigasi bawah, status kecil)

## 4. Spacing & Layout (8dp Rhythm)
Jarak antar elemen mematuhi sistem *grid* kelipatan 8:
- `--space-xs`: 4dp (Jarak teks dengan ikon di sebelahnya)
- `--space-sm`: 8dp (Jarak antar *item* di dalam satu kelompok)
- `--space-md`: 16dp (Padding standar layar, jarak antar kelompok konten)
- `--space-lg`: 24dp (Jarak antar bagian/seksi besar)
- `--space-xl`: 32dp (Margin bawah sebelum tombol aksi tetap)

## 5. UI Components

### 5.1. Buttons (Tombol)
- **Primary Button:** Warna `#0D9488`, teks putih, padding vertikal `14dp`, teks `SemiBold 16px`. Radius: `8dp` (melengkung lembut, tapi bukan pil bulat).
- **Secondary Button:** Outline `#E2E8F0` tebal `1.5dp`, teks `#020617`, background `#FFFFFF`.
- **Destructive Button:** Warna `#DC2626` atau Outline Merah, digunakan untuk "Tolak" atau aksi menghapus.
- *Aturan:* Tombol aksi utama (seperti `[TERIMA]`, `[UPDATE PROGRES]`) sebaiknya *full-width* (penuh ke samping) dan menempel di area bawah layar (*Bottom Sheet / Sticky Footer*).

### 5.2. Cards
- **Bento Grid & Soft Shadows:** Card dirender dengan background putih `#FFFFFF`, outline border sangat tipis 1dp (`#E2E8F0`), dan **wajib menggunakan bayangan halus** (*soft drop shadows*) dengan opasitas sangat rendah (2-5%) untuk memberikan kesan premium dan elevasi.
- Padding dalam Card selalu menggunakan `--space-md` (16dp).

### 5.3. Kotak Input (Text Field)
- Tinggi minimum `48dp` untuk mempermudah tap.
- Latar belakang abu-abu terang (`#F1F5F9`) dengan indikator garis bawah warna Primary saat aktif (fokus).

### 5.4. Navigation Components
- **Bottom Navigation Bar (Karyawan):** Latar putih `#FFFFFF`, ikon aktif berwarna Primary `#0D9488`, ikon non-aktif berwarna Muted `#64748B`. Menggunakan label di bawah ikon (ukuran `12sp`).
- **Side Drawer (Boss/Admin):** Lebar 75% layar, header menggunakan background Primary. Item menu menggunakan ikon di sebelah kiri teks.
- **Scroll-Reactive Header (KAI Style / Dynamic App Bar):** Header yang secara default transparan menyatu dengan warna latar (*hero section*), namun secara otomatis berubah menjadi solid (putih) dengan efek *box-shadow* ketika pengguna melakukan *scroll* ke bawah. Digunakan untuk memberikan kesan luas dan *clean* pada awal pemuatan halaman (seperti pada *Dashboard Karyawan*).

### 5.5. Status Badges & Chips
- Bentuk *pill* (radius penuh) atau membulat `4dp`. Teks ukuran `12sp Medium`.
- **Aktif / Selesai:** Latar Hijau Muda (`#DCFCE7`), Teks Hijau Tua (`#16A34A`).
- **Pending / Draft:** Latar Abu-abu (`#F1F5F9`), Teks Muted (`#64748B`).
- **Peringatan / Ditolak:** Latar Merah Muda (`#FEE2E2`), Teks Merah (`#DC2626`).

#### 5.5.2 Status Badge: Order States (DS-05)
Pemetaan setiap status Order ke token warna badge agar konsisten di semua halaman (Daftar Order, Detail Order, Pipeline):

| Status Order | Latar | Teks | Keterangan |
|--------------|-------|------|------------|
| `Draft` | `#F1F5F9` | `#64748B` | Belum dikonfirmasi |
| `Konfirmasi` | `#EFF6FF` | `#1D4ED8` | Biru muda — deal customer |
| `Produksi Berjalan` | `#FEF9C3` | `#A16207` | Kuning — sedang dikerjakan |
| `Produksi Selesai` | `#DCFCE7` | `#16A34A` | Hijau — selesai diproduksi |
| `Dikirim` | `#F0FDF4` | `#15803D` | Hijau lebih gelap — barang di perjalanan |
| `Selesai / Lunas` | `#052E16` | `#FFFFFF` | Hitam Hijau gelap — tuntas |
| `Batal` | `#FEE2E2` | `#DC2626` | Merah — order dibatalkan |

### 5.6. List Items
- Tata letak satu baris: Leading Icon (opsional), Title (Body 1), Subtitle (Body 2 / Caption), Trailing (opsional, misal nilai angka atau indikator navigasi). Padding vertikal `12dp`.

### 5.7. Branch Context Mode Visual State (Owner Mode Operasional)
Spesifikasi visual untuk membedakan secara tegas antara **Mode Eksekutif** (Global Dashboard default Owner) dan **Mode Operasional** (Branch Context Mode). Ini adalah *safety mechanism* UX agar Owner selalu sadar penuh bahwa tindakannya berdampak nyata pada data operasional cabang.

#### Lapisan 1: Perubahan Header (Wajib, Paling Prioritas)
- **Header Warna Normal (Mode Eksekutif):** `--color-primary` (`#0D9488` / Emerald).
- **Header Warna Branch Context (Mode Operasional):** `--color-branch-context` (`#D97706` / Amber). Ini adalah sinyal visual paling instan — otak pengguna langsung mendeteksi perubahan warna.
- **Format Teks Header:** `⚡ Mode Operasional · [Nama Cabang]`
- **Tombol Keluar:** Selalu tampak di sisi kanan header dengan label `[Keluar]`, warna teks `--color-on-branch-context`.

```
┌────────────────────────────────────────────────┐
│ #D97706 (AMBER)                                │
│  ⚡ Mode Operasional · Cabang Jakarta   [Keluar] │
└────────────────────────────────────────────────┘
```

#### Lapisan 2: Role Chip Persisten (Wajib)
- Sebuah *chip* identitas yang **tidak ikut scroll** (posisi *sticky* tepat di bawah header), menampilkan teks: `👑 OWNER`.
- **Warna chip:** Latar Amber Muda (`#FEF3C7`), teks Amber Tua (`#92400E`), border `#D97706`.
- **Ukuran:** 12sp Medium, padding `4dp 8dp`.
- *Tujuan:* Meski Owner sudah scroll jauh ke bawah daftar order, chip ini tetap terlihat sebagai pengingat identitas.

#### Lapisan 3: Dialog Konfirmasi Ekstra pada Aksi Destruktif/Finansial (Wajib)
- Berlaku untuk aksi: **Generate Gaji**, **Hapus Draft Order**, **Tolak Handover massal**.
- Dialog wajib memuat kalimat: *"⚠️ Anda mengeksekusi tindakan ini sebagai **Owner** dalam Branch Context Mode. Tindakan ini tercatat dalam audit log dengan identitas Anda."*
- Tombol konfirmasi: `[Ya, Lanjutkan]` (warna `--color-branch-context`) dan `[Batal]`.

#### 5.7.4 Boss Inbox: Diferensiasi Vendor vs Internal (RISK-02)
Halaman `PAGE-007` (Kotak Masuk Boss) menampilkan dua sumber Handover yang berbeda. Untuk menghindari ambiguitas, Inbox Boss **wajib memiliki filter/tab visual** sebagai berikut:
- **Tab "Semua"** (default): Menampilkan semua item Handover masuk.
- **Tab "Internal"**: Handover dari Karyawan Internal. List item menampilkan: foto avatar karyawan, nama pengirim, nama order, qty per size, waktu masuk.
- **Tab "Vendor"**: Handover dari/ke Vendor eksternal. List item menampilkan: ikon gedung (bukan avatar), nama vendor, nama order, biaya lump-sum, waktu masuk. Latar belakang baris berwarna Amber sangat muda (`#FFFBEB`) sebagai pembeda visual.
- Badge jumlah item yang belum dikonfirmasi ditampilkan di tab masing-masing.

#### 5.7.5 Tugas Aktif Karyawan Multi-Divisi (RISK-01)
Karyawan yang terdaftar di lebih dari satu divisi dapat memiliki tugas aktif di dua divisi sekaligus. Spesifikasi layout `PAGE-010`:
- Task list dikelompokkan berdasarkan **Divisi** (sebagai *Section Header*), bukan *flat list*.
- Contoh: `Section: CUTTING (2 tugas)` → item-item, `Section: JAHIT (1 tugas)` → item-item.
- Jika hanya ada 1 divisi, section header tidak perlu ditampilkan (tidak ada noise visual).

#### 5.7.6 Empty States (RISK-03)
Spesifikasi *Empty State* untuk kondisi data kosong yang kritis:

| Halaman | Kondisi | Ilustrasi | Microcopy | CTA |
|---------|---------|-----------|-----------|-----|
| `PAGE-001` (Global Dashboard Owner) | Belum ada cabang terdaftar | Ikon pabrik kosong | *"Belum ada cabang yang terdaftar. Yuk buat cabang pertama Anda."* | `[Buat Cabang]` |
| `PAGE-003` (Daftar Order) | Belum ada order | Ikon clipboard kosong | *"Belum ada pesanan nih. Mulai catat order pertama Anda!"* | `[Tambah Order]` |
| `PAGE-009` (Kotak Masuk Karyawan) | Tidak ada Handover masuk | Ikon kotak surat | *"Kotak masukmu kosong. Istirahat dulu, atau cek Tugas Aktif!"* | — |
| `PAGE-010` (Tugas Aktif) | Tidak ada tugas | Ikon tangan kosong | *"Belum ada tugas. Tunggu info dari Boss ya."* | — |

## 6. Voice, Tone & UX Writing
Sesuai arahan `/ui-ux-pro-max`, aplikasi Konveksio dirancang untuk bertindak sebagai "Asisten/Rekan Kerja" yang humanis, ramah, dan komunikatif. Tidak boleh ada teks sistem yang kaku.

- **Kata Ganti (Pronouns):**
  - Untuk **Karyawan Produksi & Admin**: Gunakan sapaan akrab **"Kamu"** / **"Mu"** (Contoh: "Kerjaanmu hari ini sudah beres semua!").
  - Untuk **Owner & Boss Cabang**: Gunakan sapaan profesional **"Anda"** (Contoh: "Ada 3 pengajuan kasbon yang menunggu persetujuan Anda.").
- **Tone (Gaya Bahasa):** Memotivasi, suportif, langsung ke intinya, dan solutif. Menggunakan ungkapan seperti "Mantap!", "Waduh", "Yuk".
- **Kosakata:** Gunakan istilah lapangan yang familiar bagi pekerja konveksi (misal: "Kasbon", "Ongkos", "Potong").

## 7. Interaction Feedback (Komunikasi Sistem)
Setiap interaksi pengguna wajib direspon dengan umpan balik tekstual dan visual berbasis pedoman `/frontend-ui-engineering`:

- **Success (Sukses):** 
  - *Komponen:* Snackbar dari bawah layar (warna latar Hijau `#16A34A`).
  - *Microcopy:* Merayakan keberhasilan. (Contoh: *"Mantap! Order 100 pcs Kaos berhasil disimpan."*)
- **Error / Warning (Gagal / Peringatan):**
  - *Komponen:* Teks *Inline* merah (`#DC2626`) di bawah kolom, atau Snackbar merah untuk error *network*.
  - *Microcopy:* Jangan menyalahkan pengguna, berikan solusi. (Contoh: *"Waduh, nominal ini melebihi sisa limit kasbonmu. Coba kurangi sedikit ya."* atau *"Koneksimu terputus nih. Pastikan internet stabil lalu coba lagi."*)
- **Destructive Action (Tindakan Bahaya / Hapus):**
  - *Komponen:* Dialog / Modal konfirmasi dengan aksi ganda.
  - *Microcopy:* Tegas dan jelas konsekuensinya. (Contoh: *"Yakin mau menolak serah terima ini? Barang akan dikembalikan ke penjahit sebelumnya lho."*)
- **Empty States (Layar Kosong):**
  - *Komponen:* Ilustrasi di tengah layar.
  - *Microcopy:* Mencegah *dead-end*. (Contoh: *"Belum ada cabang yang didaftarkan. Yuk tambah cabang pertama Anda."*)
- **Loading State:** Menggunakan *Skeleton loading* tanpa bayangan kasar untuk menjaga ilusi performa yang cepat saat menunggu respon *database*.
- **Motion & Micro-Interactions (Pro Max):**
  - *Staggered Motion:* Elemen seperti *Card* atau *List Item* harus muncul secara berurutan dan mulus (*slide-up fade*) saat halaman dimuat, tidak muncul secara instan kaku.
  - *Hover/Tap Scale:* Setiap elemen interaktif (tombol, *Card* yang bisa ditekan) harus memberikan umpan balik membesar perlahan (skala 1.02) saat disentuh/di-*hover* untuk memberikan kesan hidup dan responsif.

## 8. Layout & Text Constraints (Proteksi Overflow)
Berdasarkan pendekatan `/idea-refine` dan `/spec-driven-development`, *Design System* ini menstandarkan proteksi terhadap teks panjang yang berpotensi merusak (*overlap/overflow*) *layout mobile*, khususnya secara horizontal (misal: "Renderflex overflowed by X pixels" di Flutter).

Aturan implementasi komponen UI:
- **Single-Line Truncation (Elipsis):** Teks yang secara hierarki hanya boleh menempati 1 baris horisontal (misal: Nama Customer, Judul Item, Nama Karyawan) **wajib** dipotong menggunakan akhiran titik-titik (`TextOverflow.ellipsis`). Contoh: "PT Sumber Rejeki Berkah..."
- **Multi-Line Wrapping:** Teks deskriptif (misal: Alasan Penolakan Handover, Catatan Order) harus mengalir (*wrap*) ke baris berikutnya secara otomatis.
- **Flex Bounds (Penahan Benturan):** Saat 2 teks disejajarkan berhadapan di dalam satu baris (misal: "Nama Item" di kiri, "Status" di kanan), elemen kiri **wajib** dibungkus dengan kontainer adaptif (`Expanded` / `Flexible`) agar teks kiri yang panjang tidak menabrak teks kanan, melainkan akan memotong dirinya sendiri (elipsis).
- **Horizontal Scroll (Data Tabular):** Deretan data sejenis yang panjang (misal: Deretan *chip size* S, M, L, XL, XXL, 3XL, dst) wajib diset agar bisa digeser (*scroll*) ke samping, bukan ditumpuk paksa hingga ukurannya mengecil dan tidak terbaca.

## 9. Pre-Delivery Checklist (Mobile UI)
- [ ] Tidak menggunakan emoji sebagai ikon struktural (gunakan pustaka ikon vektor *SVG* seperti Phosphor atau Lucide).
- [ ] Tombol dan area tap harus mematuhi area minimum `44x44pt`.
- [ ] Kontras warna teks memenuhi standar WCAG (Teks putih di atas Biru Emerald terbaca jelas).
- [ ] Area *Safe-Area-View* di iOS/Android tidak menutupi informasi penting atau navigasi bawah.
- [ ] Semua teks nama/judul menggunakan elipsis, dan semua row memakai batas fleksibel untuk **mencegah horizontal overflow**.

## 10. Traceability
- Dokumen ini merangkum *Source of Truth* visual, gaya komunikasi (*Voice & Tone*), dan pedoman ketahanan *layout* (*Constraint*) yang menjadi acuan ketat saat membangun **HiFi Prototype** (Fase 3) dan implementasi UI di Flutter.
