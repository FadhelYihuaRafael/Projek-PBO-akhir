package dao;

import model.BahanBaku;
import util.KoneksiDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BahanBakuDAO {
    
    public List<BahanBaku> getAll() {
        List<BahanBaku> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return list;
            }
            
            String sql = "SELECT id, supplier_id, nama_bahan, satuan, harga_per_satuan, stok, created_by FROM bahan_baku ORDER BY nama_bahan ASC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Integer id = rs.getInt("id");
                Integer supplierId = rs.getInt("supplier_id");
                String namaBahan = rs.getString("nama_bahan");
                String satuan = rs.getString("satuan");
                Float hargaPerSatuan = rs.getFloat("harga_per_satuan");
                Integer stok = rs.getInt("stok");
                Integer createdBy = rs.getInt("created_by");
                
                BahanBaku bahan = new BahanBaku(id, supplierId, namaBahan, satuan, hargaPerSatuan, stok, createdBy);
                list.add(bahan);
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
    
    public BahanBaku ambilBahanBakuById(Integer id) {
        BahanBaku bahan = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return null;
            }
            
            String sql = "SELECT id, supplier_id, nama_bahan, satuan, harga_per_satuan, stok, created_by FROM bahan_baku WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Integer bahanId = rs.getInt("id");
                Integer supplierId = rs.getInt("supplier_id");
                String namaBahan = rs.getString("nama_bahan");
                String satuan = rs.getString("satuan");
                Float hargaPerSatuan = rs.getFloat("harga_per_satuan");
                Integer stok = rs.getInt("stok");
                Integer createdBy = rs.getInt("created_by");
                
                bahan = new BahanBaku(bahanId, supplierId, namaBahan, satuan, hargaPerSatuan, stok, createdBy);
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
        
        return bahan;
    }
    
    public boolean insert(BahanBaku bahan) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "INSERT INTO bahan_baku (supplier_id, nama_bahan, satuan, harga_per_satuan, stok, created_by) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, bahan.getSupplierId());
            stmt.setString(2, bahan.getNamaBahan());
            stmt.setString(3, bahan.getSatuan());
            stmt.setFloat(4, bahan.getHargaPerSatuan());
            stmt.setInt(5, bahan.getStok());
            stmt.setInt(6, bahan.getCreatedBy());
            
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
    
    public boolean update(BahanBaku bahan) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "UPDATE bahan_baku SET supplier_id = ?, nama_bahan = ?, satuan = ?, harga_per_satuan = ?, stok = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, bahan.getSupplierId());
            stmt.setString(2, bahan.getNamaBahan());
            stmt.setString(3, bahan.getSatuan());
            stmt.setFloat(4, bahan.getHargaPerSatuan());
            stmt.setInt(5, bahan.getStok());
            stmt.setInt(6, bahan.getId());
            
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
            
            String sql = "DELETE FROM bahan_baku WHERE id = ?";
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

