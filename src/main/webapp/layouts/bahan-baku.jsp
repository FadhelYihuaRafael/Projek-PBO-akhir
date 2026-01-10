<%-- 
    Document   : Bahan Baku Layout
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
    
    // Ambil data dari request attribute yang dikirim oleh controller
    // Jika tidak ada, berarti akses langsung ke JSP, redirect ke controller
    List<BahanBaku> listBahan = (List<BahanBaku>) request.getAttribute("daftarBahan");
    List<Supplier> listSupplier = (List<Supplier>) request.getAttribute("daftarSupplier");
    String successMsg = (String) request.getAttribute("pesanSukses");
    String errorMsg = (String) request.getAttribute("pesanError");
    
    // Jika data tidak ada dari controller, redirect ke controller
    if (listBahan == null) {
        response.sendRedirect("../BahanBakuController");
        return;
    }
    
    // set attribute untuk diakses di halaman lain
    request.setAttribute("daftarBahan", listBahan);
    request.setAttribute("daftarSupplier", listSupplier);
    request.setAttribute("pesanSukses", successMsg);
    request.setAttribute("pesanError", errorMsg);
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
    <title>Bahan Baku | SeoDash Dashboard | <%= role.toUpperCase() %></title>
    <link rel="shortcut icon" type="image/png" href="<%= contextPath %>/assets/images/logos/seodashlogo.png" />
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/styles.min.css" />
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
        </div>
    </div>

    <script src="<%= contextPath %>/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="<%= contextPath %>/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= contextPath %>/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
    <script src="<%= contextPath %>/assets/libs/simplebar/dist/simplebar.js"></script>
    <script src="<%= contextPath %>/assets/js/sidebarmenu.js"></script>
    <script src="<%= contextPath %>/assets/js/app.min.js"></script>
    <script src="<%= contextPath %>/assets/js/dashboard.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
</body>

</html>
