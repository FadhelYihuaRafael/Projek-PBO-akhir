<%-- 
    Document   : Edit Menu
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.MenuDAO"%>
<%@page import="dao.KategoriMenuDAO"%>
<%@page import="dao.ResepDAO"%>
<%@page import="model.Menu"%>
<%@page import="model.KategoriMenu"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
    String errorMsg = null;
    
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        MenuDAO menuDAO = new MenuDAO();
        menu = menuDAO.ambilMenuById(id);
        
        if (menu == null) {
            errorMsg = "Menu tidak ditemukan!";
        }
    } catch (Exception e) {
        errorMsg = "Error: " + e.getMessage();
        e.printStackTrace();
    }
    
    // ambil semua kategori untuk dropdown
    List<KategoriMenu> listKategori = new ArrayList<>();
    try {
        KategoriMenuDAO kategoriDAO = new KategoriMenuDAO();
        listKategori = kategoriDAO.getAll();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // Hitung HPP untuk preview harga jual
    Float hpp = 0.0f;
    Integer hargaJualTerhitung = 0;
    if (menu != null && menu.getId() != null) {
        try {
            ResepDAO resepDAO = new ResepDAO();
            hpp = resepDAO.hitungHPPByMenuId(menu.getId());
            if (hpp != null && hpp > 0 && menu.getMarginPersen() != null) {
                hargaJualTerhitung = Math.round(hpp + (hpp * menu.getMarginPersen() / 100));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
    <title>Edit Menu | SeoDash</title>
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
                                    <h5 class="card-title fw-semibold mb-4">Edit Menu</h5>
                                    
                                    <form method="post" action="<%= contextPath %>/MenuController">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%= menu.getId() %>">
                                        
                                        <div class="mb-3">
                                            <label for="kategoriId" class="form-label">Kategori</label>
                                            <select class="form-select" id="kategoriId" name="kategoriId" required>
                                                <option value="">Pilih Kategori</option>
                                                <% for (KategoriMenu kategori : listKategori) { %>
                                                    <option value="<%= kategori.getId() %>" 
                                                            <%= menu.getKategoriId() != null && menu.getKategoriId().equals(kategori.getId()) ? "selected" : "" %>>
                                                        <%= kategori.getNama() %>
                                                    </option>
                                                <% } %>
                                            </select>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="namaMenu" class="form-label">Nama Menu</label>
                                            <input type="text" class="form-control" id="namaMenu" name="namaMenu" value="<%= menu.getNamaMenu() != null ? menu.getNamaMenu() : "" %>" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="marginPersen" class="form-label">
                                                Margin (%) <span class="text-danger">*</span>
                                            </label>
                                            <input type="number" class="form-control" id="marginPersen" name="marginPersen" 
                                                   value="<%= menu.getMarginPersen() != null ? menu.getMarginPersen() : "" %>" 
                                                   placeholder="Masukkan margin dalam persen (contoh: 50 untuk 50%)" 
                                                   step="0.01" min="0" required>
                                            <small class="form-text text-muted">Harga jual akan dihitung otomatis: HPP + (HPP × Margin%)</small>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label">HPP</label>
                                            <input type="text" class="form-control" readonly 
                                                   value="<%= hpp != null && hpp > 0 ? "Rp " + String.format("%,.0f", hpp) : "Belum ada resep" %>">
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label">Harga Jual (Otomatis)</label>
                                            <input type="text" class="form-control" readonly 
                                                   value="<%= hargaJualTerhitung > 0 ? "Rp " + String.format("%,d", hargaJualTerhitung) : "Akan dihitung setelah resep dibuat" %>">
                                            <small class="form-text text-muted">Harga jual dihitung dari HPP + (HPP × Margin%)</small>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="deskripsi" class="form-label">Deskripsi</label>
                                            <textarea class="form-control" id="deskripsi" name="deskripsi" rows="3"><%= menu.getDeskripsi() != null ? menu.getDeskripsi() : "" %></textarea>
                                        </div>
                                        
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-primary">
                                                <iconify-icon icon="mdi:content-save"></iconify-icon>
                                                Simpan Perubahan
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


