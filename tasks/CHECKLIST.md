# Checklist Phase Autask (14 Minggu)

## Minggu 1 - Perkenalan Proyek

- [ ] Scope produk, batas MVP, dan rubric penilaian dipahami tim.
- [ ] 5-7 user story selesai.
- [ ] Fitur dipilah menjadi MVP vs non-MVP.
- [ ] Prioritas sprint awal disusun.
- [ ] LP0 selesai (latar belakang, target user, fitur MVP, risiko).

## Minggu 2 - Setup Project Flutter

- [x] Project Flutter bisa running di device/emulator.
- [x] Dependency inti dipasang dan dijelaskan alasannya.
- [x] Struktur folder awal sesuai arsitektur target.
- [x] Aturan branch/commit disepakati dan dipakai.
- [x] LP1 selesai (screenshot running, dependency, struktur folder).

## Minggu 3 - UI Dasar Task dan Notes

- [x] UI list task selesai.
- [x] Form tambah task selesai.
- [x] Delete task sederhana berjalan.
- [x] Flow list-detail-form jelas.
- [x] LP2 selesai (flow CRUD UI, struktur widget, kendala/solusi).

## Minggu 4 - State Management BLoC

- [x] Event utama tersedia: `LoadTasks`, `AddTask`, `UpdateTask`, `DeleteTask`.
- [x] State utama tersedia: `TaskInitial`, `TaskLoading`, `TaskLoaded`, `TaskError`.
- [x] UI terhubung ke BLoC dan reaktif.
- [x] Diagram event-state dibuat.
- [x] LP3 selesai (diagram, cuplikan BLoC, bukti UI reaktif).

## Minggu 5 - Local Database sqflite

- [x] Skema tabel task final.
- [x] CRUD database terimplementasi.
- [x] Migration dasar tersedia.
- [x] Data persisten dan sinkron ke UI.
- [x] LP4 selesai (ERD/skema, query utama, bukti persistence).

## Minggu 6 - Fitur Produktivitas Task

- [x] Prioritas, due date, dan status lifecycle dipakai.
- [x] Filter status berjalan.
- [x] Sort prioritas/due date berjalan.
- [x] Quick action ubah status tersedia.
- [x] LP5 selesai (skenario pakai, query/filter, evaluasi performa sederhana).

## Minggu 7 - BYOK Gemini dan Secure Storage

- [x] Halaman setting AI tersedia.
- [x] Simpan/hapus API key berjalan.
- [x] Validasi input key dan masking key berjalan.
- [x] Tidak ada hardcoded key/secret di source code.
- [x] LP6 selesai (alur BYOK, bukti aman, screenshot sukses/gagal).

## Minggu 8 - UTS dan Preview Progres

- [x] Demo end-to-end fondasi berjalan.
- [x] Bug kritis terdokumentasi.
- [x] Backlog perbaikan minggu 9-14 disusun.
- [x] Risiko teknis utama dipetakan.
- [x] Dokumen UTS selesai (progress, risiko, rencana lanjut).

## Minggu 9 - Integrasi Dasar Gemini API

- [x] Gemini client dasar terpasang.
- [x] Request prompt dan tampil response berjalan.
- [x] Timeout, quota, dan network error ditangani.
- [x] Error message aman di UI.
- [x] LP7 selesai (sample request/response, error handling, screenshot chat).

## Minggu 10 - AI ke Draft Task

- [x] Prompt untuk output JSON stabil.
- [x] Parsing JSON ke `TaskDraft` valid.
- [x] User confirmation sebelum simpan tersedia.
- [x] Draft valid tersimpan ke DB.
- [x] LP8 selesai (3 prompt, kasus gagal parse, bukti tersimpan).

## Minggu 11 - Hardening dan Testing

- [x] Skenario uji CRUD + AI + DB dijalankan.
- [x] Loading/empty/error state dirapikan.
- [x] Fallback manual saat AI gagal dipastikan berjalan.
- [x] Bug prioritas ditutup.
- [x] LP9 selesai (test case, bug log sebelum/sesudah, stabilitas).

## Minggu 12 - Freeze MVP dan Rehearsal

- [ ] Scope MVP dibekukan.
- [ ] Final QA dijalankan.
- [ ] Rehearsal demo 5-7 menit dilakukan.
- [ ] Known issue non-kritis didokumentasikan.
- [ ] LP10 selesai (checklist MVP, known issue, link build/repo).

## Minggu 13 - Presentasi Final Batch 1

- [ ] Presentasi batch 1 selesai.
- [ ] Alur presentasi problem -> solusi -> demo -> hasil dipakai.
- [ ] Feedback evaluator didokumentasikan.
- [ ] Revisi minor dari feedback dipetakan.
- [ ] Ringkasan feedback selesai.

## Minggu 14 - Presentasi Final Batch 2 dan Penutupan

- [ ] Presentasi batch 2 selesai.
- [ ] Final demo end-to-end tanpa blocker besar.
- [ ] Artefak akhir tervalidasi lengkap.
- [ ] Refleksi teknis dan rencana lanjutan ditulis.
- [ ] Laporan akhir selesai (LP0-LP10 + refleksi).

## Checklist Minimal Lulus

- [ ] Task CRUD berbasis sqflite stabil.
- [ ] State management konsisten dengan BLoC.
- [ ] BYOK Gemini aman di secure storage.
- [x] Flow AI minimum berjalan: kalimat bebas -> draft -> konfirmasi -> simpan.
- [x] Fallback manual saat AI gagal tersedia.
- [ ] Presentasi final menunjukkan flow end-to-end tanpa blocker.
