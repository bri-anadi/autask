# AGENTS

## MCP Git Agent Rules
- Gunakan branch terpisah untuk fitur/perbaikan: `feature/*`, `fix/*`, atau `chore/*`.
- Hindari commit langsung ke `main` kecuali inisialisasi atau instruksi eksplisit.
- Format commit wajib mengikuti Conventional Commits, contoh: `feat(auth): add login form`.
- Gunakan huruf kecil (lowercase) untuk nama branch, pesan commit, dan nama file/folder baru agar konsisten.
  Pengecualian hanya untuk nama standar yang memang uppercase, seperti `README.md` atau `AGENTS.md`.
- Selalu cek `git status` sebelum dan sesudah perubahan.
- Untuk perubahan kode Dart/Flutter, jalankan `flutter analyze` dan `flutter test` sebelum commit.
- Jangan lakukan operasi destruktif seperti `git reset --hard`, `git clean -fd`, atau `git push --force` tanpa izin eksplisit.
- Jangan mengubah atau menghapus perubahan user yang tidak terkait tanpa persetujuan.
- Jangan commit secret atau kredensial (`.env`, `key.properties`, `*.jks`, `*.keystore`, token API).
