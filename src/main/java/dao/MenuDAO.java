package dao;

import model.Menu;
import util.KoneksiDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {
    
    public boolean insert(Menu menu) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                throw new SQLException("Koneksi database gagal!");
            }
            
            String sql = "INSERT INTO menu (kategori_id, nama_menu, harga_jual, margin_persen, deskripsi, created_by) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, menu.getKategoriId());
            stmt.setString(2, menu.getNamaMenu());
            stmt.setInt(3, menu.getHargaJual());
            if (menu.getMarginPersen() != null) {
                stmt.setFloat(4, menu.getMarginPersen());
            } else {
                stmt.setNull(4, java.sql.Types.FLOAT);
            }
            if (menu.getDeskripsi() != null && !menu.getDeskripsi().trim().isEmpty()) {
                stmt.setString(5, menu.getDeskripsi());
            } else {
                stmt.setNull(5, java.sql.Types.VARCHAR);
            }
            stmt.setInt(6, menu.getCreatedBy());
            
            int result = stmt.executeUpdate();
            
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error insert menu: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw exception agar bisa ditangkap di controller
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
            
            String sql = "SELECT id, kategori_id, nama_menu, harga_jual, margin_persen, deskripsi, created_by FROM menu ORDER BY id DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Integer id = rs.getInt("id");
                Integer kategoriId = rs.getInt("kategori_id");
                String namaMenu = rs.getString("nama_menu");
                Integer hargaJual = rs.getInt("harga_jual");
                Float marginPersen = rs.getFloat("margin_persen");
                if (rs.wasNull()) {
                    marginPersen = null;
                }
                String deskripsi = rs.getString("deskripsi");
                Integer createdBy = rs.getInt("created_by");
                
                Menu menu = new Menu(id, kategoriId, namaMenu, hargaJual, marginPersen, deskripsi, createdBy);
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
            
            String sql = "SELECT id, kategori_id, nama_menu, harga_jual, margin_persen, deskripsi, created_by FROM menu WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Integer menuId = rs.getInt("id");
                Integer kategoriId = rs.getInt("kategori_id");
                String namaMenu = rs.getString("nama_menu");
                Integer hargaJual = rs.getInt("harga_jual");
                Float marginPersen = rs.getFloat("margin_persen");
                if (rs.wasNull()) {
                    marginPersen = null;
                }
                String deskripsi = rs.getString("deskripsi");
                Integer createdBy = rs.getInt("created_by");
                
                menu = new Menu(menuId, kategoriId, namaMenu, hargaJual, marginPersen, deskripsi, createdBy);
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
            
            String sql = "UPDATE menu SET kategori_id = ?, nama_menu = ?, harga_jual = ?, margin_persen = ?, deskripsi = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, menu.getKategoriId());
            stmt.setString(2, menu.getNamaMenu());
            stmt.setInt(3, menu.getHargaJual());
            if (menu.getMarginPersen() != null) {
                stmt.setFloat(4, menu.getMarginPersen());
            } else {
                stmt.setNull(4, java.sql.Types.FLOAT);
            }
            if (menu.getDeskripsi() != null && !menu.getDeskripsi().trim().isEmpty()) {
                stmt.setString(5, menu.getDeskripsi());
            } else {
                stmt.setNull(5, java.sql.Types.VARCHAR);
            }
            stmt.setInt(6, menu.getId());
            
            int result = stmt.executeUpdate();
            
            return result > 0;
            
        } catch (Exception e) {
            System.err.println("Error update menu: " + e.getMessage());
            e.printStackTrace();
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
    
    public Menu ambilMenuByNama(String namaMenu) {
        Menu menu = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return null;
            }
            
            String sql = "SELECT id, kategori_id, nama_menu, harga_jual, margin_persen, deskripsi, created_by FROM menu WHERE LOWER(nama_menu) = LOWER(?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, namaMenu);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Integer menuId = rs.getInt("id");
                Integer kategoriId = rs.getInt("kategori_id");
                String nama = rs.getString("nama_menu");
                Integer hargaJual = rs.getInt("harga_jual");
                Float marginPersen = rs.getFloat("margin_persen");
                if (rs.wasNull()) {
                    marginPersen = null;
                }
                String deskripsi = rs.getString("deskripsi");
                Integer createdBy = rs.getInt("created_by");
                
                menu = new Menu(menuId, kategoriId, nama, hargaJual, marginPersen, deskripsi, createdBy);
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
    
    public Integer insertDanAmbilId(Menu menu) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = KoneksiDB.getConnection();
            if (conn == null) {
                return null;
            }
            
            String sql = "INSERT INTO menu (kategori_id, nama_menu, harga_jual, margin_persen, deskripsi, created_by) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            
            stmt.setInt(1, menu.getKategoriId());
            stmt.setString(2, menu.getNamaMenu());
            stmt.setInt(3, menu.getHargaJual());
            if (menu.getMarginPersen() != null) {
                stmt.setFloat(4, menu.getMarginPersen());
            } else {
                stmt.setNull(4, java.sql.Types.FLOAT);
            }
            if (menu.getDeskripsi() != null && !menu.getDeskripsi().trim().isEmpty()) {
                stmt.setString(5, menu.getDeskripsi());
            } else {
                stmt.setNull(5, java.sql.Types.VARCHAR);
            }
            stmt.setInt(6, menu.getCreatedBy());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            
            return null;
            
        } catch (Exception e) {
            System.err.println("Error insertDanAmbilId menu: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
    }
}

