package controller;

import dao.KategoriMenuDAO;
import model.KategoriMenu;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class KategoriMenuController extends HttpServlet {
    
    private KategoriMenuDAO kategoriDAO;
    
    public KategoriMenuController() {
        kategoriDAO = new KategoriMenuDAO();
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
            // Handle edit - ambil data kategori untuk ditampilkan di form
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    model.KategoriMenu kategoriEdit = kategoriDAO.ambilKategoriById(id);
                    if (kategoriEdit != null) {
                        request.setAttribute("kategoriEdit", kategoriEdit);
                    } else {
                        session.setAttribute("errorMsg", "Kategori menu tidak ditemukan!");
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
                    boolean deleteOk = kategoriDAO.delete(id);
                    
                    if (deleteOk) {
                        session.setAttribute("successMsg", "Kategori menu berhasil dihapus!");
                    } else {
                        session.setAttribute("errorMsg", "Gagal menghapus kategori menu!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "ID tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
            response.sendRedirect("KategoriMenuController");
            return;
        }
        
        // Default: tampilkan list kategori menu
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
        
        request.getRequestDispatcher("/layouts/kategori-menu.jsp").forward(request, response);
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
        String nama = request.getParameter("nama");
        String deskripsi = request.getParameter("deskripsi");
        
        if ("update".equals(action)) {
            // Update kategori menu
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "ID kategori tidak ditemukan!");
                response.sendRedirect("KategoriMenuController");
                return;
            }
            
            try {
                int id = Integer.parseInt(idStr);
                
                if (nama == null || nama.trim().isEmpty()) {
                    session.setAttribute("errorMsg", "Nama kategori tidak boleh kosong!");
                    response.sendRedirect("KategoriMenuController");
                    return;
                }
                
                KategoriMenu kategoriUpdate = new KategoriMenu();
                kategoriUpdate.setId(id);
                kategoriUpdate.setNama(nama.trim());
                kategoriUpdate.setDeskripsi(deskripsi != null ? deskripsi.trim() : "");
                
                boolean updateOk = kategoriDAO.update(kategoriUpdate);
                
                if (updateOk) {
                    session.setAttribute("successMsg", "Kategori menu berhasil diupdate!");
                } else {
                    session.setAttribute("errorMsg", "Gagal mengupdate kategori menu!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Error: Data tidak valid!");
            } catch (Exception e) {
                session.setAttribute("errorMsg", "Error: " + e.getMessage());
            }
            
        } else {
            // Insert kategori menu baru
            if (nama == null || nama.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Nama kategori tidak boleh kosong!");
            } else if (userId == null) {
                session.setAttribute("errorMsg", "Session expired! Silakan login kembali.");
            } else {
                try {
                    KategoriMenu kategoriBaru = new KategoriMenu(
                        nama.trim(),
                        deskripsi != null ? deskripsi.trim() : "",
                        userId
                    );
                    
                    boolean tambahOk = kategoriDAO.insert(kategoriBaru);
                    
                    if (tambahOk) {
                        session.setAttribute("successMsg", "Kategori menu berhasil ditambahkan!");
                    } else {
                        session.setAttribute("errorMsg", "Gagal menambahkan kategori menu!");
                    }
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
        }
        
        response.sendRedirect("KategoriMenuController");
    }
}

