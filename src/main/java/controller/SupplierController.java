package controller;

import dao.SupplierDAO;
import model.Supplier;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class SupplierController extends HttpServlet {
    
    private SupplierDAO supplierDAO;
    
    public SupplierController() {
        supplierDAO = new SupplierDAO();
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
            // Handle edit - ambil data supplier untuk ditampilkan di form
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    model.Supplier supplierEdit = supplierDAO.ambilSupplierById(id);
                    if (supplierEdit != null) {
                        request.setAttribute("supplierEdit", supplierEdit);
                    } else {
                        session.setAttribute("errorMsg", "Supplier tidak ditemukan!");
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
                    boolean deleteOk = supplierDAO.delete(id);
                    
                    if (deleteOk) {
                        session.setAttribute("successMsg", "Supplier berhasil dihapus!");
                    } else {
                        session.setAttribute("errorMsg", "Gagal menghapus supplier!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "ID tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
            response.sendRedirect("SupplierController");
            return;
        }
        
        // Default: tampilkan list supplier
        request.setAttribute("daftarSupplier", supplierDAO.getAll());
        
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
        
        request.getRequestDispatcher("/layouts/supplier.jsp").forward(request, response);
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
        String telepon = request.getParameter("telepon");
        String alamat = request.getParameter("alamat");
        
        if ("update".equals(action)) {
            // Update supplier
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "ID supplier tidak ditemukan!");
                response.sendRedirect("SupplierController");
                return;
            }
            
            try {
                int id = Integer.parseInt(idStr);
                
                if (nama == null || nama.trim().isEmpty()) {
                    session.setAttribute("errorMsg", "Nama supplier tidak boleh kosong!");
                    response.sendRedirect("SupplierController");
                    return;
                }
                
                Supplier supplierUpdate = new Supplier();
                supplierUpdate.setId(id);
                supplierUpdate.setNama(nama.trim());
                supplierUpdate.setTelepon(telepon != null ? telepon.trim() : "");
                supplierUpdate.setAlamat(alamat != null ? alamat.trim() : "");
                
                boolean updateOk = supplierDAO.update(supplierUpdate);
                
                if (updateOk) {
                    session.setAttribute("successMsg", "Supplier berhasil diupdate!");
                } else {
                    session.setAttribute("errorMsg", "Gagal mengupdate supplier!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Error: Data tidak valid!");
            } catch (Exception e) {
                session.setAttribute("errorMsg", "Error: " + e.getMessage());
            }
            
        } else {
            // Insert supplier baru
            if (nama == null || nama.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Nama supplier tidak boleh kosong!");
            } else if (userId == null) {
                session.setAttribute("errorMsg", "Session expired! Silakan login kembali.");
            } else {
                try {
                    Supplier supplierBaru = new Supplier(
                        nama.trim(),
                        telepon != null ? telepon.trim() : "",
                        alamat != null ? alamat.trim() : "",
                        userId
                    );
                    
                    boolean tambahOk = supplierDAO.insert(supplierBaru);
                    
                    if (tambahOk) {
                        session.setAttribute("successMsg", "Supplier berhasil ditambahkan!");
                    } else {
                        session.setAttribute("errorMsg", "Gagal menambahkan supplier!");
                    }
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
        }
        
        response.sendRedirect("SupplierController");
    }
}

