<%-- 
    Document   : Edit Resep
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
    Resep resep = null;
    String errorMsg = null;
    
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        ResepDAO resepDAO = new ResepDAO();
        resep = resepDAO.ambilResepById(id);
        
        if (resep == null) {
            errorMsg = "Resep tidak ditemukan!";
        }
    } catch (Exception e) {
        errorMsg = "Error: " + e.getMessage();
        e.printStackTrace();
    }
    
    // ambil semua menu untuk dropdown
    List<Menu> listMenu = new ArrayList<>();
    try {
        MenuDAO menuDAO = new MenuDAO();
        listMenu = menuDAO.ambilSemuaMenu();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // ambil semua bahan baku untuk dropdown
    List<BahanBaku> listBahan = new ArrayList<>();
    try {
        BahanBakuDAO bahanDAO = new BahanBakuDAO();
        listBahan = bahanDAO.ambilSemuaBahanBaku();
    } catch (Exception e) {
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
    <title>Edit Resep | SeoDash</title>
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
                                    <h5 class="card-title fw-semibold mb-4">Edit Resep</h5>
                                    
                                    <form method="post" action="../../layouts/resep.jsp">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%= resep.getId() %>">
                                        
                                        <div class="mb-3">
                                            <label for="menuId" class="form-label">Menu</label>
                                            <select class="form-select" id="menuId" name="menuId" required>
                                                <option value="">Pilih Menu</option>
                                                <% for (Menu menu : listMenu) { %>
                                                    <option value="<%= menu.getId() %>" 
                                                            <%= resep.getMenuId() != null && resep.getMenuId().equals(menu.getId()) ? "selected" : "" %>>
                                                        <%= menu.getNamaMenu() %>
                                                    </option>
                                                <% } %>
                                            </select>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="bahanBakuId" class="form-label">Bahan Baku</label>
                                            <select class="form-select" id="bahanBakuId" name="bahanBakuId" required>
                                                <option value="">Pilih Bahan Baku</option>
                                                <% for (BahanBaku bahan : listBahan) { %>
                                                    <option value="<%= bahan.getId() %>" 
                                                            <%= resep.getBahanBakuId() != null && resep.getBahanBakuId().equals(bahan.getId()) ? "selected" : "" %>>
                                                        <%= bahan.getNamaBahan() %> (<%= bahan.getSatuan() != null ? bahan.getSatuan() : "" %>)
                                                    </option>
                                                <% } %>
                                            </select>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="jumlah" class="form-label">Jumlah Dibutuhkan</label>
                                            <input type="number" class="form-control" id="jumlah" name="jumlah" value="<%= resep.getJumlahDibutuhkan() != null ? resep.getJumlahDibutuhkan() : "" %>" step="0.01" min="0.01" required>
                                        </div>
                                        
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-primary">
                                                <iconify-icon icon="mdi:content-save"></iconify-icon>
                                                Simpan Perubahan
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


