# WEEK-10 Guide - AI ke Draft Task

## Scope Minggu 10
- Mengubah input bahasa natural menjadi draft task terstruktur.
- Memastikan output AI stabil dalam format JSON.
- Menambahkan konfirmasi user sebelum simpan ke DB.

## Langkah Pengerjaan Lengkap
1. Definisikan kontrak output JSON untuk draft task.
2. Tulis prompt yang menghasilkan output stabil.
3. Implement parser JSON ke model `TaskDraft`.
4. Validasi hasil parse (required field, fallback).
5. Tampilkan dialog konfirmasi ke user.
6. Simpan ke DB hanya setelah user konfirmasi.

## Screenshot Wajib
- Screenshot contoh prompt input.
- Screenshot raw output AI (JSON).
- Screenshot hasil parse menjadi draft.
- Screenshot dialog konfirmasi.
- Screenshot task tersimpan ke list/DB.

## Penjelasan Wajib per Screenshot
- Aturan parsing dan validasi.
- Skenario gagal parse dan penanganannya.
- Alur konfirmasi sebelum simpan.

## Output Minggu 10
- LP8: 3 contoh prompt, kasus gagal parse, bukti tersimpan.

## Format Pengumpulan
- Nama file: Kelompok_[Nomor_Kelompok].pdf
