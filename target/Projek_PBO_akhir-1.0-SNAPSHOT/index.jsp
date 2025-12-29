<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HitungHPP | Solusi Akurasi Laba Bisnis Anda</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #0061ff;
            --secondary-color: #60efff;
            --dark-blue: #002b6b;
            --soft-bg: #f8fbff;
        }

        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            scroll-behavior: smooth;
            background-color: var(--soft-bg);
            color: #2d3436;
        }

        .hero-section {
            background: radial-gradient(circle at top right, var(--secondary-color), transparent),
                        linear-gradient(135deg, var(--primary-color) 0%, var(--dark-blue) 100%);
            color: white;
            padding: 120px 0 80px;
            clip-path: polygon(0 0, 100% 0, 100% 90%, 0% 100%);
        }

        /* FITUR STYLING */
        .feature-card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            border: none;
            transition: all 0.3s ease;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.05);
        }
        .feature-icon {
            width: 60px;
            height: 60px;
            background: var(--soft-bg);
            color: var(--primary-color);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        /* TENTANG STYLING */
        .about-img-wrapper {
            position: relative;
            padding: 20px;
        }
        .about-img-wrapper img {
            border-radius: 30px;
            z-index: 2;
            position: relative;
        }
        .about-img-wrapper::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 80%;
            height: 80%;
            background: var(--secondary-color);
            border-radius: 30px;
            z-index: 1;
            opacity: 0.3;
        }

        /* TEAM STYLING */
        .team-card {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: 24px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .team-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1) !important;
        }
        .avatar-wrapper {
            /* Lingkaran luar dihapus sesuai permintaan */
            display: inline-block;
            margin-top: 25px;
        }
        .card-img-top {
            border-radius: 50%;
            width: 100px;
            height: 100px;
            /* Background berubah menjadi Biru sesuai permintaan */
            background: var(--primary-color);
            padding: 5px;
            object-fit: cover;
        }

        .nim-badge {
            background: #eef2ff;
            color: var(--primary-color);
            font-size: 0.75rem;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 8px;
        }

        .section-title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--primary-color);
            margin: 15px auto;
            border-radius: 2px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm py-3">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <div class="bg-primary text-white rounded-3 p-1 me-2" style="width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-calculator"></i>
                </div>
                <span class="fw-bold text-dark">Hitung<span class="text-primary">HPP</span></span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto fw-semibold align-items-center">
                    <li class="nav-item"><a class="nav-link mx-2" href="#fitur">Fitur</a></li>
                    <li class="nav-item"><a class="nav-link mx-2" href="#tentang">Tentang</a></li>
                    <li class="nav-item"><a class="nav-link mx-2" href="#tim">Tim Kami</a></li>
                    <li class="nav-item">
                        <a class="btn btn-primary text-white ms-lg-3 px-4 shadow-sm" href="login.jsp">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-section text-center">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <h1 class="display-3 fw-bold mb-4">Kelola Harga Pokok <br>Lebih <span style="color: var(--secondary-color)">Akurat</span></h1>
                    <p class="lead mb-5 opacity-75">Sederhanakan perhitungan biaya produksi Anda dengan teknologi cloud. Dirancang untuk efisiensi bisnis modern.</p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="login.jsp" class="btn btn-light btn-lg px-4 fw-bold shadow">Coba Demo Gratis</a>
                        <a href="#fitur" class="btn btn-outline-light btn-lg px-4 fw-bold">Pelajari Fitur</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section id="fitur" class="py-5">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold section-title">Fitur Unggulan</h2>
                <p class="text-muted">Kemudahan dalam setiap langkah perhitungan bisnis Anda.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card shadow-sm text-center">
                        <div class="feature-icon mx-auto"><i class="fas fa-bolt"></i></div>
                        <h5 class="fw-bold">Hitung Cepat</h5>
                        <p class="text-muted">Proses kalkulasi Harga Pokok Penjualan yang instan dan presisi dalam hitungan detik.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card shadow-sm text-center">
                        <div class="feature-icon mx-auto"><i class="fas fa-database"></i></div>
                        <h5 class="fw-bold">Manajemen Data</h5>
                        <p class="text-muted">Simpan dan kelola data bahan baku serta produk Anda secara terorganisir di cloud.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card shadow-sm text-center">
                        <div class="feature-icon mx-auto"><i class="fas fa-chart-pie"></i></div>
                        <h5 class="fw-bold">Laporan Akurat</h5>
                        <p class="text-muted">Visualisasi margin keuntungan yang membantu pengambilan keputusan bisnis Anda.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="tentang" class="py-5 bg-white shadow-sm rounded-5 mx-3 mx-lg-5">
        <div class="container py-5">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-5 mb-lg-0">
                    <div class="about-img-wrapper">
                        <img src="https://images.unsplash.com/photo-1554224155-6726b3ff858f?auto=format&fit=crop&w=800&q=80" alt="About HitungHPP" class="img-fluid shadow-lg">
                    </div>
                </div>
                <div class="col-lg-6 ps-lg-5">
                    <h2 class="fw-bold mb-4">Apa itu HitungHPP?</h2>
                    <p class="text-muted mb-4">HitungHPP adalah platform digital yang lahir untuk membantu pengusaha UMKM hingga skala menengah dalam mengatasi kerumitan menghitung harga pokok produksi.</p>
                    <p class="text-muted mb-4">Kami percaya bahwa transparansi angka adalah kunci sukses bisnis. Dengan alat kami, Anda tidak perlu lagi melakukan perhitungan manual yang berisiko salah tulis.</p>
                    <div class="d-flex gap-4">
                        <div class="text-center">
                            <h4 class="fw-bold text-primary">100%</h4>
                            <small class="text-muted">Digital</small>
                        </div>
                        <div class="vr"></div>
                        <div class="text-center">
                            <h4 class="fw-bold text-primary">Akurat</h4>
                            <small class="text-muted">Hasil</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="tim" class="py-5">
        <div class="container py-5 text-center">
            <h2 class="fw-bold section-title">Anggota Kelompok Kami</h2>
            <div class="row g-4 justify-content-center mt-4">
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="card h-100 border-0 shadow-sm team-card">
                        <div class="avatar-wrapper"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Anya" class="card-img-top"></div>
                        <div class="card-body">
                            <h6 class="fw-bold mb-1">Ahmad Riza Muzaki</h6>
                            <span class="nim-badge">0110224101</span>
                            <p class="text-uppercase mb-0 fw-bold text-muted" style="font-size: 0.6rem;">Ketua</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="card h-100 border-0 shadow-sm team-card">
                        <div class="avatar-wrapper"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Felix" class="card-img-top"></div>
                        <div class="card-body">
                            <h6 class="fw-bold mb-1">Alifa Fazilatun Nisa</h6>
                            <span class="nim-badge">0110224198</span>
                            <p class="text-uppercase mb-0 fw-bold text-muted" style="font-size: 0.6rem;">Anggota</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="card h-100 border-0 shadow-sm team-card">
                        <div class="avatar-wrapper"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Budi" class="card-img-top"></div>
                        <div class="card-body">
                            <h6 class="fw-bold mb-1">Fadhel Yihua Rafael</h6>
                            <span class="nim-badge">0110224147</span>
                            <p class="text-uppercase mb-0 fw-bold text-muted" style="font-size: 0.6rem;">Anggota</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="card h-100 border-0 shadow-sm team-card">
                        <div class="avatar-wrapper"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Maria" class="card-img-top"></div>
                        <div class="card-body">
                            <h6 class="fw-bold mb-1">Rama Aditia</h6>
                            <span class="nim-badge">0110224160</span>
                            <p class="text-uppercase mb-0 fw-bold text-muted" style="font-size: 0.6rem;">Anggota</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="card h-100 border-0 shadow-sm team-card">
                        <div class="avatar-wrapper"><img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Kevin" class="card-img-top"></div>
                        <div class="card-body">
                            <h6 class="fw-bold mb-1">Muhammad Faqih Rayya</h6>
                            <span class="nim-badge">0110224212</span>
                            <p class="text-uppercase mb-0 fw-bold text-muted" style="font-size: 0.6rem;">Anggota</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white py-5">
        <div class="container text-center">
            <p class="mb-0 text-secondary">&copy; <%= new java.util.Date().getYear() + 1900 %> HitungHPP Indonesia. Semua Hak Dilindungi. Create BY Kelompok 6.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>