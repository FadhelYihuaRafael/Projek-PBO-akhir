<%-- 
    Document   : Delete Supplier
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Proteksi Halaman
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../login.jsp");
        return;
    }
    
    // Ambil data dari session
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    // Set attribute untuk bisa diakses di included pages
    request.setAttribute("username", username);
    request.setAttribute("role", role);
%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hapus Supplier | SeoDash</title>
    <link rel="shortcut icon" type="image/png" href="../../assets/images/logos/seodashlogo.png" />
    <link rel="stylesheet" href="../../assets/css/styles.min.css" />
</head>

<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6"
        data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

        <%-- Include Navbar/Sidebar --%>
        <jsp:include page="../../layouts/navbar.jsp" />

        <div class="body-wrapper">
            <%-- Include Header --%>
            <jsp:include page="../../layouts/header.jsp" />

            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title fw-semibold mb-4">Hapus Supplier</h5>
                                
                                <div class="alert alert-warning">
                                    <iconify-icon icon="mdi:alert"></iconify-icon>
                                    <strong>Peringatan!</strong> Apakah Anda yakin ingin menghapus supplier ini? 
                                    Tindakan ini tidak dapat dibatalkan.
                                </div>
                                
                                <div class="mb-3">
                                    <p><strong>Nama:</strong> PT Sumber Makmur</p>
                                    <p><strong>Telepon:</strong> 081234567890</p>
                                    <p><strong>Alamat:</strong> Jakarta Selatan</p>
                                </div>
                                
                                <form method="post" action="#">
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-danger">
                                            <iconify-icon icon="mdi:delete"></iconify-icon>
                                            Ya, Hapus
                                        </button>
                                        <a href="../../layouts/supplier.jsp" class="btn btn-secondary">
                                            <iconify-icon icon="mdi:cancel"></iconify-icon>
                                            Batal
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Include Footer --%>
            <jsp:include page="../../layouts/footer.jsp" />
        </div>
    </div>

    <script src="../../assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="../../assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../../assets/libs/simplebar/dist/simplebar.js"></script>
    <script src="../../assets/js/sidebarmenu.js"></script>
    <script src="../../assets/js/app.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
</body>

</html>

