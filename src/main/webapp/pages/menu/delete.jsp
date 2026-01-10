<%-- 
    Document   : Delete Menu
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.MenuDAO"%>
<%@page import="dao.KategoriMenuDAO"%>
<%@page import="model.Menu"%>
<%@page import="model.KategoriMenu"%>
<%
    // cek session
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../login.jsp");
        return;
    }
    
    // ambil data session
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    // ambil ID dari parameter
    Menu menu = null;
    KategoriMenu kategori = null;
    String errorMsg = null;
    
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        MenuDAO menuDAO = new MenuDAO();
        menu = menuDAO.ambilMenuById(id);
        
        if (menu == null) {
            errorMsg = "Menu tidak ditemukan!";
        } else {
            // ambil data kategori
            if (menu.getKategoriId() != null) {
                KategoriMenuDAO kategoriDAO = new KategoriMenuDAO();
                kategori = kategoriDAO.ambilKategoriById(menu.getKategoriId());
            }
        }
    } catch (Exception e) {
        errorMsg = "Error: " + e.getMessage();
        e.printStackTrace();
    }
    
    // set attribute
    request.setAttribute("username", username);
    request.setAttribute("role", role);
    
    // Ambil contextPath untuk path absolut
    String contextPath = request.getContextPath();
%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hapus Menu | SeoDash</title>
    <link rel="shortcut icon" type="image/png" href="<%= contextPath %>/assets/images/logos/seodashlogo.png" />
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/styles.min.css" />
</head>

<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

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
                                <% if (errorMsg != null || menu == null) { %>
                                    <div class="alert alert-danger">
                                        <strong>Error!</strong> <%= errorMsg != null ? errorMsg : "Menu tidak ditemukan!" %>
                                    </div>
                                    <a href="<%= contextPath %>/MenuController" class="btn btn-secondary">Kembali</a>
                                <% } else { %>
                                    <h5 class="card-title fw-semibold mb-4">Hapus Menu</h5>
                                    
                                    <div class="alert alert-warning">
                                        <iconify-icon icon="mdi:alert"></iconify-icon>
                                        <strong>Peringatan!</strong> Apakah Anda yakin ingin menghapus menu ini? 
                                        Tindakan ini tidak dapat dibatalkan.
                                    </div>
                                    
                                    <div class="mb-3">
                                        <p><strong>Nama Menu:</strong> <%= menu.getNamaMenu() != null ? menu.getNamaMenu() : "-" %></p>
                                        <p><strong>Kategori:</strong> <%= kategori != null ? kategori.getNama() : "-" %></p>
                                        <p><strong>Harga Jual:</strong> <%= menu.getHargaJual() != null ? "Rp " + String.format("%,d", menu.getHargaJual()) : "-" %></p>
                                        <p><strong>Deskripsi:</strong> <%= menu.getDeskripsi() != null ? menu.getDeskripsi() : "-" %></p>
                                    </div>
                                    
                                    <form method="get" action="<%= contextPath %>/MenuController">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= menu.getId() %>">
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-danger">
                                                <iconify-icon icon="mdi:delete"></iconify-icon>
                                                Ya, Hapus
                                            </button>
                                            <a href="<%= contextPath %>/MenuController" class="btn btn-secondary">
                                                <iconify-icon icon="mdi:cancel"></iconify-icon>
                                                Batal
                                            </a>
                                        </div>
                                    </form>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Include Footer --%>
            <jsp:include page="../../layouts/footer.jsp" />
        </div>
    </div>

    <script src="<%= contextPath %>/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="<%= contextPath %>/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= contextPath %>/assets/libs/simplebar/dist/simplebar.js"></script>
    <script src="<%= contextPath %>/assets/js/sidebarmenu.js"></script>
    <script src="<%= contextPath %>/assets/js/app.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
</body>

</html>


