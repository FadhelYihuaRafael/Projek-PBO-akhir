package controller;

import dao.MenuDAO;
import dao.KategoriMenuDAO;
import dao.ResepDAO;
import model.Menu;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class MenuController extends HttpServlet {
    
    private MenuDAO menuDAO;
    private KategoriMenuDAO kategoriDAO;
    private ResepDAO resepDAO;
    
    public MenuController() {
        menuDAO = new MenuDAO();
        kategoriDAO = new KategoriMenuDAO();
        resepDAO = new ResepDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String contextPath = request.getContextPath();
        
        // Cek session
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            // Handle edit - ambil data menu untuk ditampilkan di form
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    model.Menu menuEdit = menuDAO.ambilMenuById(id);
                    if (menuEdit != null) {
                        request.setAttribute("menuEdit", menuEdit);
                    } else {
                        session.setAttribute("errorMsg", "Menu tidak ditemukan!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "ID tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
            // Lanjutkan ke tampilan list dengan form edit
        } else if ("delete".equals(action)) {
            // Handle delete
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    
                    // Cek apakah ada resep yang menggunakan menu ini
                    List<model.Resep> listResepMenu = resepDAO.ambilResepByMenuId(id);
                    if (listResepMenu != null && !listResepMenu.isEmpty()) {
                        // Hapus semua resep yang terkait dengan menu ini terlebih dahulu
                        for (model.Resep resep : listResepMenu) {
                            resepDAO.delete(resep.getId());
                        }
                    }
                    
                    // Setelah resep dihapus, baru hapus menu
                    boolean deleteOk = menuDAO.delete(id);
                    
                    if (deleteOk) {
                        if (listResepMenu != null && !listResepMenu.isEmpty()) {
                            session.setAttribute("successMsg", "Menu dan " + listResepMenu.size() + " resep terkait berhasil dihapus!");
                        } else {
                            session.setAttribute("successMsg", "Menu berhasil dihapus!");
                        }
                    } else {
                        session.setAttribute("errorMsg", "Gagal menghapus menu!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "ID tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            response.sendRedirect(contextPath + "/MenuController");
            return;
        }
        
        // Default: tampilkan list menu
        request.setAttribute("daftarMenu", menuDAO.getAll());
        request.setAttribute("daftarKategori", kategoriDAO.getAll());
        request.setAttribute("daftarResep", resepDAO.getAll());
        
        // Ambil pesan dari session jika ada
        String successMsg = (String) session.getAttribute("successMsg");
        String errorMsg = (String) session.getAttribute("errorMsg");
        if (successMsg != null) {
            request.setAttribute("pesanSukses", successMsg);
            session.removeAttribute("successMsg");
        }
        if (errorMsg != null) {
            request.setAttribute("pesanError", errorMsg);
            session.removeAttribute("errorMsg");
        }
        
        // Set username dan role untuk JSP
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        request.setAttribute("username", username);
        request.setAttribute("role", role);
        
        request.getRequestDispatcher("/layouts/menu.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String contextPath = request.getContextPath();
        
        // Cek session
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        String namaMenu = request.getParameter("namaMenu");
        String marginPersenStr = request.getParameter("marginPersen");
        String hargaJualStr = request.getParameter("hargaJual");
        String deskripsi = request.getParameter("deskripsi");
        String kategoriIdStr = request.getParameter("kategoriId");
        
        if ("update".equals(action)) {
            // Update menu
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "ID menu tidak ditemukan!");
                response.sendRedirect(contextPath + "/MenuController");
                return;
            }
            
            try {
                int id = Integer.parseInt(idStr);
                int kategoriId = Integer.parseInt(kategoriIdStr);
                float marginPersen = marginPersenStr != null && !marginPersenStr.trim().isEmpty() 
                    ? Float.parseFloat(marginPersenStr) : 0.0f;
                
                if (namaMenu == null || namaMenu.trim().isEmpty()) {
                    session.setAttribute("errorMsg", "Nama menu tidak boleh kosong!");
                    response.sendRedirect(contextPath + "/MenuController");
                    return;
                }
                
                if (marginPersen < 0) {
                    session.setAttribute("errorMsg", "Margin tidak boleh negatif!");
                    response.sendRedirect(contextPath + "/MenuController");
                    return;
                }
                
                // Hitung HPP dari resep yang ada
                Float hpp = resepDAO.hitungHPPByMenuId(id);
                int hargaJual = 0;
                
                if (hpp != null && hpp > 0) {
                    // Hitung harga jual = HPP + (HPP × margin%)
                    hargaJual = Math.round(hpp + (hpp * marginPersen / 100));
                }
                // Jika belum ada resep, harga jual = 0 (akan dihitung setelah resep dibuat)
                
                Menu menuUpdate = new Menu();
                menuUpdate.setId(id);
                menuUpdate.setKategoriId(kategoriId);
                menuUpdate.setNamaMenu(namaMenu.trim());
                menuUpdate.setHargaJual(hargaJual);
                menuUpdate.setMarginPersen(marginPersen);
                menuUpdate.setDeskripsi(deskripsi != null ? deskripsi.trim() : "");
                
                boolean updateOk = menuDAO.update(menuUpdate);
                
                if (updateOk) {
                    if (hpp != null && hpp > 0) {
                        session.setAttribute("successMsg", "Menu berhasil diupdate! Harga jual: Rp " + String.format("%,d", hargaJual));
                    } else {
                        session.setAttribute("successMsg", "Menu berhasil diupdate! Harga jual akan dihitung setelah resep dibuat.");
                    }
                } else {
                    session.setAttribute("errorMsg", "Gagal mengupdate menu!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Error: Data tidak valid!");
            } catch (Exception e) {
                session.setAttribute("errorMsg", "Error: " + e.getMessage());
            }
            
        } else {
            // Insert menu baru
            if (namaMenu == null || namaMenu.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Nama menu tidak boleh kosong!");
            } else if (marginPersenStr == null || marginPersenStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Margin tidak boleh kosong!");
            } else if (kategoriIdStr == null || kategoriIdStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Kategori harus dipilih!");
            } else if (userId == null) {
                session.setAttribute("errorMsg", "Session expired! Silakan login kembali.");
            } else {
                try {
                    int kategoriId = Integer.parseInt(kategoriIdStr);
                    float marginPersen = Float.parseFloat(marginPersenStr);
                    
                    if (marginPersen < 0) {
                        session.setAttribute("errorMsg", "Margin tidak boleh negatif!");
                    } else {
                        // Saat insert menu baru, harga jual = 0 (akan dihitung setelah resep dibuat)
                        Menu menuBaru = new Menu(
                            kategoriId,
                            namaMenu.trim(),
                            0, // harga jual = 0, akan dihitung setelah resep dibuat
                            marginPersen,
                            deskripsi != null ? deskripsi.trim() : "",
                            userId
                        );
                        
                        try {
                            boolean tambahOk = menuDAO.insert(menuBaru);
                            
                            if (tambahOk) {
                                session.setAttribute("successMsg", "Menu berhasil ditambahkan! Harga jual akan dihitung setelah resep dibuat.");
                            } else {
                                session.setAttribute("errorMsg", "Gagal menambahkan menu! Tidak ada baris yang terpengaruh.");
                            }
                        } catch (SQLException e) {
                            String errorMsg = e.getMessage();
                            if (errorMsg != null) {
                                String lowerErrorMsg = errorMsg.toLowerCase();
                                if (lowerErrorMsg.contains("foreign key") || lowerErrorMsg.contains("kategori_id") || lowerErrorMsg.contains("violates foreign key")) {
                                    session.setAttribute("errorMsg", "Kategori tidak valid! Pastikan kategori yang dipilih sudah ada di database.");
                                } else if (lowerErrorMsg.contains("duplicate") || lowerErrorMsg.contains("unique") || lowerErrorMsg.contains("nama_menu") || lowerErrorMsg.contains("already exists")) {
                                    session.setAttribute("errorMsg", "Menu dengan nama '" + namaMenu.trim() + "' sudah ada! Silakan gunakan nama yang berbeda.");
                                } else if (lowerErrorMsg.contains("not null") || lowerErrorMsg.contains("null value") || lowerErrorMsg.contains("violates not-null")) {
                                    session.setAttribute("errorMsg", "Data tidak lengkap! Pastikan semua field required sudah terisi.");
                                } else if (lowerErrorMsg.contains("connection") || lowerErrorMsg.contains("koneksi")) {
                                    session.setAttribute("errorMsg", "Koneksi database gagal! Silakan coba lagi atau hubungi administrator.");
                                } else {
                                    session.setAttribute("errorMsg", "Error database: " + errorMsg);
                                }
                            } else {
                                session.setAttribute("errorMsg", "Gagal menambahkan menu! Terjadi kesalahan pada database.");
                            }
                            e.printStackTrace();
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "Error: Format data tidak valid! Pastikan margin dan kategori sudah benar.");
                } catch (Exception e) {
                    String errorMessage = e.getMessage();
                    if (errorMessage != null && errorMessage.contains("duplicate") || errorMessage.contains("unique")) {
                        session.setAttribute("errorMsg", "Menu dengan nama '" + namaMenu.trim() + "' sudah ada! Silakan gunakan nama yang berbeda.");
                    } else if (errorMessage != null && errorMessage.contains("foreign key") || errorMessage.contains("constraint")) {
                        session.setAttribute("errorMsg", "Kategori tidak valid! Pastikan kategori yang dipilih sudah ada.");
                    } else {
                        session.setAttribute("errorMsg", "Error: " + (errorMessage != null ? errorMessage : "Terjadi kesalahan saat menambahkan menu. Silakan coba lagi."));
                    }
                    e.printStackTrace();
                }
            }
        }
        
        response.sendRedirect(contextPath + "/MenuController");
    }
}

