package controller;

import dao.BahanBakuDAO;
import dao.SupplierDAO;
import model.BahanBaku;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class BahanBakuController extends HttpServlet {
    
    private BahanBakuDAO bahanDAO;
    private SupplierDAO supplierDAO;
    
    public BahanBakuController() {
        bahanDAO = new BahanBakuDAO();
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
            // Handle edit - ambil data bahan baku untuk ditampilkan di form
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    model.BahanBaku bahanEdit = bahanDAO.ambilBahanBakuById(id);
                    if (bahanEdit != null) {
                        request.setAttribute("bahanEdit", bahanEdit);
                    } else {
                        session.setAttribute("errorMsg", "Bahan baku tidak ditemukan!");
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
                    boolean deleteOk = bahanDAO.delete(id);
                    
                    if (deleteOk) {
                        session.setAttribute("successMsg", "Bahan baku berhasil dihapus!");
                    } else {
                        session.setAttribute("errorMsg", "Gagal menghapus bahan baku!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "ID tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
            response.sendRedirect("BahanBakuController");
            return;
        }
        
        // Default: tampilkan list bahan baku
        request.setAttribute("daftarBahan", bahanDAO.getAll());
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
        
        request.getRequestDispatcher("/layouts/bahan-baku.jsp").forward(request, response);
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
        String namaBahan = request.getParameter("namaBahan");
        String supplierIdStr = request.getParameter("supplierId");
        String satuan = request.getParameter("satuan");
        String hargaStr = request.getParameter("harga");
        String stokStr = request.getParameter("stok");
        
        if ("update".equals(action)) {
            // Update bahan baku
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "ID bahan baku tidak ditemukan!");
                response.sendRedirect("BahanBakuController");
                return;
            }
            
            try {
                int id = Integer.parseInt(idStr);
                int supplierId = Integer.parseInt(supplierIdStr);
                float harga = Float.parseFloat(hargaStr);
                int stok = Integer.parseInt(stokStr);
                
                if (harga <= 0) {
                    session.setAttribute("errorMsg", "Harga harus lebih dari 0!");
                    response.sendRedirect("BahanBakuController");
                    return;
                } else if (stok < 0) {
                    session.setAttribute("errorMsg", "Stok tidak boleh negatif!");
                    response.sendRedirect("BahanBakuController");
                    return;
                }
                
                BahanBaku bahanUpdate = new BahanBaku();
                bahanUpdate.setId(id);
                bahanUpdate.setSupplierId(supplierId);
                bahanUpdate.setNamaBahan(namaBahan != null ? namaBahan.trim() : "");
                bahanUpdate.setSatuan(satuan != null ? satuan.trim() : "");
                bahanUpdate.setHargaPerSatuan(harga);
                bahanUpdate.setStok(stok);
                
                boolean updateOk = bahanDAO.update(bahanUpdate);
                
                if (updateOk) {
                    session.setAttribute("successMsg", "Bahan baku berhasil diupdate!");
                } else {
                    session.setAttribute("errorMsg", "Gagal mengupdate bahan baku!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Error: Data tidak valid!");
            } catch (Exception e) {
                session.setAttribute("errorMsg", "Error: " + e.getMessage());
            }
            
        } else {
            // Insert bahan baku baru
            if (namaBahan == null || namaBahan.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Nama bahan tidak boleh kosong!");
            } else if (supplierIdStr == null || supplierIdStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Supplier harus dipilih!");
            } else if (satuan == null || satuan.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Satuan tidak boleh kosong!");
            } else if (hargaStr == null || hargaStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Harga tidak boleh kosong!");
            } else if (stokStr == null || stokStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Stok tidak boleh kosong!");
            } else if (userId == null) {
                session.setAttribute("errorMsg", "Session expired! Silakan login kembali.");
            } else {
                try {
                    int supplierId = Integer.parseInt(supplierIdStr);
                    float harga = Float.parseFloat(hargaStr);
                    int stok = Integer.parseInt(stokStr);
                    
                    if (harga <= 0) {
                        session.setAttribute("errorMsg", "Harga harus lebih dari 0!");
                    } else if (stok < 0) {
                        session.setAttribute("errorMsg", "Stok tidak boleh negatif!");
                    } else {
                        BahanBaku bahanBaru = new BahanBaku(
                            supplierId,
                            namaBahan.trim(),
                            satuan.trim(),
                            harga,
                            stok,
                            userId
                        );
                        
                        boolean tambahOk = bahanDAO.insert(bahanBaru);
                        
                        if (tambahOk) {
                            session.setAttribute("successMsg", "Bahan baku berhasil ditambahkan!");
                        } else {
                            session.setAttribute("errorMsg", "Gagal menambahkan bahan baku!");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "Error: Data tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
        }
        
        response.sendRedirect("BahanBakuController");
    }
}

