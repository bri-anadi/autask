# WEEK-09 Report

## Informasi Umum

- Minggu: 9
- Tanggal: 2026-04-14
- Phase: Integrasi Dasar Gemini API
- Status: Done

## Tujuan Minggu

- Menghubungkan aplikasi ke Gemini API dengan pola BYOK.
- Mengirim prompt dari UI dan menampilkan respons AI.
- Menangani error dasar (timeout, network, invalid/missing key, HTTP non-2xx).
- Menyediakan pondasi test minimum untuk flow AI.

## Implementasi Utama

- Menambahkan feature baru `ai_assistant` berbasis Clean Architecture:
  - `domain`: `AiChatMessage`, `AiAssistantRepository`, `SendPromptUseCase`.
  - `data`: `GeminiAiAssistantRemoteDataSource`, `AiAssistantRepositoryImpl`.
  - `presentation`: `AiAssistantCubit`, `AiAssistantState`, `AiAssistantPage`.
- Menambahkan tab baru pada bottom navigation: `Asisten`.
- Integrasi dependency injection (`get_it`) untuk remote datasource, repository, use case, dan cubit AI assistant.
- Integrasi pembacaan API key dari secure storage (reuse use case Week 7).
- Menambahkan indikator loading, empty state, chat bubble user/assistant, dan snackbar error ramah user.

## Contoh Request/Response

Contoh request ke endpoint Gemini (`generateContent`):

```json
{
  "contents": [
    {
      "parts": [
        {"text": "Buatkan draft task untuk belajar Flutter selama 3 hari"}
      ]
    }
  ]
}
```

Contoh response yang dipakai aplikasi:

```json
{
  "candidates": [
    {
      "content": {
        "parts": [
          {"text": "Berikut draft task belajar Flutter selama 3 hari..."}
        ]
      }
    }
  ]
}
```

## Error Handling yang Diimplementasikan

- Prompt kosong -> validasi di cubit (`Prompt tidak boleh kosong`).
- API key belum tersedia -> pesan aman di UI (`Simpan dulu di Pengaturan`).
- Timeout request -> ditangani pada datasource (`Permintaan AI melebihi batas waktu`).
- Koneksi internet bermasalah -> ditangani (`Koneksi internet tidak tersedia/tidak stabil`).
- HTTP non-2xx (termasuk quota/unauthorized dari server) -> baca `error.message` dari API lalu tampilkan aman di UI.
- Respons kosong -> ditangani sebagai error yang dapat dipahami user.

## Hasil Testing

- Unit test:
  - `SendPromptUseCase` meneruskan parameter ke repository.
- Bloc test:
  - alur `loading -> loaded` saat sukses,
  - alur `loading -> error` saat API key tidak tersedia.
- Widget test:
  - kirim prompt dari halaman Asisten dan respons tampil di UI.

Status validasi:
- `flutter analyze`: lulus.
- `flutter test`: lulus.

## Referensi Context7 (Library/API)

- Context7 MCP tidak tersedia pada environment saat implementasi Week 9.
- Implementasi mengacu pada kontrak endpoint Gemini `models/{model}:generateContent` dan pola response `candidates[].content.parts[].text`.
- Library utama yang dipakai:
  - `flutter_bloc` untuk state flow,
  - `get_it` untuk dependency injection,
  - `flutter_secure_storage` (reuse Week 7) untuk BYOK.

## Artefak

- Kode fitur AI assistant pada `lib/features/ai_assistant/`.
- Test AI assistant pada `test/features/ai_assistant/`.
- Commit utama: `97d7182`.

## Rencana Minggu 10

- Fokus transformasi output AI menjadi `TaskDraft` terstruktur (JSON stabil).
- Tambah validasi parsing + fallback saat format output AI tidak valid.
- Tambah konfirmasi user sebelum simpan ke DB task.
