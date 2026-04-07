# WEEK-03 Report

## Informasi Umum

- Minggu: 3
- Periode: 2026-04-20
- Phase: UI Dasar Task dan Notes
- Status: Done

## Tujuan Minggu

- Menyelesaikan UI CRUD dasar untuk task.
- Menutup flow list-detail-form agar alur penggunaan jelas.
- Menyiapkan baseline LP2 untuk evaluasi minggu 3.

## Implementasi Utama

- Daftar task pada halaman utama (list view).
- Form tambah task menggunakan dialog.
- Hapus task sederhana dari list.
- Navigasi detail task dari item list (list -> detail).

## Referensi Context7 (Library)

- `flutter_bloc`: acuan integrasi state Cubit ke widget tree.
- `equatable`: acuan model entity/state immutable.
- `get_it`: acuan dependency injection untuk Cubit/use case.

## Checklist Minggu 3

- [x] UI list task selesai.
- [x] Form tambah task selesai.
- [x] Delete task sederhana berjalan.
- [x] Flow list-detail-form jelas.
- [x] LP2 selesai (flow CRUD UI, struktur widget, kendala/solusi).

## Validasi

- `flutter analyze`: lulus.
- `flutter test`: lulus.

## Kendala dan Solusi

- Kendala: flow awal belum memiliki halaman detail task.
  Solusi: tambah `TaskDetailPage` dan onTap pada item list.
- Kendala: konsistensi named parameter lintas layer.
  Solusi: refactor alur delete task ke named parameter.

## Rencana Minggu 4

- Rapikan state management untuk event utama (`Load`, `Add`, `Update`, `Delete`).
- Lengkapi artefak LP3 (diagram event-state dan bukti UI reaktif).
