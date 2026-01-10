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
        
        // Cek session
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            response.sendRedirect("../login.jsp");
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
                    boolean deleteOk = menuDAO.delete(id);
                    
                    if (deleteOk) {
                        session.setAttribute("successMsg", "Menu berhasil dihapus!");
                    } else {
                        session.setAttribute("errorMsg", "Gagal menghapus menu!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "ID tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
            response.sendRedirect("MenuController");
            return;
        }
        
        // Default: tampilkan list menu
        request.setAttribute("daftarMenu", menuDAO.getAll());
        request.setAttribute("daftarKategori", kategoriDAO.getAll());
        
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
        
        // Cek session
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        String namaMenu = request.getParameter("namaMenu");
        String hargaJualStr = request.getParameter("hargaJual");
        String deskripsi = request.getParameter("deskripsi");
        String kategoriIdStr = request.getParameter("kategoriId");
        
        if ("update".equals(action)) {
            // Update menu
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "ID menu tidak ditemukan!");
                response.sendRedirect("MenuController");
                return;
            }
            
            try {
                int id = Integer.parseInt(idStr);
                int kategoriId = Integer.parseInt(kategoriIdStr);
                int hargaJual = Integer.parseInt(hargaJualStr);
                
                if (namaMenu == null || namaMenu.trim().isEmpty()) {
                    session.setAttribute("errorMsg", "Nama menu tidak boleh kosong!");
                    response.sendRedirect("MenuController");
                    return;
                }
                
                if (hargaJual <= 0) {
                    session.setAttribute("errorMsg", "Harga jual harus lebih dari 0!");
                    response.sendRedirect("MenuController");
                    return;
                }
                
                Menu menuUpdate = new Menu();
                menuUpdate.setId(id);
                menuUpdate.setKategoriId(kategoriId);
                menuUpdate.setNamaMenu(namaMenu.trim());
                menuUpdate.setHargaJual(hargaJual);
                menuUpdate.setDeskripsi(deskripsi != null ? deskripsi.trim() : "");
                
                boolean updateOk = menuDAO.update(menuUpdate);
                
                if (updateOk) {
                    session.setAttribute("successMsg", "Menu berhasil diupdate!");
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
            } else if (hargaJualStr == null || hargaJualStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Harga jual tidak boleh kosong!");
            } else if (kategoriIdStr == null || kategoriIdStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Kategori harus dipilih!");
            } else if (userId == null) {
                session.setAttribute("errorMsg", "Session expired! Silakan login kembali.");
            } else {
                try {
                    int kategoriId = Integer.parseInt(kategoriIdStr);
                    int hargaJual = Integer.parseInt(hargaJualStr);
                    
                    if (hargaJual <= 0) {
                        session.setAttribute("errorMsg", "Harga jual harus lebih dari 0!");
                    } else {
                        Menu menuBaru = new Menu(
                            kategoriId,
                            namaMenu.trim(),
                            hargaJual,
                            deskripsi != null ? deskripsi.trim() : "",
                            userId
                        );
                        
                        boolean tambahOk = menuDAO.insert(menuBaru);
                        
                        if (tambahOk) {
                            session.setAttribute("successMsg", "Menu berhasil ditambahkan!");
                        } else {
                            session.setAttribute("errorMsg", "Gagal menambahkan menu!");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "Error: Harga jual atau kategori tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
        }
        
        response.sendRedirect("MenuController");
    }
}

