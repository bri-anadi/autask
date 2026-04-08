# LP6 - Minggu 7: BYOK Gemini + Secure Storage

## Ringkasan

Minggu 7 menyelesaikan fondasi BYOK (Bring Your Own Key) untuk Gemini API dengan penyimpanan aman di perangkat.

Fitur utama:
- Halaman pengaturan AI tersedia.
- API key bisa disimpan dan dihapus.
- Validasi format key saat input.
- Key tersimpan ditampilkan dalam bentuk masked.
- Tidak ada hardcoded API key di source code.

## Implementasi Teknis

### Arsitektur

Fitur baru dibuat mengikuti Clean Architecture:
- `presentation`
  - `AiSettingsPage`
  - `AiSettingsCubit`
  - `AiSettingsState`
- `domain`
  - `AiKeyRepository` (contract)
  - `ReadAiKeyUseCase`, `SaveAiKeyUseCase`, `DeleteAiKeyUseCase`
- `data`
  - `AiKeyLocalDataSource`
  - `SecureAiKeyLocalDataSource` (implementasi `flutter_secure_storage`)
  - `InMemoryAiKeyLocalDataSource` (dukungan testing)
  - `AiKeyRepositoryImpl`

### Dependency Injection

Dependency fitur AI key didaftarkan pada composition root (`get_it`) sehingga:
- `presentation` tidak membuat service/repository manual.
- Runtime memakai secure storage.
- Testing dapat memakai in-memory datasource.

### Validasi API Key

Validasi minimum saat simpan:
- Tidak boleh kosong.
- Tidak boleh mengandung spasi.
- Minimal 20 karakter.
- Harus diawali `AIza`.

### Masking API Key

Masking dilakukan sebelum ditampilkan ke UI:
- Tampilkan 4 karakter awal + 4 karakter akhir.
- Bagian tengah diganti `*`.
- Contoh: `AIza************9XyZ`.

## Alur Penggunaan

1. User membuka halaman `Pengaturan AI` dari AppBar halaman task.
2. User memasukkan API key Gemini.
3. Sistem memvalidasi input.
4. Jika valid, key disimpan ke secure storage.
5. UI menampilkan status key tersimpan dalam bentuk masked.
6. User dapat menghapus key kapan pun.

## Bukti Kepatuhan Keamanan

- Tidak ada API key ditulis langsung di source code.
- Kunci disimpan melalui `flutter_secure_storage`.
- UI hanya menampilkan key dalam format masked.

## Validasi

- `flutter analyze`: lulus.
- `flutter test`: lulus.

## Catatan Lanjut

- Minggu 8/9 dapat lanjut ke integrasi request Gemini API menggunakan key yang tersimpan ini.
