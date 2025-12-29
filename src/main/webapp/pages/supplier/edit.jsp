<%-- 
    Document   : Edit Supplier
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
    <title>Edit Supplier | SeoDash</title>
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
                                <h5 class="card-title fw-semibold mb-4">Edit Supplier</h5>
                                
                                <form method="post" action="#">
                                    <div class="mb-3">
                                        <label for="nama" class="form-label">Nama Supplier</label>
                                        <input type="text" class="form-control" id="nama" name="nama" 
                                               value="PT Sumber Makmur" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="telepon" class="form-label">Nomor Telepon</label>
                                        <input type="text" class="form-control" id="telepon" name="telepon" 
                                               value="081234567890" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="alamat" class="form-label">Alamat</label>
                                        <textarea class="form-control" id="alamat" name="alamat" rows="3" required>Jakarta Selatan</textarea>
                                    </div>
                                    
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <iconify-icon icon="mdi:content-save"></iconify-icon>
                                            Simpan Perubahan
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

