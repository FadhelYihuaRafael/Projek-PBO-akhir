<%-- 
    Document   : Resep
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Resep"%>
<%@page import="model.Menu"%>
<%@page import="model.BahanBaku"%>
<%
    // ambil data dari request attribute
    List<Resep> listResep = (List<Resep>) request.getAttribute("daftarResep");
    List<Menu> listMenu = (List<Menu>) request.getAttribute("daftarMenu");
    List<BahanBaku> listBahan = (List<BahanBaku>) request.getAttribute("daftarBahan");
    String successMsg = (String) request.getAttribute("pesanSukses");
    String errorMsg = (String) request.getAttribute("pesanError");
    String username = (String) request.getAttribute("username");
    String role = (String) request.getAttribute("role");
    
    // kalau null, buat list kosong
    if (listResep == null) {
        listResep = new ArrayList<>();
    }
    if (listMenu == null) {
        listMenu = new ArrayList<>();
    }
    if (listBahan == null) {
        listBahan = new ArrayList<>();
    }
    
    // untuk URL
    String contextPath = request.getContextPath();
    String resepUrl = contextPath + "/ResepController";
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    
                    <!-- alert sukses -->
                    <% if (successMsg != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <iconify-icon icon="mdi:check-circle"></iconify-icon>
                        <strong>Berhasil!</strong> <%= successMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% } %>
                    
                    <!-- alert error -->
                    <% if (errorMsg != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                        <strong>Error!</strong> <%= errorMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% } %>
                    
                    
                    <!-- header -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title fw-semibold mb-0">Data Resep</h5>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalTambahResep">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </button>
                    </div>
                    
                    <!-- tabel resep -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Menu</th>
                                    <th>Bahan Baku</th>
                                    <th>Jumlah Dibutuhkan</th>
                                    <th>Produk yang Dihasilkan</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listResep.isEmpty()) { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            Belum ada data resep. Silakan tambahkan resep baru.
                                        </td>
                                    </tr>
                                <% } else { %>
                                    <% int no = 1; %>
                                    <% for (Resep resep : listResep) { %>
                                        <tr>
                                            <td class="text-center"><%= no %></td>
                                            <td>
                                                <% 
                                                    String menuNama = "-";
                                                    if (resep.getMenuId() != null) {
                                                        for (Menu menu : listMenu) {
                                                            if (menu.getId().equals(resep.getMenuId())) {
                                                                menuNama = menu.getNamaMenu();
                                                                break;
                                                            }
                                                        }
                                                    }
                                                %>
                                                <%= menuNama %>
                                            </td>
                                            <td>
                                                <% 
                                                    String bahanNama = "-";
                                                    String satuan = "";
                                                    if (resep.getBahanBakuId() != null) {
                                                        for (BahanBaku bahan : listBahan) {
                                                            if (bahan.getId().equals(resep.getBahanBakuId())) {
                                                                bahanNama = bahan.getNamaBahan();
                                                                satuan = bahan.getSatuan() != null ? bahan.getSatuan() : "";
                                                                break;
                                                            }
                                                        }
                                                    }
                                                %>
                                                <%= bahanNama %>
                                            </td>
                                            <td class="text-center">
                                                <%= resep.getJumlahDibutuhkan() != null ? String.format("%.2f", resep.getJumlahDibutuhkan()) + " " + satuan : "-" %>
                                            </td>
                                            <td class="text-center">
                                                <%= resep.getProdukYangDihasilkan() != null ? String.format("%.2f", resep.getProdukYangDihasilkan()) : "-" %>
                                            </td>
                                            <td class="text-center">
                                                <a href="<%= contextPath %>/pages/resep/edit.jsp?id=<%= resep.getId() %>" class="btn btn-warning btn-sm">
                                                    <iconify-icon icon="mdi:pencil"></iconify-icon>
                                                    Edit
                                                </a>
                                                <% if (role != null && role.equals("admin")) { %>
                                                <a href="<%= contextPath %>/pages/resep/delete.jsp?id=<%= resep.getId() %>" class="btn btn-danger btn-sm">
                                                    <iconify-icon icon="mdi:delete"></iconify-icon>
                                                    Delete
                                                </a>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <% no++; %>
                                    <% } %>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<!-- modal tambah resep -->
<div class="modal fade" id="modalTambahResep" tabindex="-1" aria-labelledby="modalTambahResepLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTambahResepLabel">Tambah Resep Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="<%= resepUrl %>" id="formTambahResep">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="menuIdBaru" class="form-label">
                            Menu <span class="text-danger">*</span>
                        </label>
                        <select class="form-select" id="menuIdBaru" name="menuId" required>
                            <option value="">Pilih Menu</option>
                            <% for (Menu menu : listMenu) { %>
                                <option value="<%= menu.getId() %>"><%= menu.getNamaMenu() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="bahanBakuIdBaru" class="form-label">
                            Bahan Baku <span class="text-danger">*</span>
                        </label>
                        <select class="form-select" id="bahanBakuIdBaru" name="bahanBakuId" required>
                            <option value="">Pilih Bahan Baku</option>
                            <% for (BahanBaku bahan : listBahan) { %>
                                <option value="<%= bahan.getId() %>" data-satuan="<%= bahan.getSatuan() != null ? bahan.getSatuan() : "" %>">
                                    <%= bahan.getNamaBahan() %> (<%= bahan.getSatuan() != null ? bahan.getSatuan() : "" %>)
                                </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="jumlahBaru" class="form-label">
                            Jumlah Dibutuhkan <span class="text-danger">*</span>
                        </label>
                        <input type="number" class="form-control" id="jumlahBaru" name="jumlah" placeholder="Masukkan jumlah" step="0.01" min="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="produkYangDihasilkanBaru" class="form-label">
                            Produk yang Dihasilkan <span class="text-danger">*</span>
                        </label>
                        <input type="number" class="form-control" id="produkYangDihasilkanBaru" name="produkYangDihasilkan" placeholder="Masukkan jumlah produk yang dihasilkan" step="0.01" min="0.01" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        Batal
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <iconify-icon icon="mdi:content-save"></iconify-icon>
                        Simpan
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- script reset form modal -->
<script>
    document.getElementById('modalTambahResep').addEventListener('hidden.bs.modal', function () {
        document.getElementById('formTambahResep').reset();
    });
</script>
