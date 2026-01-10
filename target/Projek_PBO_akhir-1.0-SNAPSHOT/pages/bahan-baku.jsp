<%-- 
    Document   : Bahan Baku
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.BahanBaku"%>
<%@page import="model.Supplier"%>
<%
    // ambil data dari request attribute
    List<BahanBaku> listBahan = (List<BahanBaku>) request.getAttribute("daftarBahan");
    List<Supplier> listSupplier = (List<Supplier>) request.getAttribute("daftarSupplier");
    String successMsg = (String) request.getAttribute("pesanSukses");
    String errorMsg = (String) request.getAttribute("pesanError");
    String username = (String) request.getAttribute("username");
    
    // kalau null, buat list kosong
    if (listBahan == null) {
        listBahan = new ArrayList<>();
    }
    if (listSupplier == null) {
        listSupplier = new ArrayList<>();
    }
    
    // untuk URL
    String contextPath = request.getContextPath();
    String bahanUrl = contextPath + "/BahanBakuController";
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
                        <h5 class="card-title fw-semibold mb-0">Data Bahan Baku</h5>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalTambahBahan">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </button>
                    </div>
                    
                    <!-- tabel bahan baku -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Nama Bahan</th>
                                    <th>Supplier</th>
                                    <th>Satuan</th>
                                    <th>Harga per Satuan</th>
                                    <th>Stok</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listBahan.isEmpty()) { %>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            Belum ada data bahan baku. Silakan tambahkan bahan baku baru.
                                        </td>
                                    </tr>
                                <% } else { %>
                                    <% int no = 1; %>
                                    <% for (BahanBaku bahan : listBahan) { %>
                                        <tr>
                                            <td class="text-center"><%= no %></td>
                                            <td><%= bahan.getNamaBahan() != null ? bahan.getNamaBahan() : "-" %></td>
                                            <td>
                                                <% 
                                                    String supplierNama = "-";
                                                    if (bahan.getSupplierId() != null) {
                                                        for (Supplier supplier : listSupplier) {
                                                            if (supplier.getId().equals(bahan.getSupplierId())) {
                                                                supplierNama = supplier.getNama();
                                                                break;
                                                            }
                                                        }
                                                    }
                                                %>
                                                <%= supplierNama %>
                                            </td>
                                            <td class="text-center"><%= bahan.getSatuan() != null ? bahan.getSatuan() : "-" %></td>
                                            <td class="text-end">
                                                <%= bahan.getHargaPerSatuan() != null ? "Rp " + String.format("%,.0f", bahan.getHargaPerSatuan()) : "-" %>
                                            </td>
                                            <td class="text-center"><%= bahan.getStok() != null ? bahan.getStok() : "-" %></td>
                                            <td class="text-center">
                                                <a href="<%= contextPath %>/pages/bahan-baku/edit.jsp?id=<%= bahan.getId() %>" class="btn btn-warning btn-sm">
                                                    <iconify-icon icon="mdi:pencil"></iconify-icon>
                                                    Edit
                                                </a>
                                                <a href="<%= contextPath %>/pages/bahan-baku/delete.jsp?id=<%= bahan.getId() %>" class="btn btn-danger btn-sm">
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

<!-- modal tambah bahan baku -->
<div class="modal fade" id="modalTambahBahan" tabindex="-1" aria-labelledby="modalTambahBahanLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTambahBahanLabel">Tambah Bahan Baku Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="<%= contextPath %>/BahanBakuController" id="formTambahBahan">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="supplierIdBaru" class="form-label">
                            Supplier <span class="text-danger">*</span>
                        </label>
                        <select class="form-select" id="supplierIdBaru" name="supplierId" required>
                            <option value="">Pilih Supplier</option>
                            <% for (Supplier supplier : listSupplier) { %>
                                <option value="<%= supplier.getId() %>"><%= supplier.getNama() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="namaBahanBaru" class="form-label">
                            Nama Bahan <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="namaBahanBaru" name="namaBahan" placeholder="Masukkan nama bahan" required maxlength="100">
                    </div>
                    <div class="mb-3">
                        <label for="satuanBaru" class="form-label">
                            Satuan <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="satuanBaru" name="satuan" placeholder="kg, liter, dll" required maxlength="20">
                    </div>
                    <div class="mb-3">
                        <label for="hargaBaru" class="form-label">
                            Harga per Satuan <span class="text-danger">*</span>
                        </label>
                        <input type="number" class="form-control" id="hargaBaru" name="harga" placeholder="Masukkan harga" step="0.01" min="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="stokBaru" class="form-label">
                            Stok <span class="text-danger">*</span>
                        </label>
                        <input type="number" class="form-control" id="stokBaru" name="stok" placeholder="Masukkan stok" min="0" required>
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
    document.getElementById('modalTambahBahan').addEventListener('hidden.bs.modal', function () {
        document.getElementById('formTambahBahan').reset();
    });
</script>
