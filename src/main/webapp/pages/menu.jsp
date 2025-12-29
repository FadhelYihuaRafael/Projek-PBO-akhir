<%-- 
    Document   : Menu
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Ambil username dari request attribute (yang sudah diset di layouts/menu.jsp)
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
                        <h5 class="card-title fw-semibold mb-0">Data Menu</h5>
                        <a href="#" class="btn btn-primary">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </a>
                    </div>

                    <!-- Tabel Menu -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Nama Menu</th>
                                    <th>Kategori</th>
                                    <th>Harga Jual</th>
                                    <th>Deskripsi</th>
                                    <th>Created By</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center">1</td>
                                    <td>Nasi Goreng Spesial</td>
                                    <td>Makanan Utama</td>
                                    <td class="text-end">Rp 25.000</td>
                                    <td>Nasi goreng dengan telur, ayam, dan kerupuk</td>
                                    <td><%= username %></td>
                                    <td class="text-center">
                                        <a href="../pages/menu/edit.jsp" class="btn btn-warning btn-sm">
                                            <iconify-icon icon="mdi:pencil"></iconify-icon>
                                            Edit
                                        </a>
                                        <a href="../pages/menu/delete.jsp" class="btn btn-danger btn-sm">
                                            <iconify-icon icon="mdi:delete"></iconify-icon>
                                            Delete
                                        </a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">2</td>
                                    <td>Es Jeruk</td>
                                    <td>Minuman</td>
                                    <td class="text-end">Rp 8.000</td>
                                    <td>Minuman segar jeruk peras</td>
                                    <td>Admin</td>
                                    <td class="text-center">
                                        <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                        <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">3</td>
                                    <td>Pudding Coklat</td>
                                    <td>Dessert</td>
                                    <td class="text-end">Rp 12.000</td>
                                    <td>Pudding coklat dengan topping krim</td>
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

