package dao;

import model.KategoriMenu;
import util.KoneksiDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class KategoriMenuDAO {
    
    public List<KategoriMenu> getAll() {
        List<KategoriMenu> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return list;
            }
            
            String sql = "SELECT id, nama, deskripsi, created_by FROM kategori_menu ORDER BY nama ASC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Integer id = rs.getInt("id");
                String nama = rs.getString("nama");
                String deskripsi = rs.getString("deskripsi");
                Integer createdBy = rs.getInt("created_by");
                
                KategoriMenu kategori = new KategoriMenu(id, nama, deskripsi, createdBy);
                list.add(kategori);
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
    
    public KategoriMenu ambilKategoriById(Integer id) {
        KategoriMenu kategori = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return null;
            }
            
            String sql = "SELECT id, nama, deskripsi, created_by FROM kategori_menu WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Integer kategoriId = rs.getInt("id");
                String nama = rs.getString("nama");
                String deskripsi = rs.getString("deskripsi");
                Integer createdBy = rs.getInt("created_by");
                
                kategori = new KategoriMenu(kategoriId, nama, deskripsi, createdBy);
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
        
        return kategori;
    }
    
    public boolean insert(KategoriMenu kategori) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "INSERT INTO kategori_menu (nama, deskripsi, created_by) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, kategori.getNama());
            stmt.setString(2, kategori.getDeskripsi());
            stmt.setInt(3, kategori.getCreatedBy());
            
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
    
    public boolean update(KategoriMenu kategori) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "UPDATE kategori_menu SET nama = ?, deskripsi = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, kategori.getNama());
            stmt.setString(2, kategori.getDeskripsi());
            stmt.setInt(3, kategori.getId());
            
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
            
            String sql = "DELETE FROM kategori_menu WHERE id = ?";
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

