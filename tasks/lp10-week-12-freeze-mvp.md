# LP10 Week 12 - Freeze MVP dan Rehearsal

## Status MVP Freeze

Status: Frozen

Tanggal freeze:
- 2026-04-20

Branch acuan:
- `development`

Repo:
- `https://github.com/bri-anadi/autask`

## Checklist MVP Final

- [x] Task CRUD berbasis `sqflite` berjalan.
- [x] State management utama memakai `Cubit`.
- [x] BYOK Gemini tersimpan di secure storage.
- [x] Flow AI minimum berjalan: prompt -> draft -> konfirmasi -> simpan.
- [x] Fallback manual tersedia saat parsing AI gagal.
- [x] Search, filter, sort, dan quick status tersedia.
- [x] Bottom navigation `Home | Asisten | Pengaturan` tersedia.

## Final QA Snapshot

Validasi terakhir:
- `flutter analyze`: lulus
- `flutter test`: lulus

Flow QA utama:
1. Tambah task manual dari Home.
2. Edit dan hapus task via swipe.
3. Ubah status cepat dari daftar task.
4. Simpan API key Gemini di Pengaturan.
5. Kirim prompt AI dan baca respons.
6. Simpan draft hasil AI ke task.
7. Gunakan fallback manual saat parse AI gagal.
8. Hapus task hingga empty state muncul.

## Known Issue Non-Kritis

1. Belum ada build artifact final yang dibundel pada repo (`apk/ipa`) untuk dibagikan langsung.
2. Belum ada telemetry atau logging runtime untuk troubleshooting di demo device.
3. UI AI assistant masih fokus pada task tunggal, belum mendukung multi-draft atau note draft.
4. Belum ada public release notes atau halaman changelog.

## Link Build dan Repo

Repo:
- `https://github.com/bri-anadi/autask`

Build:
- Belum dibuat sebagai artefak final pada snapshot Week 12.
- Jalur run lokal untuk demo: `flutter run`

## Narasi Demo 5-7 Menit

1. Problem:
- Tunjukkan bahwa user butuh cara cepat mengubah ide bebas menjadi task yang bisa dikelola.

2. Home flow:
- Buka daftar task.
- Tunjukkan search, filter, sort, dan quick status.

3. AI flow sukses:
- Pindah ke tab Asisten.
- Kirim prompt.
- Tunjukkan draft terdeteksi.
- Buka `Tinjau Draft`.
- Simpan ke daftar task.

4. AI fallback:
- Tunjukkan kasus respons AI tidak bisa diparse.
- Gunakan mode manual.
- Simpan task tetap berhasil.

5. Pengaturan:
- Tunjukkan halaman Pengaturan AI dan konsep BYOK.

6. Penutup:
- Ringkas bahwa Autask sudah memenuhi MVP task management + AI assist minimum.

## Rehearsal Checklist

- [x] Urutan demo utama sudah ditentukan.
- [x] Narasi 5-7 menit sudah disiapkan.
- [x] Fitur yang didemokan dibatasi pada MVP final.
- [x] Known issue non-kritis sudah dipisahkan dari blocker.
- [x] Snapshot QA terakhir sudah dicatat.
