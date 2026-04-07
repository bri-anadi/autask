# WEEK-02 Report

## Informasi Umum

- Minggu: 2
- Periode: 2026-04-13
- Phase: Setup Project Flutter
- Status: Done

## Tujuan Minggu

- Menyiapkan project agar siap dikembangkan secara konsisten.
- Menetapkan struktur folder awal sesuai target arsitektur.
- Menyepakati dependency inti dan alasan penggunaannya.

## Scope Pekerjaan Minggu 2

- Setup environment pengembangan Flutter.
- Validasi aplikasi dapat dijalankan di emulator/perangkat.
- Penataan struktur modul awal untuk feature-based architecture.
- Penetapan standar branch dan commit workflow.

## Dependency Inti (Final)

- `flutter_bloc`: state management berbasis BLoC.
- `equatable`: membantu perbandingan state/value object.
- `sqflite`: penyimpanan data lokal.
- `path`: membantu lokasi file database.
- `get_it`: dependency injection terpusat.
- `intl`: formatting tanggal/waktu dan dukungan lokal.

## Referensi Context7 (Library)

- `flutter_bloc`: acuan flow Cubit dan integrasi state ke UI.
- `equatable`: acuan equality untuk entity/state immutable.
- `get_it`: acuan dependency injection pada composition root.
- `sqflite` dan `path`: acuan persistence lokal serta path database.
- `intl`: acuan formatting tanggal/waktu.

## Struktur Folder Target (Awal)

```text
lib/
  app/
    config/
    theme/
    router/
  core/
    constants/
    error/
    utils/
    widgets/
  features/
    task/
      presentation/
      domain/
      data/
    note/
      presentation/
      domain/
      data/
```

## Standar Git Minggu 2

- Branch kerja utama: `development`.
- Branch fitur/perbaikan: `feature/*`, `fix/*`, `chore/*`.
- Commit message pakai Conventional Commits.
- Semua perubahan di-review sebelum merge.

## Risiko dan Mitigasi

- Risiko: struktur folder berubah-ubah di awal.
  Mitigasi: kunci baseline struktur pada akhir minggu 2.
- Risiko: dependency terlalu banyak sejak awal.
  Mitigasi: pasang dependency minimum yang langsung dipakai.
- Risiko: standar git tidak konsisten antar anggota.
  Mitigasi: wajibkan naming branch/commit sesuai rule proyek.

## Checklist Minggu 2

- [x] Project Flutter running di emulator/perangkat.
- [x] Dependency inti terpasang.
- [x] Struktur folder awal final.
- [x] Branch/commit workflow diterapkan.
- [x] LP1 selesai (screenshot running app, daftar dependency + alasan, struktur folder final).

## Output yang Ditargetkan

- LP1 siap submit.
- Baseline teknis untuk mulai implementasi UI minggu 3.

## Rencana Minggu 3

- Implement UI dasar task dan notes.
- Mulai flow list-detail-form untuk task.
