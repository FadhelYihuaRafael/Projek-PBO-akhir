<%-- 
    Document   : Kategori Menu Layout
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="dao.KategoriMenuDAO"%>
<%@page import="model.KategoriMenu"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
    // cek session
    if (session.getAttribute("username") == null) { 
        response.sendRedirect("../login.jsp"); 
        return; 
    } 
    
    // ambil data session
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("userId");
    
    // variabel untuk pesan
    String successMsg = null;
    String errorMsg = null;
    
    // buat object DAO
    KategoriMenuDAO kategoriDAO = new KategoriMenuDAO();
    
    // handle POST request untuk tambah dan update
    if ("POST".equals(request.getMethod())) {
        String action = request.getParameter("action");
        String nama = request.getParameter("nama");
        String deskripsi = request.getParameter("deskripsi");
        
        if ("update".equals(action)) {
            // update kategori
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                
                KategoriMenu kategoriUpdate = new KategoriMenu();
                kategoriUpdate.setId(id);
                kategoriUpdate.setNama(nama);
                kategoriUpdate.setDeskripsi(deskripsi);
                
                boolean updateOk = kategoriDAO.updateKategori(kategoriUpdate);
                
                if (updateOk) {
                    successMsg = "Kategori menu berhasil diupdate!";
                } else {
                    errorMsg = "Gagal mengupdate kategori menu!";
                }
            } catch (NumberFormatException e) {
                errorMsg = "Error: ID kategori tidak valid!";
                e.printStackTrace();
            } catch (Exception e) {
                errorMsg = "Error: " + e.getMessage();
                e.printStackTrace();
            }
        } else {
            // tambah kategori baru
            if (nama == null || nama.trim().isEmpty()) {
                errorMsg = "Nama kategori tidak boleh kosong!";
            } else if (userId == null) {
                errorMsg = "Session expired! Silakan login kembali.";
            } else {
                try {
                    KategoriMenu kategoriBaru = new KategoriMenu(
                        nama.trim(), 
                        deskripsi != null ? deskripsi.trim() : "", 
                        userId
                    );
                    
                    boolean tambahOk = kategoriDAO.tambahKategori(kategoriBaru);
                    
                    if (tambahOk) {
                        successMsg = "Kategori menu berhasil ditambahkan!";
                    } else {
                        errorMsg = "Gagal menambahkan kategori menu!";
                    }
                } catch (Exception e) {
                    errorMsg = "Error: " + e.getMessage();
                    e.printStackTrace();
                }
            }
        }
    }
    
    // handle GET request untuk delete
    String action = request.getParameter("action");
    if ("delete".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            boolean deleteOk = kategoriDAO.hapusKategori(id);
            
            if (deleteOk) {
                successMsg = "Kategori menu berhasil dihapus!";
            } else {
                errorMsg = "Gagal menghapus kategori menu!";
            }
        } catch (NumberFormatException e) {
            errorMsg = "Error: ID kategori tidak valid!";
            e.printStackTrace();
        } catch (Exception e) {
            errorMsg = "Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
    
    // ambil semua data kategori
    List<KategoriMenu> listKategori = new ArrayList<>();
    try {
        listKategori = kategoriDAO.ambilSemuaKategori();
        
        if (listKategori == null) {
            listKategori = new ArrayList<>();
        }
    } catch (Exception e) {
        errorMsg = "Error mengambil data: " + e.getMessage();
        e.printStackTrace();
        listKategori = new ArrayList<>();
    }
    
    // set attribute untuk diakses di halaman lain
    request.setAttribute("daftarKategori", listKategori);
    request.setAttribute("pesanSukses", successMsg);
    request.setAttribute("pesanError", errorMsg);
    request.setAttribute("username", username);
    request.setAttribute("role", role);
%>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kategori Menu | SeoDash Dashboard | <%= role.toUpperCase() %></title>
    <link rel="shortcut icon" type="image/png" href="../assets/images/logos/seodashlogo.png" />
    <link rel="stylesheet" href="../assets/css/styles.min.css" />
</head>

<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

        <%-- Include Navbar/Sidebar --%>
        <jsp:include page="navbar.jsp" />

        <div class="body-wrapper">
            <%-- Include Header --%>
            <jsp:include page="header.jsp" />

            <%-- Include Content Kategori Menu --%>
            <jsp:include page="../pages/kategori-menu.jsp" />
            
            <%-- Include Footer --%>
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
