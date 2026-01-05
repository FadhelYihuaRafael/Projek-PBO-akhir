<%-- 
    Document   : Kategori Menu
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.KategoriMenu"%>
<%
    // ambil data dari request attribute
    List<KategoriMenu> listKategori = (List<KategoriMenu>) request.getAttribute("daftarKategori");
    String successMsg = (String) request.getAttribute("pesanSukses");
    String errorMsg = (String) request.getAttribute("pesanError");
    String username = (String) request.getAttribute("username");
    
    // kalau null, buat list kosong
    if (listKategori == null) {
        listKategori = new ArrayList<>();
    }
    
    // untuk URL
    String contextPath = request.getContextPath();
    String kategoriUrl = contextPath + "/layouts/kategori-menu.jsp";
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
                        <h5 class="card-title fw-semibold mb-0">Data Kategori Menu</h5>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalTambahKategori">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </button>
                    </div>
                    
                    <!-- tabel kategori menu -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Nama Kategori</th>
                                    <th>Deskripsi</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listKategori.isEmpty()) { %>
                                    <tr>
                                        <td colspan="4" class="text-center text-muted py-4">
                                            Belum ada data kategori menu. Silakan tambahkan kategori baru.
                                        </td>
                                    </tr>
                                <% } else { %>
                                    <% int no = 1; %>
                                    <% for (KategoriMenu kategori : listKategori) { %>
                                        <tr>
                                            <td class="text-center"><%= no %></td>
                                            <td><%= kategori.getNama() != null ? kategori.getNama() : "-" %></td>
                                            <td><%= kategori.getDeskripsi() != null ? (kategori.getDeskripsi().length() > 50 ? kategori.getDeskripsi().substring(0, 50) + "..." : kategori.getDeskripsi()) : "-" %></td>
                                            <td class="text-center">
                                                <a href="../pages/kategori-menu/edit.jsp?id=<%= kategori.getId() %>" class="btn btn-warning btn-sm">
                                                    <iconify-icon icon="mdi:pencil"></iconify-icon>
                                                    Edit
                                                </a>
                                                <a href="../pages/kategori-menu/delete.jsp?id=<%= kategori.getId() %>" class="btn btn-danger btn-sm">
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
                    
                </div>
            </div>
        </div>
    </div>
</div>

<!-- modal tambah kategori -->
<div class="modal fade" id="modalTambahKategori" tabindex="-1" aria-labelledby="modalTambahKategoriLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTambahKategoriLabel">Tambah Kategori Menu Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="<%= kategoriUrl %>" id="formTambahKategori">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="namaBaru" class="form-label">
                            Nama Kategori <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="namaBaru" name="nama" placeholder="Masukkan nama kategori" required maxlength="100">
                    </div>
                    <div class="mb-3">
                        <label for="deskripsiBaru" class="form-label">
                            Deskripsi
                        </label>
                        <textarea class="form-control" id="deskripsiBaru" name="deskripsi" rows="3" placeholder="Masukkan deskripsi kategori" maxlength="255"></textarea>
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
    document.getElementById('modalTambahKategori').addEventListener('hidden.bs.modal', function () {
        document.getElementById('formTambahKategori').reset();
    });
</script>
