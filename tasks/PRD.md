# Project Document - Autask

## Ringkasan Proyek

Autask adalah aplikasi manajemen tugas berbasis AI untuk membantu pengguna mencatat, memprioritaskan, dan menyelesaikan pekerjaan harian secara lebih terstruktur.
Project ini dikembangkan dengan Flutter untuk Android dan iOS dengan fokus MVP yang realistis untuk 14 minggu.

## Tujuan Utama

- Menyediakan task management dasar yang stabil (CRUD + persistence lokal).
- Menerapkan arsitektur yang maintainable dengan Clean Architecture.
- Mengintegrasikan AI minimum value: kalimat bebas menjadi draft task terstruktur.
- Menyediakan fallback manual saat AI gagal.

## Ruang Lingkup MVP

### In Scope

- CRUD task berbasis `sqflite`.
- State management dengan Cubit (BLoC).
- Fitur produktivitas dasar: prioritas, due date, status, filter/sort.
- BYOK Gemini API melalui secure storage.
- Flow AI: voice/text -> prompt -> draft task -> konfirmasi user -> simpan DB.

### Out of Scope (untuk MVP)

- Sinkronisasi cloud realtime penuh.
- Kolaborasi multi-user.
- Integrasi kalender eksternal lanjutan.
- Analytics lanjutan berbasis machine learning kompleks.

## Teknologi dan Standar

- Framework: Flutter
- Bahasa: Dart
- State management: Cubit (BLoC)
- Local DB: `sqflite`
- AI: Gemini API (BYOK)
- Arsitektur: Clean Architecture (`presentation`, `domain`, `data`)

Aturan implementasi:
- UI dan dokumentasi proyek menggunakan Bahasa Indonesia.
- Penamaan kode teknis menggunakan Bahasa Inggris.
- Tidak ada hardcoded API key di source code.

## Arsitektur Tingkat Tinggi

- `presentation`: page/widget, BLoC, state UI.
- `domain`: entity, repository contract, use case.
- `data`: datasource, DTO/model, mapper, repository implementation.

Dependency direction:
- `presentation` -> `domain`
- `data` -> `domain`
- `presentation` tidak mengakses datasource secara langsung.

## Deliverables Mingguan

- Minggu 1: LP0 (problem, target user, MVP, risiko).
- Minggu 2: LP1 (setup project, struktur awal, dependency).
- Minggu 3: LP2 (UI CRUD dasar).
- Minggu 4: LP3 (event-state BLoC terhubung UI).
- Minggu 5: LP4 (persistence sqflite).
- Minggu 6: LP5 (fitur produktivitas dasar).
- Minggu 7: LP6 (BYOK + secure storage).
- Minggu 8: Dokumen UTS (progress, risiko, backlog lanjut).
- Minggu 9: LP7 (integrasi dasar Gemini API).
- Minggu 10: LP8 (AI -> draft task -> simpan DB).
- Minggu 11: LP9 (hardening + testing).
- Minggu 12: LP10 (freeze MVP + rehearsal).
- Minggu 13: Ringkasan feedback presentasi batch 1.
- Minggu 14: Laporan akhir (kompilasi LP0-LP10 + refleksi).

## Definisi Selesai (DoD)

- `flutter analyze` lolos tanpa error.
- `flutter test` lolos.
- Build target utama berjalan pada scope yang terdampak.
- Flow minimum end-to-end dapat didemokan tanpa blocker.

## Checklist Minimal Lulus

- Task CRUD berbasis sqflite stabil.
- State management konsisten memakai BLoC.
- BYOK Gemini tersimpan aman di secure storage.
- Fitur AI minimum berjalan: kalimat bebas -> draft task -> konfirmasi -> simpan.
- Fallback manual tersedia saat AI gagal.
- Presentasi final menunjukkan flow end-to-end tanpa blocker.

## Risiko Proyek dan Mitigasi

- Risiko: parsing AI tidak konsisten.
  Mitigasi: format output JSON ketat + validasi schema + fallback manual.
- Risiko: manajemen state kompleks saat fitur bertambah.
  Mitigasi: pisahkan BLoC per fitur/use case, jaga state immutable.
- Risiko: regresi saat integrasi DB + AI.
  Mitigasi: unit test use case + bloc test + widget test skenario utama.

## Referensi Dokumen Terkait

- Checklist mingguan: `tasks/CHECKLIST.md`
- Panduan instalasi dan workflow git: `INSTALL.md`
- Gambaran proyek umum: `README.md`
- Aturan pengembangan: `AGENTS.md`
