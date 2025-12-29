<%-- 
    Document   : Kategori Menu
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Ambil username dari request attribute (yang sudah diset di layouts/kategori-menu.jsp)
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
                        <h5 class="card-title fw-semibold mb-0">Data Kategori Menu</h5>
                        <a href="#" class="btn btn-primary">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </a>
                    </div>

                    <!-- Tabel Kategori Menu -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Nama Kategori</th>
                                    <th>Deskripsi</th>
                                    <th>Created By</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center">1</td>
                                    <td>Makanan Utama</td>
                                    <td>Menu makanan utama yang mengenyangkan</td>
                                    <td><%= username %></td>
                                    <td class="text-center">
                                        <a href="../pages/kategori-menu/edit.jsp" class="btn btn-warning btn-sm">
                                            <iconify-icon icon="mdi:pencil"></iconify-icon>
                                            Edit
                                        </a>
                                        <a href="../pages/kategori-menu/delete.jsp" class="btn btn-danger btn-sm">
                                            <iconify-icon icon="mdi:delete"></iconify-icon>
                                            Delete
                                        </a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">2</td>
                                    <td>Minuman</td>
                                    <td>Berbagai jenis minuman segar</td>
                                    <td>Admin</td>
                                    <td class="text-center">
                                        <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                        <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">3</td>
                                    <td>Dessert</td>
                                    <td>Hidangan penutup yang manis</td>
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

