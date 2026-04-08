# LP5 - Minggu 6: Fitur Produktivitas Task

## Ringkasan Implementasi

Minggu 6 berfokus pada peningkatan usability harian aplikasi task dengan menambahkan:

- Prioritas task (`high`, `medium`, `low`).
- Due date per task.
- Filter berdasarkan status (`all`, `todo`, `in progress`, `done`).
- Sort task berdasarkan:
  - terbaru dibuat,
  - prioritas tertinggi,
  - deadline terdekat.
- Quick action ubah status langsung dari list task.

## Perubahan Fungsional

### 1) Prioritas dan Due Date

- Form tambah/edit task sekarang mendukung input `priority` dan `due date`.
- Data prioritas disimpan persisten di database.
- Detail task menampilkan status, prioritas, dan deadline dalam format yang mudah dibaca.

### 2) Filter dan Sort

- User dapat memfilter daftar task berdasarkan status.
- User dapat mengurutkan task untuk fokus eksekusi:
  - `Terbaru`
  - `Prioritas Tertinggi`
  - `Deadline Terdekat`
- Logika filter/sort dipusatkan di `TaskCubit` agar UI tetap tipis.

### 3) Quick Action Status

- Dari list task, user bisa langsung menjalankan aksi perubahan status berantai:
  - `todo -> in progress -> done -> todo`
- Aksi ini memanggil alur update resmi melalui use case, tetap mengikuti clean architecture.

## Skenario Penggunaan

1. User menambahkan task baru dengan prioritas `high` dan deadline besok.
2. User memilih filter `To Do` untuk melihat backlog aktif.
3. User memilih sort `Prioritas Tertinggi` agar task kritikal tampil di atas.
4. User menekan quick action pada task untuk ubah status ke `in progress`.
5. Setelah selesai, user menekan quick action lagi hingga status `done`.

## Query/Filter yang Digunakan

- Persistence (sqflite):
  - `SELECT ... ORDER BY created_at DESC`
  - `INSERT` task dengan `priority`, `due_date`, `created_at`, `updated_at`
  - `UPDATE` task untuk perubahan `status`, `priority`, `due_date`, `updated_at`
- View model (Cubit):
  - Filter status dilakukan di memory setelah fetch data.
  - Sorting dilakukan di memory sesuai mode yang dipilih user.

## Evaluasi Performa Sederhana

- List task menggunakan `ListView.separated` untuk rendering efisien.
- Rebuild dibatasi dengan `buildWhen` pada `BlocConsumer`.
- Filter/sort berjalan pada list in-memory (cukup untuk skala MVP).
- Tidak ada operasi database berat di dalam method `build`.

## Kendala dan Solusi

- Kendala: mismatch context provider saat aksi dialog.
- Solusi: gunakan instance `TaskCubit` dari context induk sebelum `showDialog`.

## Validasi

- `flutter analyze`: lulus.
- `flutter test`: lulus.

## Catatan Lanjutan

- Untuk data sangat besar, filter/sort dapat dipindah ke query SQL terparameter.
- Week berikutnya dapat menambahkan indikator visual prioritas berbasis warna token tema.
