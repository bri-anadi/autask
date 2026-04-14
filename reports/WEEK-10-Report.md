# WEEK-10 Report

## Informasi Umum

- Minggu: 10
- Tanggal: 2026-04-14
- Phase: AI ke Draft Task
- Status: Done

## Tujuan Minggu

- Mengubah respons AI menjadi draft task terstruktur.
- Memvalidasi parsing JSON agar stabil dan aman.
- Menyediakan konfirmasi user sebelum task disimpan.
- Menyimpan draft valid ke database task.

## Implementasi Utama

- Menambahkan entity `TaskDraft` sebagai representasi draft task hasil AI.
- Menambahkan `TaskDraftParser` untuk:
  - ekstraksi JSON dari respons AI,
  - validasi field wajib,
  - validasi enum `status` dan `priority`,
  - validasi format `due_date`.
- Menambahkan prompt builder `BuildTaskDraftPromptUseCase` agar Gemini diminta membalas hanya JSON object valid.
- Menambahkan `ExtractTaskDraftUseCase` dan contract `TaskDraftExtractor`.
- `AiAssistantCubit` sekarang:
  - mengirim prompt template terstruktur ke AI,
  - menyimpan `latestDraft` dan `latestRawResponse`,
  - menandai apakah draft berhasil dideteksi.
- Halaman Asisten sekarang:
  - menampilkan indikator draft detected / fallback parse,
  - menyediakan tombol `Tinjau Draft`,
  - membuka bottom sheet konfirmasi,
  - menyimpan draft ke task melalui `TaskCubit.addTask`.

## Contoh Prompt

1. `Buatkan task untuk belajar Flutter Bloc besok malam`
2. `Tolong ubah ide ini jadi task prioritas tinggi: riset integrasi Gemini API`
3. `Buat task untuk menyiapkan presentasi final pada tanggal 2026-04-20`

## Contoh Draft JSON

```json
{
  "title": "Belajar Flutter Bloc",
  "description": "Pelajari cubit dan state dasar",
  "status": "todo",
  "priority": "medium",
  "due_date": "2026-04-20"
}
```

## Kasus Parsing Gagal yang Ditangani

- Respons tidak mengandung JSON object.
- Field `title` kosong atau tidak ada.
- Nilai `status` di luar `todo | in progress | done`.
- Nilai `priority` di luar `high | medium | low`.
- `due_date` tidak valid.

Saat parsing gagal:
- respons AI tetap tampil sebagai chat,
- indikator fallback muncul,
- draft tidak ditandai siap disimpan.

## Bukti Penyimpanan ke DB

- Flow yang sudah berjalan:
  - user kirim prompt,
  - draft terdeteksi,
  - user meninjau draft pada bottom sheet,
  - draft disimpan ke task list,
  - task baru muncul di halaman Home.

## Hasil Testing

- Unit test:
  - parser JSON valid,
  - parser JSON dalam markdown code fence,
  - missing title,
  - invalid status,
  - invalid priority,
  - invalid due date,
  - no JSON object found.
- Bloc test:
  - draft berhasil diekstrak saat respons AI valid,
  - error saat API key tidak tersedia.
- Widget test:
  - flow end-to-end `draft -> review -> save -> task muncul di Home`.

Status validasi:
- `flutter analyze`: lulus.
- `flutter test`: lulus.

## Referensi Context7 (Library/API)

- Context7 MCP tidak tersedia pada environment saat implementasi Week 10.
- Referensi teknis yang dipakai mengikuti:
  - kontrak endpoint Gemini dari Week 9,
  - pola JSON output yang dipaksa melalui prompt template,
  - `flutter_bloc` untuk state extraction/review flow,
  - `sqflite` repository yang sudah tersedia dari Week 5.

## Artefak

- Kode draft parsing dan flow simpan:
  - `lib/features/ai_assistant/domain/entities/task_draft.dart`
  - `lib/features/ai_assistant/data/mappers/task_draft_parser.dart`
  - `lib/features/ai_assistant/presentation/`
- Test terkait:
  - `test/features/ai_assistant/data/mappers/task_draft_parser_test.dart`
  - `test/features/ai_assistant/presentation/`
- Commit utama:
  - `a1d21bb`
  - `5e5a5d9`
  - `16b0118`
  - `43fe26e`
  - `5a3be05`

## Rencana Minggu 11

- Hardening fallback manual saat parsing AI gagal.
- Rapikan loading/empty/error state agar lebih tahan demo.
- Jalankan skenario uji CRUD + AI + DB yang lebih lengkap.
- Tutup bug prioritas untuk kesiapan demo final.
