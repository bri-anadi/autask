# WEEK-05 Report

## Informasi Umum

- Minggu: 5
- Periode: 2026-05-04
- Phase: Local Database dengan sqflite
- Status: Done

## Tujuan Minggu

- Mengimplementasikan persistence task menggunakan `sqflite`.
- Menyediakan migration dasar skema database.
- Menjaga alur clean architecture tetap konsisten.

## Implementasi Utama

- Menambahkan helper database `TaskDatabase`:
  - nama DB: `autask.db`
  - versi DB: `1`
  - tabel: `tasks`
- Menambahkan implementasi datasource `SqfliteTaskLocalDataSource`.
- Menyediakan fallback datasource in-memory untuk test (`InMemoryTaskLocalDataSource`).
- Menghubungkan DI:
  - runtime default -> `SqfliteTaskLocalDataSource`
  - test -> `InMemoryTaskLocalDataSource`

## Referensi Context7 (Library)

- `sqflite`: acuan operasi CRUD async, transaksi, dan lifecycle database.
- `path`: acuan penyusunan path database lokal lintas platform.
- `get_it`: acuan konfigurasi dependency runtime vs testing.

## Skema dan Query

Skema tabel task:
- `id`, `title`, `description`, `status`, `due_date`, `created_at`, `updated_at`

Query utama:
- load: order by `created_at DESC`
- insert: tambah row task baru
- update: update title/description/status + `updated_at`
- delete: hapus row by `id`

## Checklist Minggu 5

- [x] Skema tabel task final.
- [x] CRUD database terimplementasi.
- [x] Migration dasar tersedia.
- [x] Data persisten dan sinkron ke UI.
- [x] LP4 selesai (ERD/skema, query utama, bukti persistence).

## Artefak

- `tasks/LP4-week-05-database.md`

## Validasi

- `flutter analyze`: lulus.
- `flutter test`: lulus.

## Rencana Minggu 6

- Implement prioritas task, due date behavior, dan filter/sort.
