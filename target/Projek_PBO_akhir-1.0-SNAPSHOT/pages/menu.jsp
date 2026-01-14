<%-- 
    Document   : Menu
    Created on : 17 Dec 2025
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Menu"%>
<%@page import="model.KategoriMenu"%>
<%@page import="model.Resep"%>
<%@page import="model.BahanBaku"%>
<%@page import="dao.ResepDAO"%>
<%@page import="dao.BahanBakuDAO"%>
<%
    List<Menu> listMenu = (List<Menu>) request.getAttribute("daftarMenu");
    List<KategoriMenu> listKategori = (List<KategoriMenu>) request.getAttribute("daftarKategori");
    List<Resep> listResep = (List<Resep>) request.getAttribute("daftarResep");
    String successMessage = (String) request.getAttribute("pesanSukses");
    String errorMessage = (String) request.getAttribute("pesanError");
    String role = (String) request.getAttribute("role");
    
    if (listMenu == null) listMenu = new ArrayList<>();
    if (listKategori == null) listKategori = new ArrayList<>();
    if (listResep == null) listResep = new ArrayList<>();
    
    BahanBakuDAO bahanDAO = new BahanBakuDAO();
    List<BahanBaku> listBahan = bahanDAO.getAll();
    if (listBahan == null) listBahan = new ArrayList<>();
    
    String contextPath = request.getContextPath();
    String menuUrl = contextPath + "/MenuController";
    ResepDAO resepDAO = new ResepDAO();
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
                    
                    
                    <!-- header -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title fw-semibold mb-0">Data Menu</h5>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalTambahMenu">
                            <iconify-icon icon="mdi:plus"></iconify-icon>
                            Tambahkan
                        </button>
                    </div>
                    
                    <!-- tabel menu -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light text-center">
                                <tr>
                                    <th>No</th>
                                    <th>Nama Menu</th>
                                    <th>Kategori</th>
                                    <th>HPP</th>
                                    <th>Harga Jual</th>
                                    <th>Margin</th>
                                    <th>Deskripsi</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listMenu.isEmpty()) { %>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">
                                            Belum ada data menu. Silakan tambahkan menu baru.
                                        </td>
                                    </tr>
                                <% } else { %>
                                    <% int no = 1; %>
                                    <% for (Menu menu : listMenu) { %>
                                        <% 
                                            Float hpp = 0.0f;
                                            if (menu.getId() != null) {
                                                hpp = resepDAO.hitungHPPByMenuId(menu.getId());
                                            }
                                            
                                            Integer hargaJual = menu.getHargaJual();
                                            Float margin = 0.0f;
                                            Float marginPersen = menu.getMarginPersen() != null ? menu.getMarginPersen() : 0.0f;
                                            if (hargaJual != null && hpp != null && hpp > 0) {
                                                margin = hargaJual.floatValue() - hpp;
                                                // Gunakan margin persen dari database jika ada, jika tidak hitung dari margin
                                                if (marginPersen == 0.0f && hpp > 0) {
                                                    marginPersen = (margin / hpp) * 100;
                                                }
                                            }
                                            
                                            String kategoriNama = "-";
                                            if (menu.getKategoriId() != null) {
                                                for (KategoriMenu kategori : listKategori) {
                                                    if (kategori.getId().equals(menu.getKategoriId())) {
                                                        kategoriNama = kategori.getNama();
                                                        break;
                                                    }
                                                }
                                            }
                                        %>
                                        <tr>
                                            <td class="text-center"><%= no %></td>
                                            <td><%= menu.getNamaMenu() != null ? menu.getNamaMenu() : "-" %></td>
                                            <td><%= kategoriNama %></td>
                                            <td class="text-end">
                                                <% if (hpp > 0) { %>
                                                    <strong>Rp <%= String.format("%,d", Math.round(hpp)) %></strong>
                                                    <br><small class="text-muted">per porsi</small>
                                                <% } else { %>
                                                    <span class="text-muted">Belum ada resep</span>
                                                <% } %>
                                            </td>
                                            <td class="text-end">
                                                <% if (hargaJual != null && hargaJual > 0) { %>
                                                    <strong>Rp <%= String.format("%,d", hargaJual) %></strong>
                                                    <br><small class="text-muted">per porsi</small>
                                                <% } else { %>
                                                    <span class="text-muted">-</span>
                                                <% } %>
                                            </td>
                                            <td class="text-end">
                                                <% if (marginPersen != null && marginPersen > 0) { %>
                                                    <span class="text-success"><%= String.format("%.1f", marginPersen) %>%</span>
                                                    <% if (hargaJual != null && hpp > 0) { %>
                                                        <br><small class="text-muted">Rp <%= String.format("%,.0f", margin) %></small>
                                                    <% } %>
                                                <% } else if (hargaJual != null && hpp > 0) { %>
                                                    <% if (margin >= 0) { %>
                                                        <span class="text-success">Rp <%= String.format("%,.0f", margin) %></span>
                                                        <br><small class="text-muted">(<%= String.format("%.1f", marginPersen) %>%)</small>
                                                    <% } else { %>
                                                        <span class="text-danger">Rp <%= String.format("%,.0f", margin) %></span>
                                                        <br><small class="text-muted">(<%= String.format("%.1f", marginPersen) %>%)</small>
                                                    <% } %>
                                                <% } else { %>
                                                    <span class="text-muted">-</span>
                                                <% } %>
                                            </td>
                                            <td><%= menu.getDeskripsi() != null ? (menu.getDeskripsi().length() > 50 ? menu.getDeskripsi().substring(0, 50) + "..." : menu.getDeskripsi()) : "-" %></td>
                                            <td class="text-center">
                                                <a href="<%= contextPath %>/pages/menu/edit.jsp?id=<%= menu.getId() %>" class="btn btn-warning btn-sm">
                                                    <iconify-icon icon="mdi:pencil"></iconify-icon>
                                                    Edit
                                                </a>
                                                <% if (role != null && role.equals("admin")) { %>
                                                <a href="<%= contextPath %>/pages/menu/delete.jsp?id=<%= menu.getId() %>" class="btn btn-danger btn-sm">
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

<!-- modal tambah menu -->
<div class="modal fade" id="modalTambahMenu" tabindex="-1" aria-labelledby="modalTambahMenuLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTambahMenuLabel">Tambah Menu Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form method="post" action="<%= menuUrl %>" id="formTambahMenu">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="kategoriIdBaru" class="form-label">
                            Kategori <span class="text-danger">*</span>
                        </label>
                        <select class="form-select" id="kategoriIdBaru" name="kategoriId" required>
                            <option value="">Pilih Kategori</option>
                            <% for (KategoriMenu kategori : listKategori) { %>
                                <option value="<%= kategori.getId() %>"><%= kategori.getNama() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="namaMenuBaru" class="form-label">
                            Nama Menu <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="namaMenuBaru" name="namaMenu" placeholder="Masukkan nama menu" required maxlength="100">
                    </div>
                    <div class="mb-3">
                        <label for="marginPersenBaru" class="form-label">
                            Margin (%) <span class="text-danger">*</span>
                        </label>
                        <input type="number" class="form-control" id="marginPersenBaru" name="marginPersen" 
                               placeholder="Masukkan margin dalam persen (contoh: 50 untuk 50%)" 
                               step="0.01" min="0" required>
                        <small class="form-text text-muted">Harga jual akan dihitung otomatis setelah resep dibuat: HPP + (HPP × Margin%)</small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Harga Jual (Otomatis)</label>
                        <input type="text" class="form-control" id="hargaJualPreview" readonly 
                               placeholder="Akan dihitung setelah resep dibuat" value="-">
                        <small class="form-text text-muted">Harga jual akan terisi otomatis setelah resep dibuat dan HPP dihitung</small>
                    </div>
                    <div class="mb-3">
                        <label for="deskripsiBaru" class="form-label">
                            Deskripsi
                        </label>
                        <textarea class="form-control" id="deskripsiBaru" name="deskripsi" rows="3" placeholder="Masukkan deskripsi menu" maxlength="255"></textarea>
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
    document.getElementById('modalTambahMenu').addEventListener('hidden.bs.modal', function () {
        document.getElementById('formTambahMenu').reset();
    });
</script>
