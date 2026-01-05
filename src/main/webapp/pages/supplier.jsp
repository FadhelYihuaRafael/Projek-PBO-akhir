<%-- 
    Document   : supplier
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Supplier"%>
<%
    // ambil data dari request attribute yang sudah di-set di layout
    List<Supplier> listSupplier = (List<Supplier>) request.getAttribute("daftarSupplier");
    Supplier supplierEdit = (Supplier) request.getAttribute("supplierEdit");
    String successMessage = (String) request.getAttribute("pesanSukses");
    String errorMessage = (String) request.getAttribute("pesanError");
    String username = (String) request.getAttribute("username");
    
    // kalau null, buat list kosong
    if (listSupplier == null) {
        listSupplier = new ArrayList<>();
    }
    
    // untuk URL
    String contextPath = request.getContextPath();
    String supplierUrl = contextPath + "/layouts/supplier.jsp";
%>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    
                    <!-- alert sukses -->
                    <% if (successMessage != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <iconify-icon icon="mdi:check-circle"></iconify-icon>
                        <strong>Berhasil!</strong> <%= successMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% } %>
                    
                    <!-- alert error -->
                    <% if (errorMessage != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <iconify-icon icon="mdi:alert-circle"></iconify-icon>
                        <strong>Error!</strong> <%= errorMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% } %>
                    
                    <!-- form edit supplier -->
                    <% if (supplierEdit != null) { %>
                    <div class="mb-4">
                        <h5 class="card-title fw-semibold mb-4">Edit Supplier</h5>
                        
                        <form method="post" action="<%= supplierUrl %>">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<%= supplierEdit.getId() %>">
                            
                            <div class="mb-3">
                                <label for="namaEdit" class="form-label">Nama Supplier</label>
                                <input type="text" class="form-control" id="namaEdit" name="nama" value="<%= supplierEdit.getNama() != null ? supplierEdit.getNama() : "" %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="teleponEdit" class="form-label">Nomor Telepon</label>
                                <input type="text" class="form-control" id="teleponEdit" name="telepon" value="<%= supplierEdit.getTelepon() != null ? supplierEdit.getTelepon() : "" %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="alamatEdit" class="form-label">Alamat</label>
                                <textarea class="form-control" id="alamatEdit" name="alamat" rows="3" required><%= supplierEdit.getAlamat() != null ? supplierEdit.getAlamat() : "" %></textarea>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <iconify-icon icon="mdi:content-save"></iconify-icon>
                                    Simpan Perubahan
                                </button>
                                <a href="<%= supplierUrl %>" class="btn btn-secondary">
                                    <iconify-icon icon="mdi:cancel"></iconify-icon>
                                    Batal
                                </a>
                            </div>
                        </form>
                    </div>
                    <% } else { %>
                    
                    <!-- header tabel -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title fw-semibold mb-0">Data Supplier</h5>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalTambahSupplier">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </button>
                    </div>
                    
                    <!-- tabel supplier -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Nama</th>
                                    <th>Nomor Telepon</th>
                                    <th>Alamat</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listSupplier.isEmpty()) { %>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            Belum ada data supplier. Silakan tambahkan supplier baru.
                                        </td>
                                    </tr>
                                <% } else { %>
                                    <% int no = 1; %>
                                    <% for (Supplier supplier : listSupplier) { %>
                                        <tr>
                                            <td class="text-center"><%= no %></td>
                                            <td><%= supplier.getNama() != null ? supplier.getNama() : "-" %></td>
                                            <td><%= supplier.getTelepon() != null ? supplier.getTelepon() : "-" %></td>
                                            <td><%= supplier.getAlamat() != null ? supplier.getAlamat() : "-" %></td>
                                            <td class="text-center">
                                                <a href="<%= supplierUrl %>?action=edit&id=<%= supplier.getId() %>" class="btn btn-warning btn-sm">
                                                    <iconify-icon icon="mdi:pencil"></iconify-icon>
                                                    Edit
                                                </a>
                                                <a href="<%= supplierUrl %>?action=delete&id=<%= supplier.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Yakin ingin menghapus supplier ini?');">
                                                    <iconify-icon icon="mdi:delete"></iconify-icon>
                                                    Delete
                                                </a>
                                            </td>
                                        </tr>
                                        <% no++; %>
                                    <% } %>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } %>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<!-- modal tambah supplier -->
<div class="modal fade" id="modalTambahSupplier" tabindex="-1" aria-labelledby="modalTambahSupplierLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTambahSupplierLabel">Tambah Supplier Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="<%= supplierUrl %>" id="formTambahSupplier">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="namaBaru" class="form-label">
                            Nama Supplier <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="namaBaru" name="nama" placeholder="Masukkan nama supplier" required maxlength="100">
                    </div>
                    <div class="mb-3">
                        <label for="teleponBaru" class="form-label">
                            Nomor Telepon <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="teleponBaru" name="telepon" placeholder="Masukkan nomor telepon" required maxlength="20">
                    </div>
                    <div class="mb-3">
                        <label for="alamatBaru" class="form-label">
                            Alamat <span class="text-danger">*</span>
                        </label>
                        <textarea class="form-control" id="alamatBaru" name="alamat" rows="3" placeholder="Masukkan alamat supplier" required maxlength="255"></textarea>
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
    document.getElementById('modalTambahSupplier').addEventListener('hidden.bs.modal', function () {
        document.getElementById('formTambahSupplier').reset();
    });
</script>
