<%-- 
    Document   : Bahan Baku
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Ambil username dari request attribute (yang sudah diset di layouts/bahan-baku.jsp)
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
                        <h5 class="card-title fw-semibold mb-0">Data Bahan Baku</h5>
                        <a href="#" class="btn btn-primary">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </a>
                    </div>

                    <!-- Tabel Bahan Baku -->
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
                                    <th>Created By</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center">1</td>
                                    <td>Beras Premium</td>
                                    <td>PT Sumber Makmur</td>
                                    <td class="text-center">kg</td>
                                    <td class="text-end">Rp 15.000</td>
                                    <td class="text-center">50</td>
                                    <td><%= username %></td>
                                    <td class="text-center">
                                        <a href="../pages/bahan-baku/edit.jsp" class="btn btn-warning btn-sm">
                                            <iconify-icon icon="mdi:pencil"></iconify-icon>
                                            Edit
                                        </a>
                                        <a href="../pages/bahan-baku/delete.jsp" class="btn btn-danger btn-sm">
                                            <iconify-icon icon="mdi:delete"></iconify-icon>
                                            Delete
                                        </a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">2</td>
                                    <td>Minyak Goreng</td>
                                    <td>CV Jaya Abadi</td>
                                    <td class="text-center">liter</td>
                                    <td class="text-end">Rp 25.000</td>
                                    <td class="text-center">30</td>
                                    <td>Admin</td>
                                    <td class="text-center">
                                        <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                        <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">3</td>
                                    <td>Gula Pasir</td>
                                    <td>UD Maju Bersama</td>
                                    <td class="text-center">kg</td>
                                    <td class="text-end">Rp 18.000</td>
                                    <td class="text-center">40</td>
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

