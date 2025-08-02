# 🎁 Aplikasi Doorprize

Aplikasi doorprize dengan dua mode: lokal (localStorage) dan Firebase (real-time database).

## 🚀 Quick Start

### Local Development

```bash
# Clone repository
git clone https://github.com/MozesJr/AplikasiUndian.git
cd AplikasiUndian

# Buka di browser
open index.html
# atau
python -m http.server 8000
```

### Docker Deployment

```bash
# Build dan jalankan
docker-compose up -d --build

# Akses aplikasi
http://localhost:8888
```

## 📁 Struktur File

```
├── index.html              # Mode lokal (localStorage)
├── index-firebase.html     # Mode Firebase (real-time)
├── admin.html              # Admin mode lokal
├── admin-firebase.html     # Admin mode Firebase
├── index-selection.html    # Landing page pemilihan mode
├── Dockerfile              # Konfigurasi Docker
├── docker-compose.yml      # Docker Compose
├── nginx.conf              # Konfigurasi Nginx
├── deploy.sh               # Script deployment
└── README.md               # Dokumentasi ini
```

## 🌐 Akses URL

- **Landing Page:** `http://localhost:8888/`
- **Mode Lokal:** `http://localhost:8888/index.html`
- **Mode Firebase:** `http://localhost:8888/index-firebase.html`
- **Admin Lokal:** `http://localhost:8888/admin.html`
- **Admin Firebase:** `http://localhost:8888/admin-firebase.html`

## 🔧 Deployment ke VPS

### Otomatis (Recommended)

```bash
# Download dan jalankan script
curl -sSL https://raw.githubusercontent.com/MozesJr/AplikasiUndian/main/deploy.sh -o deploy.sh
chmod +x deploy.sh
sudo ./deploy.sh
```

### Manual

```bash
# Clone repository
git clone https://github.com/MozesJr/AplikasiUndian.git
cd AplikasiUndian

# Build dan jalankan
docker-compose up -d --build
```

## 📊 Monitoring

```bash
# Lihat status container
docker ps

# Lihat logs
docker logs doorprize-firebase -f

# Health check
curl http://localhost:8888/health
```

## 🔄 Update Aplikasi

```bash
git pull origin main
docker-compose up -d --build
```

## ⚙️ Konfigurasi

### Port

- Default: 8888
- Ubah di `docker-compose.yml` jika diperlukan

### Firebase

- URL: `https://ibudewiundian-default-rtdb.firebaseio.com`
- Konfigurasi di file `index-firebase.html` dan `admin-firebase.html`

## 🎯 Fitur

- ✅ Input peserta dan hadiah
- ✅ Undian acak dengan animasi
- ✅ Pointing manual dari admin
- ✅ Real-time sync (mode Firebase)
- ✅ Riwayat pemenang
- ✅ Responsive design
- ✅ Dockerized deployment

## 🐛 Troubleshooting

### Container tidak start

```bash
docker logs doorprize-firebase
```

### Port sudah digunakan

Ubah port di `docker-compose.yml`:

```yaml
ports:
  - "8889:80" # Ganti 8888 ke 8889
```

### Firebase tidak connect

Periksa URL Firebase di script aplikasi.

## 📝 License

MIT License
