# WEEK-04 Report

## Informasi Umum

- Minggu: 4
- Periode: 2026-04-27
- Phase: State Management dengan BLoC/Cubit
- Status: Done

## Tujuan Minggu

- Menyelesaikan alur state management utama untuk fitur task.
- Memastikan UI benar-benar reaktif terhadap perubahan state.
- Menyiapkan artefak LP3 (diagram event-state dan bukti implementasi).

## Implementasi Utama

- Event/aksi utama tersedia di `TaskCubit`:
  - `loadTasks()`
  - `addTask({title, description})`
  - `updateTask({id, title, description, status})`
  - `deleteTask({id})`
- State utama tersedia:
  - `TaskInitial`
  - `TaskLoading`
  - `TaskLoaded`
  - `TaskError`
- Integrasi update task dari UI:
  - dialog edit task
  - update status (`todo`, `in progress`, `done`)
- Perbaikan bug context provider pada dialog edit (`TaskCubit` di-resolve dari context halaman).

## Referensi Context7 (Library)

- `flutter_bloc`: acuan state flow Cubit dan pemetaan state ke UI reaktif.
- `equatable`: acuan state/entity immutable dan equality.
- `get_it`: acuan registrasi dependency use case + cubit.

## Checklist Minggu 4

- [x] Event utama tersedia: `LoadTasks`, `AddTask`, `UpdateTask`, `DeleteTask`.
- [x] State utama tersedia: `TaskInitial`, `TaskLoading`, `TaskLoaded`, `TaskError`.
- [x] UI terhubung ke BLoC/Cubit dan reaktif.
- [x] Diagram event-state dibuat.
- [x] LP3 selesai (diagram, cuplikan BLoC/Cubit, bukti UI reaktif).

## Validasi

- `flutter analyze`: lulus.
- `flutter test`: lulus.

## Rencana Minggu 5

- Mulai persistence task berbasis `sqflite` (bukan in-memory).
- Finalisasi skema tabel task dan alur CRUD ke database.
