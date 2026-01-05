<%-- 
    Document   : Delete Resep
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ResepDAO"%>
<%@page import="dao.MenuDAO"%>
<%@page import="dao.BahanBakuDAO"%>
<%@page import="model.Resep"%>
<%@page import="model.Menu"%>
<%@page import="model.BahanBaku"%>
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
    Resep resep = null;
    Menu menu = null;
    BahanBaku bahan = null;
    String errorMsg = null;
    
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        ResepDAO resepDAO = new ResepDAO();
        resep = resepDAO.ambilResepById(id);
        
        if (resep == null) {
            errorMsg = "Resep tidak ditemukan!";
        } else {
            // ambil data menu
            if (resep.getMenuId() != null) {
                MenuDAO menuDAO = new MenuDAO();
                menu = menuDAO.ambilMenuById(resep.getMenuId());
            }
            // ambil data bahan baku
            if (resep.getBahanBakuId() != null) {
                BahanBakuDAO bahanDAO = new BahanBakuDAO();
                bahan = bahanDAO.ambilBahanBakuById(resep.getBahanBakuId());
            }
        }
    } catch (Exception e) {
        errorMsg = "Error: " + e.getMessage();
        e.printStackTrace();
    }
    
    // set attribute
    request.setAttribute("username", username);
    request.setAttribute("role", role);
%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hapus Resep | SeoDash</title>
    <link rel="shortcut icon" type="image/png" href="../../assets/images/logos/seodashlogo.png" />
    <link rel="stylesheet" href="../../assets/css/styles.min.css" />
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
                                <% if (errorMsg != null || resep == null) { %>
                                    <div class="alert alert-danger">
                                        <strong>Error!</strong> <%= errorMsg != null ? errorMsg : "Resep tidak ditemukan!" %>
                                    </div>
                                    <a href="../../layouts/resep.jsp" class="btn btn-secondary">Kembali</a>
                                <% } else { %>
                                    <h5 class="card-title fw-semibold mb-4">Hapus Resep</h5>
                                    
                                    <div class="alert alert-warning">
                                        <iconify-icon icon="mdi:alert"></iconify-icon>
                                        <strong>Peringatan!</strong> Apakah Anda yakin ingin menghapus resep ini? 
                                        Tindakan ini tidak dapat dibatalkan.
                                    </div>
                                    
                                    <div class="mb-3">
                                        <p><strong>Menu:</strong> <%= menu != null ? menu.getNamaMenu() : "-" %></p>
                                        <p><strong>Bahan Baku:</strong> <%= bahan != null ? bahan.getNamaBahan() : "-" %></p>
                                        <p><strong>Jumlah Dibutuhkan:</strong> <%= resep.getJumlahDibutuhkan() != null ? String.format("%.2f", resep.getJumlahDibutuhkan()) + " " + (bahan != null && bahan.getSatuan() != null ? bahan.getSatuan() : "") : "-" %></p>
                                    </div>
                                    
                                    <form method="get" action="../../layouts/resep.jsp">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= resep.getId() %>">
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-danger">
                                                <iconify-icon icon="mdi:delete"></iconify-icon>
                                                Ya, Hapus
                                            </button>
                                            <a href="../../layouts/resep.jsp" class="btn btn-secondary">
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

    <script src="../../assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="../../assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../../assets/libs/simplebar/dist/simplebar.js"></script>
    <script src="../../assets/js/sidebarmenu.js"></script>
    <script src="../../assets/js/app.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
</body>

</html>


