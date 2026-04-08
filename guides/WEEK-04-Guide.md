# WEEK-04 Guide - State Management dengan Cubit

## Scope Minggu 4
- Memisahkan logic state dari UI menggunakan Cubit.
- Menyediakan state utama untuk load/add/update/delete.
- Menghubungkan UI agar reaktif terhadap perubahan state.

## Langkah Pengerjaan Lengkap
1. Buat `TaskState` immutable (`initial/loading/loaded/error`).
2. Buat `TaskCubit` dengan method load, add, update, delete.
3. Hubungkan page dengan `BlocProvider`.
4. Render state di UI pakai `BlocBuilder/BlocConsumer`.
5. Tampilkan feedback error dengan aman.
6. Uji seluruh flow state saat operasi CRUD.

## Screenshot Wajib
- Screenshot struktur file cubit/state.
- Screenshot cuplikan alur state di code.
- Screenshot UI saat loading.
- Screenshot UI saat loaded.
- Screenshot UI saat error.

## Penjelasan Wajib per Screenshot
- Peran tiap state.
- Cara cubit dipanggil dari UI.
- Dampak pemisahan state terhadap maintainability.

## Output Minggu 4
- LP3: diagram event/state, cuplikan Cubit, bukti UI reaktif.

## Format Pengumpulan
- Nama file: Kelompok_[Nomor_Kelompok].pdf
