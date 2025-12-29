<%-- 
    Document   : Resep
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Ambil username dari request attribute (yang sudah diset di layouts/resep.jsp)
    // atau langsung dari session sebagai fallback
    String username = (String) request.getAttribute("username");
    if (username == null) {
        username = (String) session.getAttribute("username");
    }
    if (username == null) {
        username = "Guest";
    }
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm">
                <div class="card-body">

                    <!-- Judul & Tombol Tambahkan -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title fw-semibold mb-0">Data Resep</h5>
                        <a href="#" class="btn btn-primary">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </a>
                    </div>

                    <!-- Tabel Resep -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Menu</th>
                                    <th>Bahan Baku</th>
                                    <th>Jumlah Dibutuhkan</th>
                                    <th>Created By</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center">1</td>
                                    <td>Nasi Goreng Spesial</td>
                                    <td>Beras Premium</td>
                                    <td class="text-center">0.2 kg</td>
                                    <td><%= username %></td>
                                    <td class="text-center">
                                        <a href="../pages/resep/edit.jsp" class="btn btn-warning btn-sm">
                                            <iconify-icon icon="mdi:pencil"></iconify-icon>
                                            Edit
                                        </a>
                                        <a href="../pages/resep/delete.jsp" class="btn btn-danger btn-sm">
                                            <iconify-icon icon="mdi:delete"></iconify-icon>
                                            Delete
                                        </a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">2</td>
                                    <td>Nasi Goreng Spesial</td>
                                    <td>Minyak Goreng</td>
                                    <td class="text-center">0.05 liter</td>
                                    <td>Admin</td>
                                    <td class="text-center">
                                        <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                        <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">3</td>
                                    <td>Es Jeruk</td>
                                    <td>Gula Pasir</td>
                                    <td class="text-center">0.01 kg</td>
                                    <td>Admin</td>
                                    <td class="text-center">
                                        <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                        <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

