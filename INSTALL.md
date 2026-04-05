# INSTALL

## Setup Remote Repository
Jalankan dari root project:

```bash
git remote add origin https://github.com/bri-anadi/autask.git
git push -u origin main
```

## Workflow Sync Harian
Sebelum mulai kerja, selalu update branch `main` lokal:

```bash
git checkout main
git pull --rebase origin main
```

Kerja di branch terpisah:

```bash
git checkout -b feature/nama-fitur
# lakukan perubahan
git add .
git commit -m "feat: deskripsi perubahan"
git push -u origin feature/nama-fitur
```

Lalu merge ke `main` lewat Pull Request.

## Cara Clone Lain Tetap Update
Jika `main` di remote sudah berubah:

```bash
git checkout main
git pull --rebase origin main
```

## Jika Sama-sama Update di Waktu Bersamaan
Kalau branch kamu tertinggal dari `main`:

```bash
git fetch origin
git rebase origin/main
# jika conflict, resolve lalu:
git add .
git rebase --continue
git push --force-with-lease
```

## Aturan Konsistensi
- Jangan `git init` ulang setelah repo sudah dipublish.
- Jangan `push --force` ke branch `main`.
- Selalu `pull --rebase` sebelum `push`.
