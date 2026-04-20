# WEEK-13 Report

## Informasi Umum

- Minggu: 13
- Tanggal: 2026-04-20
- Phase: Presentasi Final Batch 1
- Status: In Progress

## Tujuan Minggu

- Menyiapkan alur presentasi final batch 1 secara ringkas dan konsisten.
- Menentukan format pencatatan feedback evaluator.
- Menyusun kerangka revisi minor pasca presentasi.

## Alur Presentasi yang Dipakai

Urutan presentasi yang dipakai tetap:
1. Problem
2. Solusi
3. Demo
4. Hasil

Rincian singkat:
1. Problem
- Pengguna sering memiliki ide task dari kalimat bebas.
- Input manual penuh memakan waktu dan rawan detail terlewat.

2. Solusi
- Autask menyediakan task management lokal berbasis `sqflite`.
- Integrasi AI membantu mengubah prompt bebas menjadi draft task.
- Jika parsing AI gagal, user tetap bisa memakai fallback manual.

3. Demo
- Tampilkan Home: search, filter, sort, quick status.
- Tampilkan Pengaturan: BYOK Gemini.
- Tampilkan Asisten:
  - prompt sukses -> draft -> konfirmasi -> simpan,
  - prompt gagal parse -> fallback manual -> simpan.

4. Hasil
- Flow end-to-end dapat dijalankan tanpa blocker utama.
- MVP sudah memenuhi target minimal tugas kelas.

## Template Feedback Evaluator

Gunakan format berikut saat presentasi:

### Identitas Sesi

- Tanggal:
- Batch:
- Nama evaluator:

### Feedback Utama

1. Kelebihan:
- 

2. Kekurangan:
- 

3. Pertanyaan teknis:
- 

4. Catatan demo:
- 

### Tindak Lanjut

- Revisi minor 1:
- Revisi minor 2:
- Revisi minor 3:

## Revisi Minor yang Sudah Diperkirakan

Daftar ini masih tentative dan akan disesuaikan dengan hasil evaluator:

1. Memperjelas narasi manfaat AI terhadap alur task harian.
2. Memperjelas batas MVP vs pengembangan lanjutan.
3. Menyiapkan jawaban teknis untuk:
   - alasan pemakaian `Cubit`,
   - alasan `sqflite`,
   - alasan BYOK,
   - fallback saat AI gagal.
4. Menyiapkan screenshot pendukung bila demo device bermasalah.

## Artefak Presentasi

- Repo:
  - `https://github.com/bri-anadi/autask`
- Jalur run lokal demo:
  - `flutter run`
- Dokumen acuan MVP:
  - `reports/WEEK-12-Report.md`

## Referensi Context7 (Library/API)

- Context7 MCP tidak tersedia pada environment saat Week 13 disiapkan.
- Week 13 tidak menambah library baru; fokusnya persiapan presentasi, format feedback, dan tindak lanjut evaluasi.

## Status Saat Ini

- Alur presentasi sudah disusun.
- Template feedback evaluator sudah siap dipakai.
- Revisi minor awal sudah dipetakan.
- Checklist Week 13 belum ditandai selesai karena presentasi belum dijalankan.

## Rencana Lanjutan

- Jalankan presentasi final batch 1.
- Isi feedback evaluator ke dokumen ini.
- Tandai checklist Week 13 setelah sesi benar-benar selesai.
