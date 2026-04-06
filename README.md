# Autask

Autask adalah aplikasi manajemen tugas berbasis AI yang dibangun dengan Flutter.  
Tujuan utamanya membantu pengguna mengelola pekerjaan harian dengan alur yang adaptif, terstruktur, dan mudah dievaluasi berkat analisis yang disediakan di balik layar.

## Deskripsi Aplikasi

Autask dirancang sebagai asisten produktivitas personal, bukan hanya daftar tugas biasa.  
Pengguna dapat menulis tugas dengan bahasa natural, lalu sistem memprosesnya menjadi data tugas yang lebih rapi agar mudah diprioritaskan dan dijadwalkan.

Fokus pengalaman pengguna pada MVP:

- Input tugas cepat dengan bantuan AI (judul, konteks, prioritas awal).
- Penyusunan prioritas tugas berdasarkan urgensi dan deadline.
- Monitoring progres tugas harian untuk evaluasi produktivitas.

## Status Proyek

Prototype awal selesai; sedang fokus membangun MVP yang hanya mencakup input tugas cerdas, susunan prioritas, dan penjadwalan dasar.

## Tujuan

- Memberikan platform to-do lintas platform (Android/iOS) dari satu basis kode.
- Menetapkan arsitektur clean dengan pemisahan presentation/domain/data.
- Menyediakan blok awal integrasi AI (Gemini/pemrosesan natural language).

## Tech Stack

- Flutter 3.x+ dengan Dart 3.9
- `flutter_bloc` / Cubit untuk manajemen state
- Clean Architecture (presentation/domain/data)
- `sqflite` untuk penyimpanan lokal

## Prasyarat

- Flutter SDK terpasang, kompatibel dengan constraint `^3.9.2`
- Android Studio (Android) dan/atau Xcode (iOS) untuk build natif
- VS Code atau IDE lain lengkap ekstensi Flutter + Dart

## Setup Lokal

1. Clone repository:

```bash
git clone https://github.com/bri-anadi/autask.git
cd autask
```

2. Install dependency:

```bash
flutter pub get
```

3. Jalankan di emulator atau perangkat:

```bash
flutter run
```

## Perintah Operasional

- `flutter analyze` — validasi lint dengan rule `analysis_options.yaml`  
- `flutter test` — jalankan unit/widget test  
- `flutter build apk` / `flutter build ios` — build release

## Struktur Ideal

```text
lib/
  app/             # entry point aplikasi, router, tema
  core/            # shared widgets, utils, styles
  features/
    <feature>/
      presentation/ # widget, screen, cubit, presentation models
      domain/       # entity, repository contracts, use cases
      data/         # datasource, dto/model, repositories
```

## Standar Pengembangan

- UI dan dokumentasi menggunakan Bahasa Indonesia.  
- Kode, nama kelas, dan variabel memakai Bahasa Inggris.  
- Semua teks UI harus di-ARB-internasionalisasi (tidak ada string hardcode).  
- Cubit berinteraksi lewat use case; state harus immutable dan `copyWith` jika kompleks.  
- Dependensi lintas layer didaftarkan lewat composition root (`get_it` atau setara).  
- Data/failure mapping mengikuti pola failure yang konsisten; UI hanya menampilkan pesan aman.  
- Perubahan wajib lolos `flutter analyze` dan `flutter test`.

## Kontribusi

1. Pastikan branch `main` up to date: `git pull --rebase origin main`.  
2. Buat branch bernama `feature/*`, `fix/*`, atau `chore/*` (huruf kecil).  
3. Jalankan `flutter analyze` & `flutter test` sebelum commit.  
4. Commit dengan format Conventional Commits (misalnya `docs: refresh readme`).  
5. Ajukan PR dengan ringkasan perubahan + hasil tes.

## Referensi

- Dokumentasi Flutter: https://docs.flutter.dev/  
- Clean Architecture: https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html
