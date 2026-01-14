package controller;

import dao.ResepDAO;
import dao.MenuDAO;
import dao.BahanBakuDAO;
import model.Resep;
import model.Menu;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class ResepController extends HttpServlet {
    
    private ResepDAO resepDAO;
    private MenuDAO menuDAO;
    private BahanBakuDAO bahanDAO;
    
    public ResepController() {
        resepDAO = new ResepDAO();
        menuDAO = new MenuDAO();
        bahanDAO = new BahanBakuDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cek session
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            // Handle delete
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    boolean deleteOk = resepDAO.delete(id);
                    
                    if (deleteOk) {
                        session.setAttribute("successMsg", "Resep berhasil dihapus!");
                    } else {
                        session.setAttribute("errorMsg", "Gagal menghapus resep!");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "ID tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/ResepController");
            return;
        }
        
        // Default: tampilkan list resep
        request.setAttribute("daftarResep", resepDAO.getAll());
        request.setAttribute("daftarMenu", menuDAO.getAll());
        request.setAttribute("daftarBahan", bahanDAO.getAll());
        
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
        
        request.getRequestDispatcher("/layouts/resep.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cek session
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        String menuIdStr = request.getParameter("menuId");
        String bahanBakuIdStr = request.getParameter("bahanBakuId");
        String jumlahStr = request.getParameter("jumlah");
        String produkYangDihasilkanStr = request.getParameter("produkYangDihasilkan");
        
        if ("update".equals(action)) {
            // Update resep
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "ID resep tidak ditemukan!");
                String contextPath = request.getContextPath();
                response.sendRedirect(contextPath + "/ResepController");
                return;
            }
            
            try {
                int id = Integer.parseInt(idStr);
                int menuId = Integer.parseInt(menuIdStr);
                int bahanBakuId = Integer.parseInt(bahanBakuIdStr);
                float jumlah = Float.parseFloat(jumlahStr);
                float produkYangDihasilkan = produkYangDihasilkanStr != null && !produkYangDihasilkanStr.trim().isEmpty() 
                    ? Float.parseFloat(produkYangDihasilkanStr) : 0.0f;
                
                if (jumlah <= 0) {
                    session.setAttribute("errorMsg", "Jumlah harus lebih dari 0!");
                    String contextPath = request.getContextPath();
                    response.sendRedirect(contextPath + "/ResepController");
                    return;
                }
                
                if (produkYangDihasilkan <= 0) {
                    session.setAttribute("errorMsg", "Produk yang dihasilkan harus lebih dari 0!");
                    String contextPath = request.getContextPath();
                    response.sendRedirect(contextPath + "/ResepController");
                    return;
                }
                
                Resep resepUpdate = new Resep();
                resepUpdate.setId(id);
                resepUpdate.setMenuId(menuId);
                resepUpdate.setBahanBakuId(bahanBakuId);
                resepUpdate.setJumlahDibutuhkan(jumlah);
                resepUpdate.setProdukYangDihasilkan(produkYangDihasilkan);
                
                boolean updateOk = resepDAO.update(resepUpdate);
                
                if (updateOk) {
                    // Update harga jual menu otomatis berdasarkan HPP + margin
                    Menu menuUpdate = menuDAO.ambilMenuById(menuId);
                    if (menuUpdate != null && menuUpdate.getMarginPersen() != null) {
                        Float hpp = resepDAO.hitungHPPByMenuId(menuId);
                        if (hpp != null && hpp > 0) {
                            int hargaJual = Math.round(hpp + (hpp * menuUpdate.getMarginPersen() / 100));
                            menuUpdate.setHargaJual(hargaJual);
                            menuDAO.update(menuUpdate);
                        }
                    }
                    session.setAttribute("successMsg", "Resep berhasil diupdate!");
                } else {
                    session.setAttribute("errorMsg", "Gagal mengupdate resep!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Error: Data tidak valid!");
            } catch (Exception e) {
                session.setAttribute("errorMsg", "Error: " + e.getMessage());
            }
            
        } else {
            // Insert resep baru
            if (menuIdStr == null || menuIdStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Menu harus dipilih!");
            } else if (bahanBakuIdStr == null || bahanBakuIdStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Bahan baku harus dipilih!");
            } else if (jumlahStr == null || jumlahStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Jumlah tidak boleh kosong!");
            } else if (produkYangDihasilkanStr == null || produkYangDihasilkanStr.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Produk yang dihasilkan tidak boleh kosong!");
            } else if (userId == null) {
                session.setAttribute("errorMsg", "Session expired! Silakan login kembali.");
            } else {
                try {
                    int menuId = Integer.parseInt(menuIdStr);
                    int bahanBakuId = Integer.parseInt(bahanBakuIdStr);
                    float jumlah = Float.parseFloat(jumlahStr);
                    float produkYangDihasilkan = Float.parseFloat(produkYangDihasilkanStr);
                    
                    if (jumlah <= 0) {
                        session.setAttribute("errorMsg", "Jumlah harus lebih dari 0!");
                    } else if (produkYangDihasilkan <= 0) {
                        session.setAttribute("errorMsg", "Produk yang dihasilkan harus lebih dari 0!");
                    } else {
                        Resep resepBaru = new Resep(menuId, bahanBakuId, jumlah, produkYangDihasilkan, userId);
                        boolean tambahOk = resepDAO.insert(resepBaru);
                        
                        if (tambahOk) {
                            // Update harga jual menu otomatis berdasarkan HPP + margin
                            Menu menuUpdate = menuDAO.ambilMenuById(menuId);
                            if (menuUpdate != null && menuUpdate.getMarginPersen() != null) {
                                Float hpp = resepDAO.hitungHPPByMenuId(menuId);
                                if (hpp != null && hpp > 0) {
                                    int hargaJual = Math.round(hpp + (hpp * menuUpdate.getMarginPersen() / 100));
                                    menuUpdate.setHargaJual(hargaJual);
                                    menuDAO.update(menuUpdate);
                                }
                            }
                            session.setAttribute("successMsg", "Resep berhasil ditambahkan!");
                        } else {
                            session.setAttribute("errorMsg", "Gagal menambahkan resep!");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMsg", "Error: Data tidak valid!");
                } catch (Exception e) {
                    session.setAttribute("errorMsg", "Error: " + e.getMessage());
                }
            }
        }
        
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/ResepController");
    }
}

