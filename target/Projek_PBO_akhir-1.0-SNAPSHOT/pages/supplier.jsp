<%-- 
    Document   : pages
    Created on : 15 Dec 2025, 12.35.57
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Ambil username dari request attribute (yang sudah diset di layouts/supplier.jsp)
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
                        <h5 class="card-title fw-semibold mb-0">Data Supplier</h5>
                        <a href="#" class="btn btn-primary">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </a>
                    </div>

                    <!-- Tabel Supplier -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Nama</th>
                                    <th>Nomor Telepon</th>
                                    <th>Alamat</th>
                                    <th>Created By</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center">1</td>
                                    <td>PT Sumber Makmur</td>
                                    <td>081234567890</td>
                                    <td>Jakarta Selatan</td>
                                    <td>
                                        <%= username %>
                                    </td>
                                    <td class="text-center">
                                        <a href="../pages/supplier/edit.jsp" class="btn btn-warning btn-sm">
                                            <iconify-icon
                                                icon="mdi:pencil"></iconify-icon>
                                            Edit
                                        </a>
                                        <a href="../pages/supplier/delete.jsp" class="btn btn-danger btn-sm">
                                            <iconify-icon
                                                icon="mdi:delete"></iconify-icon>
                                            Delete
                                        </a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">2</td>
                                    <td>CV Jaya Abadi</td>
                                    <td>082233445566</td>
                                    <td>Depok</td>
                                    <td>Admin</td>
                                    <td class="text-center">
                                        <a href="#"
                                            class="btn btn-warning btn-sm">Edit</a>
                                        <a href="#"
                                            class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center">3</td>
                                    <td>UD Maju Bersama</td>
                                    <td>083344556677</td>
                                    <td>Bogor</td>
                                    <td>Admin</td>
                                    <td class="text-center">
                                        <a href="#"
                                            class="btn btn-warning btn-sm">Edit</a>
                                        <a href="#"
                                            class="btn btn-danger btn-sm">Delete</a>
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
