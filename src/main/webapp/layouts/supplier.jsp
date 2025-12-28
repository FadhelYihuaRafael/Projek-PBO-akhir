<%-- 
    Document   : dashboard
    Created on : 17 Dec 2025, 17.46.49
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Proteksi Halaman: Jika session kosong, tendang kembali ke login_1.jsp
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../login_1.jsp");
        return;
    }
    
    // 2. Ambil data dari session untuk ditampilkan di UI
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SeoDash Dashboard | <%= role.toUpperCase() %></title>
  <link rel="shortcut icon" type="image/png" href="../assets/images/logos/seodashlogo.png" />
  <link rel="stylesheet" href="../assets/css/styles.min.css" />
</head>

<body>
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
    
    <%-- Include Navbar/Sidebar --%>
    <jsp:include page="navbar.jsp" />
    
    <div class="body-wrapper">
      <%-- Include Header --%>
      <jsp:include page="header.jsp" />
      
      <div class="container-fluid">
        <div class="row">
    <div class="col-12">
        <div class="card shadow-sm">
            <div class="card-body">

                <!-- Judul & Tombol Tambahkan -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="card-title fw-semibold mb-0">Data Supplier</h5>
                    <a href="#" class="btn btn-primary">
                        <iconify-icon icon="mdi:plus"></iconify-icon>
                        Tambahkan
                    </a>
                </div>

                <!-- Tabel Supplier -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-light text-center">
                            <tr>
                                <th>No</th>
                                <th>Nama</th>
                                <th>Nomor Telepon</th>
                                <th>Alamat</th>
                                <th>Created By</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="text-center">1</td>
                                <td>PT Sumber Makmur</td>
                                <td>081234567890</td>
                                <td>Jakarta Selatan</td>
                                <td><%= username %></td>
                                <td class="text-center">
                                    <a href="#" class="btn btn-warning btn-sm">
                                        <iconify-icon icon="mdi:pencil"></iconify-icon>
                                        Edit
                                    </a>
                                    <a href="#" class="btn btn-danger btn-sm">
                                        <iconify-icon icon="mdi:delete"></iconify-icon>
                                        Delete
                                    </a>
                                </td>
                            </tr>

                            <tr>
                                <td class="text-center">2</td>
                                <td>CV Jaya Abadi</td>
                                <td>082233445566</td>
                                <td>Depok</td>
                                <td>Admin</td>
                                <td class="text-center">
                                    <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>

                            <tr>
                                <td class="text-center">3</td>
                                <td>UD Maju Bersama</td>
                                <td>083344556677</td>
                                <td>Bogor</td>
                                <td>Admin</td>
                                <td class="text-center">
                                    <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                </td>


        <%-- Include Footer --%>
    </div>
</div>
</div>
<jsp:include page="footer.jsp" />

  <script src="../assets/libs/jquery/dist/jquery.min.js"></script>
  <script src="../assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/libs/apexcharts/dist/apexcharts.min.js"></script>
  <script src="../assets/libs/simplebar/dist/simplebar.js"></script>
  <script src="../assets/js/sidebarmenu.js"></script>
  <script src="../assets/js/app.min.js"></script>
  <script src="../assets/js/dashboard.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
</body>
</html>