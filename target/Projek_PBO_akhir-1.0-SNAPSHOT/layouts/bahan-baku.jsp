<%-- 
    Document   : Bahan Baku Layout
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="dao.BahanBakuDAO"%>
<%@page import="dao.SupplierDAO"%>
<%@page import="model.BahanBaku"%>
<%@page import="model.Supplier"%>
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
    BahanBakuDAO bahanDAO = new BahanBakuDAO();
    SupplierDAO supplierDAO = new SupplierDAO();
    
    // handle POST request untuk tambah dan update
    if ("POST".equals(request.getMethod())) {
        String action = request.getParameter("action");
        String namaBahan = request.getParameter("namaBahan");
        String supplierIdStr = request.getParameter("supplierId");
        String satuan = request.getParameter("satuan");
        String hargaStr = request.getParameter("harga");
        String stokStr = request.getParameter("stok");
        
        if ("update".equals(action)) {
            // update bahan baku
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int supplierId = Integer.parseInt(supplierIdStr);
                float harga = Float.parseFloat(hargaStr);
                int stok = Integer.parseInt(stokStr);
                
                BahanBaku bahanUpdate = new BahanBaku();
                bahanUpdate.setId(id);
                bahanUpdate.setSupplierId(supplierId);
                bahanUpdate.setNamaBahan(namaBahan);
                bahanUpdate.setSatuan(satuan);
                bahanUpdate.setHargaPerSatuan(harga);
                bahanUpdate.setStok(stok);
                
                boolean updateOk = bahanDAO.updateBahanBaku(bahanUpdate);
                
                if (updateOk) {
                    successMsg = "Bahan baku berhasil diupdate!";
                } else {
                    errorMsg = "Gagal mengupdate bahan baku!";
                }
            } catch (NumberFormatException e) {
                errorMsg = "Error: Data tidak valid!";
                e.printStackTrace();
            } catch (Exception e) {
                errorMsg = "Error: " + e.getMessage();
                e.printStackTrace();
            }
        } else {
            // tambah bahan baku baru
            if (namaBahan == null || namaBahan.trim().isEmpty()) {
                errorMsg = "Nama bahan tidak boleh kosong!";
            } else if (supplierIdStr == null || supplierIdStr.trim().isEmpty()) {
                errorMsg = "Supplier harus dipilih!";
            } else if (satuan == null || satuan.trim().isEmpty()) {
                errorMsg = "Satuan tidak boleh kosong!";
            } else if (hargaStr == null || hargaStr.trim().isEmpty()) {
                errorMsg = "Harga tidak boleh kosong!";
            } else if (stokStr == null || stokStr.trim().isEmpty()) {
                errorMsg = "Stok tidak boleh kosong!";
            } else if (userId == null) {
                errorMsg = "Session expired! Silakan login kembali.";
            } else {
                try {
                    int supplierId = Integer.parseInt(supplierIdStr);
                    float harga = Float.parseFloat(hargaStr);
                    int stok = Integer.parseInt(stokStr);
                    
                    if (harga <= 0) {
                        errorMsg = "Harga harus lebih dari 0!";
                    } else if (stok < 0) {
                        errorMsg = "Stok tidak boleh negatif!";
                    } else {
                        BahanBaku bahanBaru = new BahanBaku(
                            supplierId,
                            namaBahan.trim(), 
                            satuan.trim(), 
                            harga, 
                            stok, 
                            userId
                        );
                        
                        boolean tambahOk = bahanDAO.tambahBahanBaku(bahanBaru);
                        
                        if (tambahOk) {
                            successMsg = "Bahan baku berhasil ditambahkan!";
                        } else {
                            errorMsg = "Gagal menambahkan bahan baku!";
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
            
            boolean deleteOk = bahanDAO.hapusBahanBaku(id);
            
            if (deleteOk) {
                successMsg = "Bahan baku berhasil dihapus!";
            } else {
                errorMsg = "Gagal menghapus bahan baku!";
            }
        } catch (NumberFormatException e) {
            errorMsg = "Error: ID bahan baku tidak valid!";
            e.printStackTrace();
        } catch (Exception e) {
            errorMsg = "Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
    
    // ambil semua data bahan baku
    List<BahanBaku> listBahan = new ArrayList<>();
    try {
        listBahan = bahanDAO.ambilSemuaBahanBaku();
        
        if (listBahan == null) {
            listBahan = new ArrayList<>();
        }
    } catch (Exception e) {
        errorMsg = "Error mengambil data: " + e.getMessage();
        e.printStackTrace();
        listBahan = new ArrayList<>();
    }
    
    // ambil semua supplier untuk dropdown
    List<Supplier> listSupplier = new ArrayList<>();
    try {
        listSupplier = supplierDAO.ambilSemuaSupplier();
        if (listSupplier == null) {
            listSupplier = new ArrayList<>();
        }
    } catch (Exception e) {
        e.printStackTrace();
        listSupplier = new ArrayList<>();
    }
    
    // set attribute untuk diakses di halaman lain
    request.setAttribute("daftarBahan", listBahan);
    request.setAttribute("daftarSupplier", listSupplier);
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
    <title>Bahan Baku | SeoDash Dashboard | <%= role.toUpperCase() %></title>
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

            <%-- Include Content Bahan Baku --%>
            <jsp:include page="../pages/bahan-baku.jsp" />
            
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
