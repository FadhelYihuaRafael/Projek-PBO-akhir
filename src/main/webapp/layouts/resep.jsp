<%-- 
    Document   : Resep Layout
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
    
    // Ambil data dari request attribute yang dikirim oleh controller
    // Jika tidak ada, berarti akses langsung ke JSP, redirect ke controller
    List<Resep> listResep = (List<Resep>) request.getAttribute("daftarResep");
    List<Menu> listMenu = (List<Menu>) request.getAttribute("daftarMenu");
    List<BahanBaku> listBahan = (List<BahanBaku>) request.getAttribute("daftarBahan");
    String successMsg = (String) request.getAttribute("pesanSukses");
    String errorMsg = (String) request.getAttribute("pesanError");
    
    // Jika data tidak ada dari controller, redirect ke controller
    if (listResep == null) {
        response.sendRedirect("ResepController");
        return;
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
