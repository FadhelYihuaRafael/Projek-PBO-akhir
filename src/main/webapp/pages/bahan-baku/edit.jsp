<%-- 
    Document   : Edit Bahan Baku
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.BahanBakuDAO"%>
<%@page import="dao.SupplierDAO"%>
<%@page import="model.BahanBaku"%>
<%@page import="model.Supplier"%>
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
    BahanBaku bahan = null;
    String errorMsg = null;
    
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        BahanBakuDAO bahanDAO = new BahanBakuDAO();
        bahan = bahanDAO.ambilBahanBakuById(id);
        
        if (bahan == null) {
            errorMsg = "Bahan baku tidak ditemukan!";
        }
    } catch (Exception e) {
        errorMsg = "Error: " + e.getMessage();
        e.printStackTrace();
    }
    
    // ambil semua supplier untuk dropdown
    List<Supplier> listSupplier = new ArrayList<>();
    try {
        SupplierDAO supplierDAO = new SupplierDAO();
        listSupplier = supplierDAO.ambilSemuaSupplier();
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
    <title>Edit Bahan Baku | SeoDash</title>
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
                                <% if (errorMsg != null || bahan == null) { %>
                                    <div class="alert alert-danger">
                                        <strong>Error!</strong> <%= errorMsg != null ? errorMsg : "Bahan baku tidak ditemukan!" %>
                                    </div>
                                    <a href="../../layouts/bahan-baku.jsp" class="btn btn-secondary">Kembali</a>
                                <% } else { %>
                                    <h5 class="card-title fw-semibold mb-4">Edit Bahan Baku</h5>
                                    
                                    <form method="post" action="../../layouts/bahan-baku.jsp">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%= bahan.getId() %>">
                                        
                                        <div class="mb-3">
                                            <label for="supplierId" class="form-label">Supplier</label>
                                            <select class="form-select" id="supplierId" name="supplierId" required>
                                                <option value="">Pilih Supplier</option>
                                                <% for (Supplier supplier : listSupplier) { %>
                                                    <option value="<%= supplier.getId() %>" 
                                                            <%= bahan.getSupplierId() != null && bahan.getSupplierId().equals(supplier.getId()) ? "selected" : "" %>>
                                                        <%= supplier.getNama() %>
                                                    </option>
                                                <% } %>
                                            </select>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="namaBahan" class="form-label">Nama Bahan</label>
                                            <input type="text" class="form-control" id="namaBahan" name="namaBahan" value="<%= bahan.getNamaBahan() != null ? bahan.getNamaBahan() : "" %>" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="satuan" class="form-label">Satuan</label>
                                            <input type="text" class="form-control" id="satuan" name="satuan" value="<%= bahan.getSatuan() != null ? bahan.getSatuan() : "" %>" placeholder="kg, liter, dll" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="harga" class="form-label">Harga per Satuan</label>
                                            <input type="number" class="form-control" id="harga" name="harga" value="<%= bahan.getHargaPerSatuan() != null ? bahan.getHargaPerSatuan() : "" %>" step="0.01" min="0.01" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="stok" class="form-label">Stok</label>
                                            <input type="number" class="form-control" id="stok" name="stok" value="<%= bahan.getStok() != null ? bahan.getStok() : "" %>" min="0" required>
                                        </div>
                                        
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-primary">
                                                <iconify-icon icon="mdi:content-save"></iconify-icon>
                                                Simpan Perubahan
                                            </button>
                                            <a href="../../layouts/bahan-baku.jsp" class="btn btn-secondary">
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

