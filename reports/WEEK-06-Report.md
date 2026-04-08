# WEEK-06 Report

## Informasi Umum

- Minggu: 6
- Tanggal: 2026-04-08
- Phase: Fitur Produktivitas Task
- Status: Done

## Tujuan Minggu

- Menambahkan fitur prioritas, due date, dan lifecycle status task.
- Menambahkan filter status dan sort prioritas/deadline.
- Menyediakan quick action untuk ubah status dari daftar task.

## Implementasi Utama

- Domain/data model task diperluas dengan field `priority`.
- Database `tasks` dimigrasi ke versi `2` dengan kolom baru `priority`.
- Repository dan use case `addTask`/`updateTask` diperbarui dengan parameter:
  - `priority`
  - `dueDate`
- `TaskCubit` diperluas untuk:
  - filter status,
  - sort option,
  - quick update status berantai.
- UI task home diperbarui:
  - kontrol filter + sort,
  - input priority + due date pada dialog tambah/edit,
  - quick action status di item list.
- UI detail task menampilkan status, prioritas, dan deadline.

## Referensi Context7 (Library/API)

- `flutter_bloc`:
  - acuan pemisahan state dari UI,
  - penggunaan `BlocSelector`/`BlocConsumer` untuk kontrol rebuild.
- `sqflite`:
  - acuan migration database (`onUpgrade`) untuk penambahan kolom.
- `equatable`:
  - acuan state/entity immutable dengan value equality.

Ringkasan penggunaan referensi:
- Struktur state filter/sort tetap immutable dan terukur perubahan nilainya.
- Migration dilakukan incremental (`oldVersion < 2`) agar data lama tetap kompatibel.
- Rendering UI dibatasi agar update tidak memicu rebuild tidak perlu.

## Checklist Minggu 6

- [x] Prioritas, due date, dan status lifecycle dipakai.
- [x] Filter status berjalan.
- [x] Sort prioritas/due date berjalan.
- [x] Quick action ubah status tersedia.
- [x] LP5 selesai.

## Artefak

- `tasks/LP5-week-06-productivity.md`

## Validasi DoD

- `flutter analyze`: lulus (no issues).
- `flutter test`: lulus (all tests passed).

## Rencana Minggu 7

- Mulai implementasi BYOK Gemini API + secure storage.
- Tambah halaman pengaturan AI key (save/delete/masking/validation).
