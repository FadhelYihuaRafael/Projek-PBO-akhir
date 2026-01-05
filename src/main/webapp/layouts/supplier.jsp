<%-- 
    Document   : supplier layout
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="dao.SupplierDAO"%>
<%@page import="model.Supplier"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
    // cek session dulu
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // ambil data session
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("userId");
    
    // variabel untuk pesan
    String successMessage = null;
    String errorMessage = null;
    
    // buat object DAO
    SupplierDAO supplierDAO = new SupplierDAO();
    
    // handle POST request untuk tambah dan update
    if ("POST".equals(request.getMethod())) {
        String action = request.getParameter("action");
        String nama = request.getParameter("nama");
        String telepon = request.getParameter("telepon");
        String alamat = request.getParameter("alamat");
        
        if ("update".equals(action)) {
            // update supplier
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                
                Supplier supplierUpdate = new Supplier();
                supplierUpdate.setId(id);
                supplierUpdate.setNama(nama);
                supplierUpdate.setTelepon(telepon);
                supplierUpdate.setAlamat(alamat);
                
                boolean updateSuccess = supplierDAO.updateSupplier(supplierUpdate);
                
                if (updateSuccess) {
                    successMessage = "Supplier berhasil diupdate!";
                } else {
                    errorMessage = "Gagal mengupdate supplier!";
                }
            } catch (NumberFormatException e) {
                errorMessage = "Error: ID supplier tidak valid!";
                e.printStackTrace();
            } catch (Exception e) {
                errorMessage = "Error: " + e.getMessage();
                e.printStackTrace();
            }
        } else {
            // tambah supplier baru
            if (nama == null || nama.trim().isEmpty()) {
                errorMessage = "Nama supplier tidak boleh kosong!";
            } else if (telepon == null || telepon.trim().isEmpty()) {
                errorMessage = "Nomor telepon tidak boleh kosong!";
            } else if (alamat == null || alamat.trim().isEmpty()) {
                errorMessage = "Alamat tidak boleh kosong!";
            } else if (userId == null) {
                errorMessage = "Session expired! Silakan login kembali.";
            } else {
                try {
                    Supplier supplierBaru = new Supplier(
                        nama.trim(), 
                        telepon.trim(), 
                        alamat.trim(), 
                        userId
                    );
                    
                    boolean tambahSuccess = supplierDAO.tambahSupplier(supplierBaru);
                    
                    if (tambahSuccess) {
                        successMessage = "Supplier berhasil ditambahkan!";
                    } else {
                        errorMessage = "Gagal menambahkan supplier!";
                    }
                } catch (Exception e) {
                    errorMessage = "Error: " + e.getMessage();
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
            
            boolean deleteSuccess = supplierDAO.hapusSupplier(id);
            
            if (deleteSuccess) {
                successMessage = "Supplier berhasil dihapus!";
            } else {
                errorMessage = "Gagal menghapus supplier!";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Error: ID supplier tidak valid!";
            e.printStackTrace();
        } catch (Exception e) {
            errorMessage = "Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
    
    // ambil semua data supplier
    List<Supplier> listSupplier = new ArrayList<>();
    try {
        listSupplier = supplierDAO.ambilSemuaSupplier();
        
        if (listSupplier == null) {
            listSupplier = new ArrayList<>();
        }
    } catch (Exception e) {
        errorMessage = "Error mengambil data: " + e.getMessage();
        e.printStackTrace();
        listSupplier = new ArrayList<>();
    }
    
    // ambil data supplier untuk edit
    Supplier supplierEdit = null;
    if ("edit".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            supplierEdit = supplierDAO.ambilSupplierById(id);
            
            if (supplierEdit == null) {
                errorMessage = "Supplier dengan ID " + id + " tidak ditemukan!";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Error: ID supplier tidak valid!";
            e.printStackTrace();
        } catch (Exception e) {
            errorMessage = "Error mengambil data edit: " + e.getMessage();
            e.printStackTrace();
        }
    }
    
    // set attribute untuk diakses di halaman lain
    request.setAttribute("daftarSupplier", listSupplier);
    request.setAttribute("supplierEdit", supplierEdit);
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
    <title>SeoDash Dashboard | <%= role.toUpperCase() %></title>
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
            
            <%-- Include Content Supplier --%>
            <jsp:include page="../pages/supplier.jsp" />
            
            <%-- Include Footer --%>
            <jsp:include page="footer.jsp" />
        </div>
    </div>
    
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
