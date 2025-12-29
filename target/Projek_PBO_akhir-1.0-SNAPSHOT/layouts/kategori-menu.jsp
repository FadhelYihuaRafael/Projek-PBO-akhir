<%-- Document : Kategori Menu Layout Created on : 17 Dec 2025 Author : Admin --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% // 1. Proteksi Halaman: Jika session kosong, tendang kembali ke login.jsp
    if (session.getAttribute("username")==null) { 
        response.sendRedirect("../login.jsp"); 
        return; 
    } 
    // 2. Ambil data dari session untuk ditampilkan di UI
    String username=(String) session.getAttribute("username"); 
    String role=(String) session.getAttribute("role");
    // Set attribute untuk bisa diakses di included pages
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
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6"
        data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">

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

