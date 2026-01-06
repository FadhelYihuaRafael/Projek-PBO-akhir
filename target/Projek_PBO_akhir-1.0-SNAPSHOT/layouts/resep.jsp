<%-- 
    Document   : Resep Layout
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="dao.ResepDAO"%>
<%@page import="dao.MenuDAO"%>
<%@page import="dao.BahanBakuDAO"%>
<%@page import="model.Resep"%>
<%@page import="model.Menu"%>
<%@page import="model.BahanBaku"%>
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
    ResepDAO resepDAO = new ResepDAO();
    MenuDAO menuDAO = new MenuDAO();
    BahanBakuDAO bahanDAO = new BahanBakuDAO();
    
    // handle POST request untuk tambah dan update
    if ("POST".equals(request.getMethod())) {
        String action = request.getParameter("action");
        String menuIdStr = request.getParameter("menuId");
        String bahanBakuIdStr = request.getParameter("bahanBakuId");
        String jumlahStr = request.getParameter("jumlah");
        
        if ("update".equals(action)) {
            // update resep
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int menuId = Integer.parseInt(menuIdStr);
                int bahanBakuId = Integer.parseInt(bahanBakuIdStr);
                float jumlah = Float.parseFloat(jumlahStr);
                
                Resep resepUpdate = new Resep();
                resepUpdate.setId(id);
                resepUpdate.setMenuId(menuId);
                resepUpdate.setBahanBakuId(bahanBakuId);
                resepUpdate.setJumlahDibutuhkan(jumlah);
                
                boolean updateOk = resepDAO.update(resepUpdate);
                
                if (updateOk) {
                    successMsg = "Resep berhasil diupdate!";
                } else {
                    errorMsg = "Gagal mengupdate resep!";
                }
            } catch (NumberFormatException e) {
                errorMsg = "Error: Data tidak valid!";
                e.printStackTrace();
            } catch (Exception e) {
                errorMsg = "Error: " + e.getMessage();
                e.printStackTrace();
            }
        } else {
            // tambah resep baru
            if (menuIdStr == null || menuIdStr.trim().isEmpty()) {
                errorMsg = "Menu harus dipilih!";
            } else if (bahanBakuIdStr == null || bahanBakuIdStr.trim().isEmpty()) {
                errorMsg = "Bahan baku harus dipilih!";
            } else if (jumlahStr == null || jumlahStr.trim().isEmpty()) {
                errorMsg = "Jumlah tidak boleh kosong!";
            } else if (userId == null) {
                errorMsg = "Session expired! Silakan login kembali.";
            } else {
                try {
                    int menuId = Integer.parseInt(menuIdStr);
                    int bahanBakuId = Integer.parseInt(bahanBakuIdStr);
                    float jumlah = Float.parseFloat(jumlahStr);
                    
                    if (jumlah <= 0) {
                        errorMsg = "Jumlah harus lebih dari 0!";
                    } else {
                        Resep resepBaru = new Resep(
                            menuId,
                            bahanBakuId, 
                            jumlah, 
                            userId
                        );
                        
                        boolean tambahOk = resepDAO.insert(resepBaru);
                        
                        if (tambahOk) {
                            successMsg = "Resep berhasil ditambahkan!";
                        } else {
                            errorMsg = "Gagal menambahkan resep!";
                        }
                    }
                } catch (NumberFormatException e) {
                    errorMsg = "Error: Data tidak valid!";
                    e.printStackTrace();
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
            
            boolean deleteOk = resepDAO.delete(id);
            
            if (deleteOk) {
                successMsg = "Resep berhasil dihapus!";
            } else {
                errorMsg = "Gagal menghapus resep!";
            }
        } catch (NumberFormatException e) {
            errorMsg = "Error: ID resep tidak valid!";
            e.printStackTrace();
        } catch (Exception e) {
            errorMsg = "Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
    
    // ambil semua data resep
    List<Resep> listResep = new ArrayList<>();
    try {
        listResep = resepDAO.getAll();
        
        if (listResep == null) {
            listResep = new ArrayList<>();
        }
    } catch (Exception e) {
        errorMsg = "Error mengambil data: " + e.getMessage();
        e.printStackTrace();
        listResep = new ArrayList<>();
    }
    
    // ambil semua menu untuk dropdown
    List<Menu> listMenu = new ArrayList<>();
    try {
        listMenu = menuDAO.getAll();
        if (listMenu == null) {
            listMenu = new ArrayList<>();
        }
    } catch (Exception e) {
        e.printStackTrace();
        listMenu = new ArrayList<>();
    }
    
    // ambil semua bahan baku untuk dropdown
    List<BahanBaku> listBahan = new ArrayList<>();
    try {
        listBahan = bahanDAO.getAll();
        if (listBahan == null) {
            listBahan = new ArrayList<>();
        }
    } catch (Exception e) {
        e.printStackTrace();
        listBahan = new ArrayList<>();
    }
    
    // set attribute untuk diakses di halaman lain
    request.setAttribute("daftarResep", listResep);
    request.setAttribute("daftarMenu", listMenu);
    request.setAttribute("daftarBahan", listBahan);
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
    <title>Resep | SeoDash Dashboard | <%= role.toUpperCase() %></title>
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

            <%-- Include Content Resep --%>
            <jsp:include page="../pages/resep.jsp" />
            
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
