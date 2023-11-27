# UlasBuku - Aplikasi Review Buku

## Anggota Kelompok
- Darrel Danadyaksa Poli (2206081995)
- Adrasa Cantya Salaka (2206829603)
- Surya Raavi Adiputra (2206082404)
- Dhemas Wicaksono Nugroho (2206030786)

## Deskripsi Aplikasi
Judul Aplikasi: **UlasBuku**

**UlasBuku** adalah sebuah aplikasi yang memungkinkan pengguna untuk memberikan ulasan dan review terhadap buku-buku yang telah mereka baca. Aplikasi ini memungkinkan pengguna untuk berbagi pengalaman membaca mereka dan memberikan informasi berguna kepada orang lain yang ingin membaca buku tersebut. 

## Modul Aplikasi
Aplikasi **UlasBuku** akan memiliki beberapa modul utama, termasuk:
1. **Forum Buku**: Pengguna dapat berpartisipasi dalam diskusi dan berbagi ulasan tentang buku-buku tertentu.
2. **Tambah Buku**: Pengguna dapat menambahkan informasi tentang buku-buku yang telah mereka baca.
3. **Profile**: Pengguna dapat melihat profil mereka sendiri.
4. **Pesan Sesama Pengguna**: Pengguna dapat berkomunikasi satu sama lain melalui pesan.
   
## Sumber Data
Data buku akan diambil dari API yang telah dibuat pada tugas kelompok yang dikerjakan sebagai proyek tengah semester. Data yang diambil tersebut diperoleh melalui [**Kaggle**](https://www.kaggle.com/datasets/arashnic/book-recommendation-dataset/). API ini akan memberikan informasi tentang buku-buku yang tersedia, termasuk judul, penulis, tahun publikasi, penerbit, dan sampul buku.

## Peran Pengguna
Aplikasi **UlasBuku** akan memiliki beberapa peran pengguna beserta deskripsinya:

1. **Unregistered User**: Pengguna yang belum mendaftar atau login.
   - Melihat forum buku.
   - Melihat daftar buku yang ada.
   - Melihat rekomendasi buku di homepage.

2. **Registered/Login User**: Pengguna yang telah mendaftar dan login.
   - Melihat forum buku.
   - Berpartisipasi dalam diskusi forum.
   - Melihat rekomendasi buku di homepage.
   - Menambahkan informasi tentang buku yang telah mereka baca.
   - Mengirim dan menerima pesan dari pengguna lain.
   - Melihat profil diri sendiri.

## Alur Pengintegrasian dengan web service

Login dengan menggunakan fetch dari website django yang telah dibuat. Kemudian bisa melihat buku-buku yang sudah ada. Lalu bisa membuat review baru terhadap sebuah buku. 

Selain itu, berikut adalah _flowchart_ penggunaan aplikasi kami:

![Alt text](ReadmePic/Flowchart.png)

# Tautan Berita Acara

Tautan berita acara dapat dilihat pada [tautan berikut](https://docs.google.com/spreadsheets/d/17apHL7ozM74HWTzj6h73pk9-J-Uv__YU/edit#gid=2005070693)

## Lisensi
Aplikasi ini akan dilisensikan di bawah [lisensi MIT](LICENSE).

---

**Catatan**: Aplikasi **UlasBuku** masih dalam tahap pengembangan awal. Kami berharap aplikasi ini akan menjadi platform yang berguna bagi pembaca buku untuk berbagi pengalaman mereka dan memperluas wawasan literasi. Terima kasih atas dukungan Anda!
