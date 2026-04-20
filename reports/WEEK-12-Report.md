# WEEK-12 Report

## Informasi Umum

- Minggu: 12
- Tanggal: 2026-04-20
- Phase: Freeze MVP dan Rehearsal
- Status: Done

## Tujuan Minggu

- Membekukan scope MVP yang akan dibawa ke presentasi final.
- Menjalankan final QA untuk flow demo utama.
- Mendokumentasikan known issue non-kritis agar tidak tercampur dengan blocker.
- Menyiapkan narasi demo 5-7 menit untuk rehearsal.

## Scope MVP yang Dibekukan

Fitur yang masuk freeze Week 12:
- CRUD task berbasis `sqflite`.
- Search, filter, sort, dan quick update status.
- Halaman detail task.
- BYOK Gemini di Pengaturan dengan secure storage.
- Flow AI minimum:
  - prompt bebas,
  - respons AI,
  - ekstraksi draft task,
  - konfirmasi user,
  - simpan ke daftar task.
- Fallback manual saat parsing AI gagal.
- Navigasi utama `Home | Asisten | Pengaturan`.

Fitur yang tidak dimasukkan ke MVP final:
- multi-draft AI,
- draft note terpisah dari task,
- release artifact publik (`apk/ipa`) yang dibundel di repo,
- telemetry/logging runtime lanjutan.

## Final QA

Validasi terakhir pada snapshot Week 12:
- `flutter analyze`: lulus.
- `flutter test`: lulus.

Flow QA yang diverifikasi:
1. Tambah task manual dari Home.
2. Edit task lewat swipe.
3. Hapus task lewat swipe.
4. Update status cepat dari task list.
5. Simpan dan hapus API key Gemini dari Pengaturan.
6. Kirim prompt AI dan tampilkan respons.
7. Simpan draft AI ke task.
8. Gunakan fallback manual saat parsing AI gagal.
9. Pastikan empty state tetap benar saat daftar task kosong.

## Known Issue Non-Kritis

1. Belum ada artifact build final yang dibundel untuk distribusi langsung.
2. Logging runtime untuk debugging demo device belum disiapkan.
3. AI assistant masih fokus pada 1 draft task per interaksi.
4. Belum ada changelog publik untuk penutupan MVP.

Issue di atas tidak memblokir flow demo utama.

## Rehearsal Demo 5-7 Menit

Urutan narasi yang dipakai:
1. Problem: pengguna sering punya ide tugas dari kalimat bebas, tetapi input manual memakan waktu.
2. Home: tunjukkan daftar task, search, filter, sort, dan quick status.
3. AI success flow: kirim prompt, tinjau draft, lalu simpan ke task.
4. AI fallback flow: tunjukkan jalur manual saat hasil AI tidak valid.
5. Settings: tunjukkan penyimpanan API key dengan BYOK.
6. Penutup: simpulkan bahwa MVP sudah siap untuk demo end-to-end.

## Artefak

- Dokumen freeze MVP:
  - `tasks/lp10-week-12-freeze-mvp.md`
- Repo:
  - `https://github.com/bri-anadi/autask`
- Jalur run lokal demo:
  - `flutter run`

## Referensi Context7 (Library/API)

- Context7 MCP tidak tersedia pada environment saat Week 12 dikerjakan.
- Week 12 tidak menambah library baru; fokusnya final QA, freeze scope, dan rehearsal berdasarkan implementasi `flutter_bloc`, `sqflite`, `flutter_secure_storage`, dan flow Gemini yang sudah ada.

## Ringkasan Hasil

- Scope MVP sudah dibekukan.
- Final QA lulus tanpa blocker.
- Known issue non-kritis sudah dipisahkan.
- Narasi demo 5-7 menit sudah siap.

## Rencana Minggu 13

- Jalankan presentasi final batch 1.
- Catat feedback evaluator.
- Pisahkan revisi minor dari perubahan non-prioritas.
