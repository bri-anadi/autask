# Guidebook Laporan Praktikum - Autask

Dokumen ini menjadi panduan langkah demi langkah untuk menyusun laporan praktikum proyek Autask dari minggu 1 sampai 14.

## 1. Tujuan Guidebook

- Menyamakan format laporan semua kelompok.
- Memastikan isi laporan konsisten dengan progress implementasi di repository.
- Mempermudah proses review dosen/asisten.

## 2. Scope Pengerjaan

## Scope Wajib

- Laporan mencakup progres sesuai fase mingguan di `tasks/CHECKLIST.md`.
- Setiap langkah implementasi penting memiliki:
  - screenshot bukti,
  - penjelasan singkat dan jelas.
- Laporan memuat kendala, solusi, dan rencana perbaikan.
- Laporan akhir berisi kompilasi LP0-LP10 + refleksi teknis.

## Scope Tambahan (Nilai Plus)

- Menambahkan analisis alternatif solusi teknis.
- Menambahkan metrik sederhana (contoh: waktu respon fitur, hasil uji skenario).
- Menambahkan lessons learned per fase.

## 3. Format Dokumen (Wajib)

Setiap laporan mingguan harus mengikuti pola ini:

1. Judul Laporan
- Contoh: `Laporan Praktikum Minggu 6 - Fitur Produktivitas Task`

2. Identitas Kelompok
- Nomor kelompok
- Nama anggota
- Kelas
- Mata kuliah

3. Capaian Minggu Ini
- Tulis target mingguan sesuai checklist.
- Tulis status: selesai/belum.

4. Step by Step Pengerjaan
- Untuk setiap langkah, wajib ada:
  - **Screenshot tiap langkah**
  - **Penjelasan tiap langkah**

Format per langkah:
- Langkah X: [Nama langkah]
- Tujuan
- Aksi yang dilakukan
- Screenshot
- Hasil

5. Kendala dan Solusi
- Kendala teknis yang terjadi.
- Cara penyelesaian.

6. Hasil Pengujian
- Minimal hasil `flutter analyze` dan `flutter test`.
- Jika ada pengujian tambahan, cantumkan ringkas.

7. Kesimpulan Mingguan
- Ringkasan hasil.
- Rencana minggu berikutnya.

## 4. Format Screenshot (Wajib)

- Screenshot harus jelas dan terbaca.
- Gunakan urutan nama file konsisten:
  - `step-01.png`, `step-02.png`, dst.
- Satu screenshot mewakili satu progres nyata (bukan screenshot berulang).
- Untuk output terminal, pastikan command dan hasil terlihat.

## 5. Step by Step Penyusunan Laporan

1. Buka checklist minggu yang aktif di `tasks/CHECKLIST.md`.
2. Jalankan implementasi fitur minggu tersebut.
3. Ambil screenshot saat tiap milestone selesai.
4. Catat penjelasan singkat per milestone (apa, kenapa, hasil).
5. Jalankan validasi (`flutter analyze`, `flutter test`).
6. Masukkan hasil validasi ke laporan.
7. Sinkronkan isi laporan dengan commit terbaru (`git log --oneline`).
8. Ekspor dokumen ke PDF sesuai format nama pengumpulan.

## 6. Mapping Isi Laporan per Fase Mingguan

## Minggu 1
- Scope: problem statement, persona, user story, MVP vs non-MVP, risiko awal.
- Output: LP0.

## Minggu 2
- Scope: setup project, dependency, struktur folder, rule branch/commit.
- Output: LP1.

## Minggu 3
- Scope: UI CRUD dasar task/notes.
- Output: LP2.

## Minggu 4
- Scope: Cubit state flow dan integrasi UI reaktif.
- Output: LP3.

## Minggu 5
- Scope: sqflite persistence + migration.
- Output: LP4.

## Minggu 6
- Scope: prioritas, due date, filter, sort, quick status.
- Output: LP5.

## Minggu 7
- Scope: BYOK Gemini + secure storage + masking/validasi key.
- Output: LP6.

## Minggu 8
- Scope: dokumen UTS (progress, risiko, backlog 9-14).
- Output: Dokumen UTS.

## Minggu 9
- Scope: integrasi dasar Gemini API (request/response + error handling).
- Output: LP7.

## Minggu 10
- Scope: AI ke draft task (JSON parse + konfirmasi + simpan).
- Output: LP8.

## Minggu 11
- Scope: hardening, fallback AI, testing minimum.
- Output: LP9.

## Minggu 12
- Scope: freeze MVP, QA, rehearsal demo.
- Output: LP10.

## Minggu 13
- Scope: presentasi final batch 1 + feedback.
- Output: ringkasan feedback.

## Minggu 14
- Scope: presentasi final batch 2 + final submission.
- Output: laporan akhir.

## 7. Format Pengumpulan (Wajib)

Nama file pengumpulan:
- `Kelompok_[Nomor_Kelompok].pdf`

Contoh:
- `Kelompok_03.pdf`

Ketentuan:
- Pastikan file PDF final, bukan dokumen mentah.
- Pastikan seluruh screenshot dan penjelasan tampil utuh.
- Pastikan isi sesuai minggu/fase yang dilaporkan.

## 8. Struktur Dokumen yang Direkomendasikan

1. Cover
2. Daftar isi
3. Identitas kelompok
4. Capaian minggu
5. Step by step + screenshot + penjelasan
6. Kendala dan solusi
7. Hasil pengujian
8. Kesimpulan dan rencana next week
9. Lampiran (opsional)

## 9. Checklist Final Sebelum Submit

- [ ] Nama file sudah sesuai: `Kelompok_[Nomor_Kelompok].pdf`
- [ ] Semua langkah utama ada screenshot.
- [ ] Semua screenshot punya penjelasan langkah.
- [ ] Status capaian sesuai checklist minggu terkait.
- [ ] Hasil `flutter analyze` dan `flutter test` tercantum.
- [ ] Scope pengerjaan dijelaskan jelas.
- [ ] Dokumen sudah di-review seluruh anggota.

## 10. Catatan Penting

- Konsistensi lebih penting daripada banyaknya halaman.
- Bukti pengerjaan harus sejalan dengan histori commit.
- Hindari menaruh secret/API key mentah di screenshot laporan.
