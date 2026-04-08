# WEEK-05 Guide - Local Database dengan sqflite

## Scope Minggu 5
- Menyimpan data task secara persisten lokal.
- Menyediakan operasi CRUD database.
- Menambahkan migration dasar skema.

## Langkah Pengerjaan Lengkap
1. Tambahkan helper database (`TaskDatabase`).
2. Buat tabel `tasks` dengan kolom utama.
3. Implement datasource sqflite untuk CRUD.
4. Hubungkan repository ke datasource sqflite.
5. Tambahkan migration dasar `onUpgrade`.
6. Uji data tetap ada setelah app ditutup-dibuka.

## Screenshot Wajib
- Screenshot skema tabel task.
- Screenshot kode insert/select/update/delete.
- Screenshot data task sebelum tutup app.
- Screenshot data task setelah buka ulang app.

## Penjelasan Wajib per Screenshot
- Struktur tabel dan alasan kolom.
- Cara operasi CRUD bekerja.
- Bukti persistence berhasil.

## Output Minggu 5
- LP4: ERD/skema tabel, query utama, bukti persistence.

## Format Pengumpulan
- Nama file: Kelompok_[Nomor_Kelompok].pdf
