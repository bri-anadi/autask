# Dokumen UTS - Minggu 8 (Preview Progres)

## Ringkasan Status Proyek

Status saat UTS: **Fondasi MVP siap lanjut ke fase integrasi AI**.

Komponen yang sudah stabil:
- Task CRUD dasar (add, edit, delete, detail).
- State management menggunakan Cubit (`TaskCubit`).
- Persistence lokal menggunakan `sqflite` + migration dasar.
- Fitur produktivitas task (priority, due date, filter, sort, quick status).
- BYOK Gemini key management di secure storage (save, delete, validation, masking).

## Cakupan Demo End-to-End (UTS)

Skenario demo yang dipakai:
1. Buka aplikasi dan tampilkan daftar task.
2. Tambah task dengan judul, deskripsi, prioritas, dan due date.
3. Ubah status task dengan quick action.
4. Terapkan filter status dan sort prioritas/deadline.
5. Hapus task.
6. Buka halaman `Pengaturan AI`.
7. Simpan API key Gemini (valid), tampil masked key, lalu hapus kembali.

Hasil demo:
- Flow utama berjalan tanpa blocker kritis pada jalur MVP saat ini.

## Bug Kritis yang Terdokumentasi

### Kritis (P0/P1)

- Tidak ada bug kritis terbuka saat snapshot UTS ini.

### Minor yang Perlu Dipantau

- Belum ada integrasi request Gemini API aktual (baru sampai BYOK settings).
- Belum ada skenario uji widget khusus untuk halaman AI settings.

## Risiko Teknis Utama

1. **Integrasi Gemini API (Week 9-10)**
- Risiko: format respons AI tidak konsisten.
- Mitigasi: definisikan kontrak output JSON ketat + validasi parser + fallback manual.

2. **Error Handling Jaringan**
- Risiko: timeout/quota/network error menurunkan UX.
- Mitigasi: standarkan mapping error ke pesan aman user + retry flow.

3. **Regresi saat Integrasi AI ke Task Flow**
- Risiko: alur task existing terganggu setelah fitur AI masuk.
- Mitigasi: tambah unit test use case + bloc test + smoke widget test untuk flow utama.

## Backlog Pasca UTS (Minggu 9-14)

## Minggu 9 - Integrasi Dasar Gemini API
- Buat `GeminiClient` dan service request/response dasar.
- Implement timeout, handling status error, dan parsing response text dasar.
- Tampilkan hasil response di UI (halaman eksperimen/chat sederhana internal).

## Minggu 10 - AI ke Draft Task
- Rancang prompt terstruktur output JSON.
- Parse output ke model `TaskDraft`.
- Tambahkan dialog konfirmasi sebelum simpan ke database.

## Minggu 11 - Hardening & Testing
- Lengkapi loading/empty/error states untuk flow AI.
- Tambah fallback manual saat AI gagal.
- Tutup bug prioritas tinggi dari Week 9-10.

## Minggu 12 - Freeze MVP & Rehearsal
- Freeze scope MVP.
- Final QA regression pada flow end-to-end.
- Rehearsal presentasi 5-7 menit.

## Minggu 13 - Presentasi Final Batch 1
- Jalankan presentasi batch 1.
- Kumpulkan feedback evaluator.
- Susun daftar revisi minor.

## Minggu 14 - Presentasi Final Batch 2 & Penutupan
- Final presentasi batch 2.
- Validasi artefak akhir.
- Kompilasi laporan akhir LP0-LP10 + refleksi teknis.

## Kebutuhan Minggu Berikutnya

Prioritas paling tinggi setelah UTS:
- Mulai implementasi Week 9 (Gemini client dasar) tanpa mengubah stabilitas flow task existing.
