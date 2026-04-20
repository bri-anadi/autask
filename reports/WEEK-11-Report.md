# WEEK-11 Report

## Informasi Umum

- Minggu: 11
- Tanggal: 2026-04-20
- Phase: Hardening dan Testing
- Status: Done

## Tujuan Minggu

- Menguatkan fallback manual saat parsing AI gagal.
- Menutup skenario uji gabungan CRUD + AI + DB.
- Merapikan perilaku loading, empty state, dan error state.
- Menutup bug prioritas yang muncul dari flow bottom sheet dan test runtime.

## Implementasi Utama

- Menambahkan fallback manual pada halaman Asisten saat respons AI tidak bisa diparse menjadi `TaskDraft`.
- Menjadikan bottom sheet task reusable untuk dua mode:
  - konfirmasi draft hasil parse,
  - pembuatan task manual dari raw response AI.
- Menambahkan auto-suggest judul dari raw response AI untuk mode manual, sehingga user tidak selalu harus mengisi dari nol.
- Menambahkan indikator UI yang membedakan:
  - draft berhasil terdeteksi,
  - respons AI belum bisa diparse.
- Memperbaiki bug provider scope pada bottom sheet save flow.
- Memperbaiki robustness layout bottom sheet dengan scrollable content agar tidak overflow pada test/runtime.

## Skenario Uji yang Dijalankan

- AI success:
  - prompt -> respons tampil,
  - draft terdeteksi,
  - review draft,
  - simpan ke task,
  - task muncul di Home.
- AI fallback:
  - respons AI tidak valid sebagai JSON,
  - indikator fallback tampil,
  - user buka mode manual,
  - task tetap bisa disimpan ke Home.
- AI error:
  - request gagal,
  - pesan error aman tampil di UI.
- CRUD + AI + DB:
  - create task dari AI,
  - quick update status,
  - delete task,
  - empty state muncul saat task habis.

## Bug Log Sebelum/Sesudah

Sebelum:
- provider scope error pada bottom sheet save draft,
- potensi overflow bottom sheet untuk konten panjang,
- fallback manual belum tersedia saat parse AI gagal,
- coverage widget test belum mencakup flow CRUD + AI + DB.

Sesudah:
- save draft/manual berjalan tanpa provider error,
- bottom sheet lebih aman untuk konten panjang,
- fallback manual tersedia dan tervalidasi,
- widget test mencakup success flow, fallback flow, error flow, dan CRUD gabungan.

## Ringkasan Stabilitas

- Fitur AI minimum sekarang tidak bergantung penuh pada parsing sukses.
- Flow demonstrasi menjadi lebih aman karena ada jalur manual saat AI gagal.
- State utama yang sudah tervalidasi:
  - loading request AI,
  - empty state task list,
  - error snackbar aman,
  - success save ke task list.

## Hasil Testing

- `flutter analyze`: lulus.
- `flutter test`: lulus.

Tambahan coverage utama:
- cubit test untuk response tidak ter-parse,
- widget test untuk fallback manual,
- widget test untuk error request AI,
- widget test untuk flow create -> update -> delete -> empty state.

## Referensi Context7 (Library/API)

- Context7 MCP tetap tidak tersedia pada environment saat implementasi Week 11.
- Referensi teknis lanjutan tetap mengikuti kontrak Gemini dari Week 9 serta arsitektur `flutter_bloc`, `get_it`, dan persistence `sqflite` yang sudah ada.

## Artefak

- Perubahan UI fallback dan reusable sheet:
  - `lib/features/ai_assistant/presentation/pages/ai_assistant_page.dart`
- Penguatan test:
  - `test/features/ai_assistant/presentation/cubit/ai_assistant_cubit_test.dart`
  - `test/features/ai_assistant/presentation/pages/ai_assistant_page_test.dart`

Commit utama Week 11:
- `af346ed`
- `67c2557`

## Rencana Minggu 12

- Freeze scope MVP.
- Jalankan final QA terhadap flow demo utama.
- Dokumentasikan known issue non-kritis.
- Siapkan narasi demo dan rehearsal 5-7 menit.
