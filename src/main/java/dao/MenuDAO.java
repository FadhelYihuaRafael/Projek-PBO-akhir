package dao;

import model.Menu;
import util.KoneksiDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {
    
    public boolean insert(Menu menu) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "INSERT INTO menu (kategori_id, nama_menu, harga_jual, deskripsi, created_by) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, menu.getKategoriId());
            stmt.setString(2, menu.getNamaMenu());
            stmt.setInt(3, menu.getHargaJual());
            stmt.setString(4, menu.getDeskripsi());
            stmt.setInt(5, menu.getCreatedBy());
            
            int result = stmt.executeUpdate();
            
            return result > 0;
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
    }
    
    public List<Menu> getAll() {
        List<Menu> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return list;
            }
            
            String sql = "SELECT id, kategori_id, nama_menu, harga_jual, deskripsi, created_by FROM menu ORDER BY id DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Integer id = rs.getInt("id");
                Integer kategoriId = rs.getInt("kategori_id");
                String namaMenu = rs.getString("nama_menu");
                Integer hargaJual = rs.getInt("harga_jual");
                String deskripsi = rs.getString("deskripsi");
                Integer createdBy = rs.getInt("created_by");
                
                Menu menu = new Menu(id, kategoriId, namaMenu, hargaJual, deskripsi, createdBy);
                list.add(menu);
            }
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
        
        return list;
    }
    
    public Menu ambilMenuById(Integer id) {
        Menu menu = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return null;
            }
            
            String sql = "SELECT id, kategori_id, nama_menu, harga_jual, deskripsi, created_by FROM menu WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Integer menuId = rs.getInt("id");
                Integer kategoriId = rs.getInt("kategori_id");
                String namaMenu = rs.getString("nama_menu");
                Integer hargaJual = rs.getInt("harga_jual");
                String deskripsi = rs.getString("deskripsi");
                Integer createdBy = rs.getInt("created_by");
                
                menu = new Menu(menuId, kategoriId, namaMenu, hargaJual, deskripsi, createdBy);
            }
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
        
        return menu;
    }
    
    public boolean update(Menu menu) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "UPDATE menu SET kategori_id = ?, nama_menu = ?, harga_jual = ?, deskripsi = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, menu.getKategoriId());
            stmt.setString(2, menu.getNamaMenu());
            stmt.setInt(3, menu.getHargaJual());
            stmt.setString(4, menu.getDeskripsi());
            stmt.setInt(5, menu.getId());
            
            int result = stmt.executeUpdate();
            
            return result > 0;
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
    }
    
    public boolean delete(Integer id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "DELETE FROM menu WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int result = stmt.executeUpdate();
            
            return result > 0;
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
    }
}

