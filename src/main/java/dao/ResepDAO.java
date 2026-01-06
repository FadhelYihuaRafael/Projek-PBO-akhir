package dao;

import model.Resep;
import util.KoneksiDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ResepDAO {
    
    public boolean insert(Resep resep) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "INSERT INTO resep (menu_id, bahan_baku_id, jumlah_dibutuhkan, created_by) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, resep.getMenuId());
            stmt.setInt(2, resep.getBahanBakuId());
            stmt.setFloat(3, resep.getJumlahDibutuhkan());
            stmt.setInt(4, resep.getCreatedBy());
            
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
    
    public List<Resep> getAll() {
        List<Resep> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return list;
            }
            
            String sql = "SELECT id, menu_id, bahan_baku_id, jumlah_dibutuhkan, created_by FROM resep ORDER BY id DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Integer id = rs.getInt("id");
                Integer menuId = rs.getInt("menu_id");
                Integer bahanBakuId = rs.getInt("bahan_baku_id");
                Float jumlah = rs.getFloat("jumlah_dibutuhkan");
                Integer createdBy = rs.getInt("created_by");
                
                Resep resep = new Resep(id, menuId, bahanBakuId, jumlah, createdBy);
                list.add(resep);
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
    
    public Resep ambilResepById(Integer id) {
        Resep resep = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return null;
            }
            
            String sql = "SELECT id, menu_id, bahan_baku_id, jumlah_dibutuhkan, created_by FROM resep WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Integer resepId = rs.getInt("id");
                Integer menuId = rs.getInt("menu_id");
                Integer bahanBakuId = rs.getInt("bahan_baku_id");
                Float jumlah = rs.getFloat("jumlah_dibutuhkan");
                Integer createdBy = rs.getInt("created_by");
                
                resep = new Resep(resepId, menuId, bahanBakuId, jumlah, createdBy);
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
        
        return resep;
    }
    
    public boolean update(Resep resep) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "UPDATE resep SET menu_id = ?, bahan_baku_id = ?, jumlah_dibutuhkan = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, resep.getMenuId());
            stmt.setInt(2, resep.getBahanBakuId());
            stmt.setFloat(3, resep.getJumlahDibutuhkan());
            stmt.setInt(4, resep.getId());
            
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
            
            String sql = "DELETE FROM resep WHERE id = ?";
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
    
    public Float hitungHPPByMenuId(Integer menuId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Float totalHPP = 0.0f;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) return 0.0f;
            
            String sql = "SELECT COALESCE(SUM(r.jumlah_dibutuhkan * bb.harga_per_satuan), 0) as total_hpp " +
                         "FROM resep r " +
                         "INNER JOIN bahan_baku bb ON r.bahan_baku_id = bb.id " +
                         "WHERE r.menu_id = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, menuId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                totalHPP = rs.getFloat("total_hpp");
            }
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            return 0.0f;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
        
        return totalHPP;
    }
    
    public List<Resep> ambilResepByMenuId(Integer menuId) {
        List<Resep> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return list;
            }
            
            String sql = "SELECT id, menu_id, bahan_baku_id, jumlah_dibutuhkan, created_by FROM resep WHERE menu_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, menuId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Resep resep = new Resep(
                    rs.getInt("id"),
                    rs.getInt("menu_id"),
                    rs.getInt("bahan_baku_id"),
                    rs.getFloat("jumlah_dibutuhkan"),
                    rs.getInt("created_by")
                );
                list.add(resep);
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
}


