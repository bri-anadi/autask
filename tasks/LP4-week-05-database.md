# LP4 - Minggu 5 (Local Database sqflite)

## Tujuan

- Memindahkan persistence task dari memory ke database lokal `sqflite`.
- Menyediakan migration dasar untuk skema awal tabel task.
- Memastikan alur CRUD tetap melewati `domain` repository contract.

## Skema Tabel Task

Nama tabel: `tasks`

Kolom:

- `id` INTEGER PRIMARY KEY AUTOINCREMENT
- `title` TEXT NOT NULL
- `description` TEXT NOT NULL DEFAULT ''
- `status` TEXT NOT NULL DEFAULT 'todo'
- `due_date` TEXT NULL
- `created_at` TEXT NOT NULL
- `updated_at` TEXT NOT NULL

## Query Utama (Implementasi)

- Load tasks:
  - `SELECT * FROM tasks ORDER BY created_at DESC`
- Insert task:
  - `INSERT INTO tasks (title, description, status, due_date, created_at, updated_at) VALUES (...)`
- Update task:
  - `UPDATE tasks SET title=?, description=?, status=?, updated_at=? WHERE id=?`
- Delete task:
  - `DELETE FROM tasks WHERE id=?`

## Migration Dasar

- `onCreate`: membuat tabel `tasks`.
- `onUpgrade`: disiapkan sebagai placeholder untuk versi skema berikutnya.

## Alur Layer

- `presentation` -> `TaskCubit`
- `TaskCubit` -> use case (`Get/Add/Update/Delete`)
- use case -> `TaskRepository` (contract domain)
- repository impl -> `TaskLocalDataSource`
- datasource -> `sqflite` (`TaskDatabase`)

## Status

- CRUD database: selesai.
- Migration dasar: selesai.
- Integrasi UI ke persistence: selesai.
