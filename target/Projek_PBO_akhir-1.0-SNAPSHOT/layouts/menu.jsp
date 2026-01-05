<%-- 
    Document   : Menu Layout
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
        response.sendRedirect("../login.jsp"); 
        return; 
    } 
    
    // ambil data session
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("userId");
    
    String successMessage = null;
    String errorMessage = null;
    
    MenuDAO menuDAO = new MenuDAO();
    KategoriMenuDAO kategoriDAO = new KategoriMenuDAO();
    ResepDAO resepDAO = new ResepDAO();
    
    if ("POST".equals(request.getMethod())) {
        String action = request.getParameter("action");
        String namaMenu = request.getParameter("namaMenu");
        String hargaJualStr = request.getParameter("hargaJual");
        String deskripsi = request.getParameter("deskripsi");
        String kategoriIdStr = request.getParameter("kategoriId");
        
        if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int kategoriId = Integer.parseInt(kategoriIdStr);
                int hargaJual = Integer.parseInt(hargaJualStr);
                
                Menu menuUpdate = new Menu();
                menuUpdate.setId(id);
                menuUpdate.setKategoriId(kategoriId);
                menuUpdate.setNamaMenu(namaMenu);
                menuUpdate.setHargaJual(hargaJual);
                menuUpdate.setDeskripsi(deskripsi);
                
                boolean updateSuccess = menuDAO.updateMenu(menuUpdate);
                
                if (updateSuccess) {
                    successMessage = "Menu berhasil diupdate!";
                } else {
                    errorMessage = "Gagal mengupdate menu!";
                }
            } catch (NumberFormatException e) {
                errorMessage = "Error: Data tidak valid!";
                e.printStackTrace();
            } catch (Exception e) {
                errorMessage = "Error: " + e.getMessage();
                e.printStackTrace();
            }
        } else {
            if (namaMenu == null || namaMenu.trim().isEmpty()) {
                errorMessage = "Nama menu tidak boleh kosong!";
            } else if (hargaJualStr == null || hargaJualStr.trim().isEmpty()) {
                errorMessage = "Harga jual tidak boleh kosong!";
            } else if (kategoriIdStr == null || kategoriIdStr.trim().isEmpty()) {
                errorMessage = "Kategori harus dipilih!";
            } else if (userId == null) {
                errorMessage = "Session expired! Silakan login kembali.";
            } else {
                try {
                    int kategoriId = Integer.parseInt(kategoriIdStr);
                    int hargaJual = Integer.parseInt(hargaJualStr);
                    
                    Menu menuBaru = new Menu(
                        kategoriId,
                        namaMenu.trim(), 
                        hargaJual, 
                        deskripsi != null ? deskripsi.trim() : "",
                        userId
                    );
                    
                    boolean tambahSuccess = menuDAO.tambahMenu(menuBaru);
                    
                    if (tambahSuccess) {
                        successMessage = "Menu berhasil ditambahkan!";
                    } else {
                        errorMessage = "Gagal menambahkan menu!";
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Error: Harga jual atau kategori tidak valid!";
                    e.printStackTrace();
                } catch (Exception e) {
                    errorMessage = "Error: " + e.getMessage();
                    e.printStackTrace();
                }
            }
        }
    }
    
    String action = request.getParameter("action");
    if ("delete".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            boolean deleteSuccess = menuDAO.hapusMenu(id);
            
            if (deleteSuccess) {
                successMessage = "Menu berhasil dihapus!";
            } else {
                errorMessage = "Gagal menghapus menu!";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Error: ID menu tidak valid!";
            e.printStackTrace();
        } catch (Exception e) {
            errorMessage = "Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
    
    List<Menu> listMenu = new ArrayList<>();
    try {
        listMenu = menuDAO.ambilSemuaMenu();
        
        if (listMenu == null) {
            listMenu = new ArrayList<>();
        }
    } catch (Exception e) {
        errorMessage = "Error mengambil data: " + e.getMessage();
        e.printStackTrace();
        listMenu = new ArrayList<>();
    }
    
    List<KategoriMenu> listKategori = new ArrayList<>();
    try {
        listKategori = kategoriDAO.ambilSemuaKategori();
        if (listKategori == null) {
            listKategori = new ArrayList<>();
        }
    } catch (Exception e) {
        e.printStackTrace();
        listKategori = new ArrayList<>();
    }
    
    request.setAttribute("daftarMenu", listMenu);
    request.setAttribute("daftarKategori", listKategori);
    request.setAttribute("pesanSukses", successMessage);
    request.setAttribute("pesanError", errorMessage);
    request.setAttribute("username", username);
    request.setAttribute("role", role);
%>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Menu | SeoDash Dashboard | <%= role.toUpperCase() %></title>
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

            <%-- Include Content Menu --%>
            <jsp:include page="../pages/menu.jsp" />
            
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
