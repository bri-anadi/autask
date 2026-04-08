# WEEK-07 Report

## Informasi Umum

- Minggu: 7
- Tanggal: 2026-04-08
- Phase: BYOK Gemini + Secure Storage
- Status: Done

## Tujuan Minggu

- Menyediakan halaman pengaturan AI.
- Mengimplementasikan simpan/hapus API key Gemini.
- Menambahkan validasi input dan masking key.
- Menjaga agar tidak ada hardcoded key di codebase.

## Implementasi Utama

- Menambahkan dependency `flutter_secure_storage`.
- Menambahkan fitur `ai_settings` dengan Clean Architecture:
  - data source lokal (secure + in-memory),
  - repository contract & implementation,
  - use case baca/simpan/hapus key,
  - cubit + state immutable,
  - halaman `AiSettingsPage`.
- Menambahkan tombol `Pengaturan AI` pada `TaskHomePage` untuk membuka halaman AI settings.
- Menambahkan validasi input API key:
  - wajib isi,
  - tanpa spasi,
  - panjang minimal,
  - prefix `AIza`.
- Menambahkan masking API key tersimpan saat tampil di UI.

## Referensi Context7 (Library/API)

- `flutter_secure_storage`:
  - acuan penyimpanan secret di platform keychain/keystore,
  - acuan operasi `read/write/delete` key-value secure.
- `flutter_bloc`:
  - acuan state-flow loading/success/error untuk form settings.
- `get_it`:
  - acuan wiring dependency runtime vs testing datasource.

Ringkasan penerapan referensi:
- Secret dipindah ke secure storage agar tidak tersimpan plaintext di source code.
- Alur save/delete key dipisahkan lewat use case dan cubit agar maintainable.
- Test path tetap stabil dengan in-memory datasource untuk fitur AI key.

## Checklist Minggu 7

- [x] Halaman setting AI tersedia.
- [x] Simpan/hapus API key berjalan.
- [x] Validasi input key dan masking key berjalan.
- [x] Tidak ada hardcoded key/secret di source code.
- [x] LP6 selesai.

## Artefak

- `tasks/LP6-week-07-byok-secure-storage.md`

## Validasi DoD

- `flutter analyze`: lulus (no issues).
- `flutter test`: lulus (all tests passed).

## Rencana Minggu 8

- Persiapan dokumen UTS/progress review.
- Mulai draft integrasi dasar Gemini client untuk minggu 9.
