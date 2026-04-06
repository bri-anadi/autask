# AGENTS

## MCP Git Agent Rules
- Gunakan branch terpisah untuk fitur/perbaikan: `feature/*`, `fix/*`, atau `chore/*`.
- Hindari commit langsung ke `main` kecuali inisialisasi atau instruksi eksplisit.
- Format commit wajib mengikuti Conventional Commits, contoh: `feat(auth): add login form`.
- Pesan commit wajib Bahasa Inggris, huruf kecil, dan ringkas.
- Gunakan huruf kecil (lowercase) untuk nama branch, pesan commit, dan nama file/folder baru agar konsisten.
- Pengecualian uppercase hanya untuk nama standar seperti `README.md` atau `AGENTS.md`.
- Selalu cek `git status` sebelum dan sesudah perubahan.
- Untuk perubahan kode Dart/Flutter, jalankan `flutter analyze` dan `flutter test` sebelum commit.
- Jangan lakukan operasi destruktif seperti `git reset --hard`, `git clean -fd`, atau `git push --force` tanpa izin eksplisit.
- Jangan mengubah atau menghapus perubahan user yang tidak terkait tanpa persetujuan.
- Jangan commit secret atau kredensial (`.env`, `key.properties`, `*.jks`, `*.keystore`, token API).

## Rules Pengembangan Flutter
- Komunikasi agent boleh menggunakan Bahasa Indonesia atau Bahasa Inggris.
- Bahasa aplikasi (UI/teks yang dilihat user) dan dokumentasi proyek wajib menggunakan Bahasa Indonesia.
- Penamaan kode (class, function, variable, object, file teknis) wajib menggunakan Bahasa Inggris.
- Arsitektur aplikasi wajib menggunakan Clean Architecture (`presentation`, `domain`, `data`).
- Paradigma yang dipakai adalah OOP dengan penerapan design pattern yang relevan.
- Standar penulisan kode wajib mengikuti prinsip Clean Code (nama jelas, fungsi kecil, minim duplikasi, mudah diuji).
- Gunakan named parameter pada function/method/konstruktor, terutama jika argumen lebih dari satu atau ada parameter opsional.
- State management yang dipakai adalah `Cubit` dari `flutter_bloc`.

## Definition Of Done (Wajib)
- Fitur dianggap selesai jika `flutter analyze` lolos tanpa error.
- Fitur dianggap selesai jika seluruh `flutter test` lolos.
- Fitur dianggap selesai jika build target utama yang terdampak berjalan.
- PR hanya boleh merge jika semua checklist DoD terpenuhi.

## Batasan Clean Architecture (Wajib)
- `presentation` hanya boleh berisi widget, page, cubit, dan model presentasi.
- `domain` hanya boleh berisi entity, repository contract, dan use case.
- `data` hanya boleh berisi datasource, DTO/model data, mapper, dan implementasi repository.
- `presentation` dilarang mengakses datasource/API/database secara langsung.
- `data` dilarang diakses langsung oleh UI tanpa melewati `domain`.

## Rule Cubit (Wajib)
- Setiap fitur menggunakan `Cubit` dan `State` yang terpisah jelas.
- `Cubit` hanya berkomunikasi dengan `use case`, bukan langsung ke repository implementation.
- `State` wajib immutable.
- Setiap `State` kompleks wajib menyediakan `copyWith`.
- Side effect (logging, analytics, tracking) tidak boleh mengganggu alur state utama.

## Rule Testing Minimum
- Wajib unit test untuk setiap use case penting.
- Wajib `bloc_test` untuk Cubit yang mengelola alur bisnis utama.
- Wajib minimal 1 widget test untuk setiap fitur utama yang memiliki UI interaktif.
- Bug fix wajib disertai test yang mereproduksi kasus bug.

## Rule i18n dan Teks UI
- Semua teks UI wajib menggunakan localization (ARB), dilarang hardcode string di widget.
- Bahasa default aplikasi adalah Bahasa Indonesia.
- Perubahan teks UI wajib memperbarui file localization terkait.

## Rule UI Reusable dan Performance
- Komponen UI yang dipakai lintas fitur wajib ditempatkan di `lib/core/widgets`.
- Komponen UI khusus fitur wajib ditempatkan di `lib/features/<feature>/presentation/widgets`.
- Gunakan design token terpusat di `lib/app/theme` untuk warna, typography, spacing, dan radius.
- Pisahkan widget presentasional (dumb widget) dan widget yang terhubung state (smart widget).
- Gunakan `const` constructor sebanyak mungkin untuk mengurangi rebuild.
- Gunakan `BlocBuilder` dengan `buildWhen` atau `BlocSelector` untuk membatasi rebuild.
- Untuk list/data panjang wajib gunakan builder (`ListView.builder`, `GridView.builder`, `SliverList`).
- Hindari operasi berat di method `build`; pindahkan ke layer domain/data atau proses async terpisah.
- Gambar dari network wajib menggunakan mekanisme cache.
- Setiap fitur UI utama wajib diuji minimal satu skenario performa dasar melalui profiling di Flutter DevTools.

## Rule Dependency Injection
- Dependency injection wajib terpusat dan konsisten (contoh: `get_it`).
- Dilarang membuat instance service/repository secara manual di layer `presentation`.
- Seluruh dependency lintas layer wajib didaftarkan pada composition root.

## Rule Error Handling
- Gunakan model `Failure`/error domain yang konsisten antar layer.
- Exception dari layer `data` harus dipetakan ke failure yang dipahami `domain`.
- UI hanya menampilkan pesan error yang aman dan ramah user.
- Dilarang melempar raw exception ke layer `presentation`.

## Rule Pull Request dan Review
- Setiap perubahan non-trivial wajib melalui Pull Request.
- Minimal 1 reviewer sebelum merge.
- Ukuran PR disarankan kecil dan fokus, target maksimal sekitar 500 LOC perubahan bersih.
- PR wajib menyertakan ringkasan perubahan, dampak, dan hasil test.

## Rule Security dan Konfigurasi
- Secret wajib disimpan di environment/secret manager, bukan di source code.
- Gunakan `--dart-define` atau mekanisme konfigurasi aman untuk data sensitif.
- Jika butuh contoh konfigurasi, sediakan template aman seperti `.env.example` tanpa nilai rahasia.
