# WEEK-07 Guide - BYOK Gemini + Secure Storage

## Scope Minggu 7
- Menyediakan halaman setting AI.
- Menyimpan dan menghapus API key user.
- Menambahkan validasi input key.
- Menampilkan key dengan masking.
- Memastikan tidak ada hardcoded secret.

## Langkah Pengerjaan Lengkap
1. Tambahkan dependency secure storage.
2. Buat feature `ai_settings` dengan clean architecture.
3. Implement datasource secure read/write/delete key.
4. Implement Cubit untuk load/save/delete API key.
5. Tambahkan validasi key (format, panjang, spasi, prefix).
6. Tambahkan masking tampilan key tersimpan.
7. Tambahkan entry UI dari task page ke halaman AI settings.

## Screenshot Wajib
- Screenshot halaman settings AI.
- Screenshot input key valid.
- Screenshot status key tersimpan (masked).
- Screenshot aksi hapus key.
- Screenshot bukti tidak ada hardcoded key di source.

## Penjelasan Wajib per Screenshot
- Kenapa BYOK wajib untuk keamanan.
- Alur penyimpanan key yang aman.
- Mekanisme validasi dan masking.

## Output Minggu 7
- LP6: alur BYOK, bukti aman, screenshot sukses/gagal.

## Format Pengumpulan
- Nama file: Kelompok_[Nomor_Kelompok].pdf
