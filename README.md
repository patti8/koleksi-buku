# Koleksi Buku Tasks 👍 : 

### ~~Validasi Model~~:
- ~~Buatlah model User dengan atribut username dan email.~~
- ~~Berikan validasi untuk memastikan bahwa username dan email tidak boleh
kosong, dan email harus memiliki format yang valid.~~

### ~~Hubungan Model~~:
- ~~Buatlah dua model, Author dan Book, dengan relasi one-to-many. Seorang
penulis dapat memiliki banyak buku, tetapi setiap buku hanya memiliki satu
penulis.~~
- ~~Implementasikan relasi ini dengan benar dalam model dan database.~~

### Controller dan View:
- ~~Buatlah sebuah kontroler untuk menampilkan daftar buku. Implementasikan
tindakan (action) yang memungkinkan pengguna melihat daftar buku yang
ada.~~
- ~~Lalu, buat tampilan (view) yang menampilkan daftar buku dalam format tabel~~

### Form Handling:
- Buatlah sebuah form untuk membuat buku baru. Form ini harus memiliki field
untuk judul, tahun terbit, dan pilihan penulis dari daftar penulis yang ada
dalam database.
- Setelah buku dibuat, pengguna harus diarahkan kembali ke halaman daftar
buku.

### Background Job:
- Buatlah sebuah background job dengan menggunakan gem Sidekiq atau
Delayed::Job. Job ini harus mengirim email kepada pengguna setelah mereka
membuat buku baru.
- Gunakan konsep pengiriman email asinkron untuk tugas ini.

### Testing:
- Buatlah beberapa pengujian unit untuk model Book. Pastikan untuk menguji
validasi, hubungan model, dan method lain yang relevan dalam model
tersebut.

### Autentikasi dan Otorisasi:
- Implementasikan autentikasi dengan menggunakan gem Devise. Setelahnya,
buatlah filter atau tindakan dalam kontroler yang membatasi akses ke tindakan
tertentu hanya untuk pengguna yang sudah login.

### Pagination:
- Jika daftar buku dalam halaman daftar buku menjadi terlalu panjang,
implementasikan pagination untuk membaginya ke beberapa halaman.

### API Endpoint:
- ~~Buatlah sebuah API endpoint yang memungkinkan pengguna untuk melihat
daftar buku dalam format JSON. Endpoint ini harus memberikan respons
dengan data buku yang sesuai.~~

