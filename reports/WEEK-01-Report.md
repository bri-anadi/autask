# WEEK-01 Report

## Informasi Umum

- Minggu: 1
- Periode: 2026-04-06
- Phase: Perkenalan Proyek Autask
- Status: Selesai

## Problem Statement

Mahasiswa dan pekerja muda sering mencatat tugas di banyak tempat (chat, catatan, kalender) sehingga prioritas harian tidak jelas. Aplikasi to-do konvensional membantu mencatat, tetapi belum cukup membantu menentukan apa yang harus dikerjakan lebih dulu. Autask dibangun untuk mengubah input tugas bebas menjadi daftar kerja yang lebih terstruktur, terprioritas, dan mudah dieksekusi.

## Persona Utama

### Persona 1 - Mahasiswa Aktif

- Nama: Rani (21)
- Latar: Mahasiswa semester akhir, aktif organisasi.
- Kebutuhan: Mengelola deadline tugas kuliah dan agenda rapat.
- Pain point: Sering lupa prioritas tugas yang mendekati deadline.
- Goal: Menyelesaikan tugas tepat waktu dengan beban mental lebih rendah.

### Persona 2 - Freelancer Junior

- Nama: Dimas (24)
- Latar: Freelancer desain dan konten, menangani beberapa klien.
- Kebutuhan: Menyusun urutan kerja antar proyek dan deadline klien.
- Pain point: Sulit membagi fokus karena semua tugas terasa penting.
- Goal: Menjaga produktivitas harian dan konsistensi delivery.

## User Story Prioritas (5-7)

1. Sebagai pengguna, saya ingin menambahkan task baru dengan cepat agar tidak ada tugas yang terlewat.
2. Sebagai pengguna, saya ingin melihat daftar task berdasarkan prioritas agar saya tahu apa yang harus dikerjakan dulu.
3. Sebagai pengguna, saya ingin mengubah status task (todo, in progress, done) agar progres kerja dapat dipantau.
4. Sebagai pengguna, saya ingin menyimpan task secara lokal agar data tetap ada saat aplikasi ditutup.
5. Sebagai pengguna, saya ingin memasukkan kalimat bebas lalu mendapatkan draft task agar input tugas lebih praktis.
6. Sebagai pengguna, saya ingin konfirmasi draft AI sebelum disimpan agar hasil tetap sesuai kebutuhan.
7. Sebagai pengguna, saya ingin fallback manual saat AI gagal agar pekerjaan tetap bisa lanjut tanpa blocker.

## User Flow AI Assistant (Gemini)

### Alur Utama

1. User memberi input lewat voice atau teks.
2. Jika input voice, sistem melakukan speech-to-text terlebih dahulu.
3. Teks input dikirim ke Gemini API untuk ekstraksi intent dan struktur data.
4. Gemini mengklasifikasikan hasil menjadi `task` atau `catatan`.
5. Sistem membentuk draft sesuai format standar.
6. User melihat hasil dan melakukan konfirmasi/edit singkat.
7. Setelah konfirmasi, data otomatis disimpan ke database lokal.

### Format Data Standar

#### Task

- `type`: `task`
- `title`: judul singkat
- `description`: detail tambahan
- `priority`: low/medium/high
- `dueDate`: `YYYY-MM-DD` (opsional)
- `status`: `todo` (default)

#### Catatan

- `type`: `note`
- `title`: ringkasan catatan
- `content`: isi catatan
- `tags`: daftar tag (opsional)
- `createdAt`: timestamp lokal

### Fallback

- Jika respons Gemini tidak valid/timeout, user diarahkan ke input manual.
- Data tidak disimpan otomatis jika format gagal divalidasi.

## Klasifikasi Fitur

### MVP

- CRUD task dasar (add, list, update, delete).
- Penyimpanan lokal dengan sqflite.
- Prioritas, due date, status task.
- Filter dan sort task.
- BYOK Gemini API via secure storage.
- Alur AI minimum: kalimat bebas -> draft task -> konfirmasi -> simpan.
- Fallback manual saat AI gagal.

### Non-MVP

- Sinkronisasi cloud multi-device.
- Kolaborasi tim real-time.
- Integrasi kalender eksternal dua arah.
- Insight produktivitas tingkat lanjut berbasis analitik kompleks.

## Prioritas Sprint Awal

- Sprint 1: setup project, struktur modul, dependency inti, baseline UI.
- Sprint 2: CRUD task + BLoC + sqflite (flow end-to-end tanpa AI).
- Sprint 3: fitur produktivitas (prioritas, due date, filter/sort).
- Sprint 4: BYOK Gemini + AI draft task + fallback + hardening.

## Risiko Awal dan Mitigasi

- Risiko: Scope creep di fase awal.
  Mitigasi: Lock fitur MVP dan tunda non-MVP ke backlog.
- Risiko: Hasil parsing AI tidak stabil.
  Mitigasi: Gunakan output JSON terstruktur + validasi + konfirmasi user.
- Risiko: Waktu habis untuk polish UI.
  Mitigasi: Prioritaskan flow inti berfungsi dulu, UI disederhanakan.

## Checklist Minggu 1

- [x] Problem statement disepakati.
- [x] Persona utama terdefinisi.
- [x] 5-7 user story prioritas tersedia.
- [x] Fitur dipisah menjadi MVP dan non-MVP.
- [x] Prioritas sprint awal ditetapkan.
- [x] LP0 siap sebagai baseline fase implementasi.

## Rencana Minggu 2

- Setup project Flutter dan validasi running app.
- Pasang dependency inti sesuai arsitektur.
- Bentuk struktur folder awal `presentation/domain/data`.
