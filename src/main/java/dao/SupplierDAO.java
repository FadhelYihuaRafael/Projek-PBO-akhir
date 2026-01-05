package dao;

import model.Supplier;
import util.KoneksiDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO {
    
    public boolean tambahSupplier(Supplier supplier) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "INSERT INTO supplier (nama, telepon, alamat, created_by) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, supplier.getNama());
            stmt.setString(2, supplier.getTelepon());
            stmt.setString(3, supplier.getAlamat());
            stmt.setInt(4, supplier.getCreatedBy());
            
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
    
    public List<Supplier> ambilSemuaSupplier() {
        List<Supplier> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return list;
            }
            
            String sql = "SELECT id, nama, telepon, alamat, created_by FROM supplier ORDER BY id DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Integer id = rs.getInt("id");
                String nama = rs.getString("nama");
                String telepon = rs.getString("telepon");
                String alamat = rs.getString("alamat");
                Integer createdBy = rs.getInt("created_by");
                
                Supplier supplier = new Supplier(id, nama, telepon, alamat, createdBy);
                list.add(supplier);
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
    
    public Supplier ambilSupplierById(Integer id) {
        Supplier supplier = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return null;
            }
            
            String sql = "SELECT id, nama, telepon, alamat, created_by FROM supplier WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Integer supplierId = rs.getInt("id");
                String nama = rs.getString("nama");
                String telepon = rs.getString("telepon");
                String alamat = rs.getString("alamat");
                Integer createdBy = rs.getInt("created_by");
                
                supplier = new Supplier(supplierId, nama, telepon, alamat, createdBy);
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
        
        return supplier;
    }
    
    public boolean updateSupplier(Supplier supplier) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "UPDATE supplier SET nama = ?, telepon = ?, alamat = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, supplier.getNama());
            stmt.setString(2, supplier.getTelepon());
            stmt.setString(3, supplier.getAlamat());
            stmt.setInt(4, supplier.getId());
            
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
    
    public boolean hapusSupplier(Integer id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return false;
            }
            
            String sql = "DELETE FROM supplier WHERE id = ?";
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

