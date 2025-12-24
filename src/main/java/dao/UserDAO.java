package dao;

import model.User;
import util.KoneksiDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    public User cariUserByEmail(String email) {
        
        User user = null;
        Connection koneksi = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            koneksi = KoneksiDB.getConnection();
            
            if (koneksi == null) {
                return null;
            }
            
            String sql = "SELECT id, nama, email, password, role FROM \"users\" WHERE LOWER(email) = LOWER(?)";
            ps = koneksi.prepareStatement(sql);
            
            if (email != null) {
                email = email.trim();
            }
            ps.setString(1, email);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Integer id = rs.getInt("id");
                String nama = rs.getString("nama");
                String emailDariDB = rs.getString("email");
                String passwordDariDB = rs.getString("password");
                String roleDariDB = rs.getString("role");
                
                user = new User(id, nama, emailDariDB, passwordDariDB, roleDariDB);
            }
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (koneksi != null) koneksi.close();
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
        
        return user;
    }
    
    public boolean cekLogin(String email, String password, String role) {
        
        if (email != null) {
            email = email.trim();
        }
        if (password != null) {
            password = password.trim();
        }
        if (role != null) {
            role = role.trim();
        }
        
        User user = cariUserByEmail(email);
        
        if (user == null) {
            return false;
        }
        
        String passwordDiDatabase = user.getPassword();
        if (passwordDiDatabase == null || !passwordDiDatabase.trim().equals(password)) {
            return false;
        }
        
        String roleDiDatabase = user.getRole();
        if (roleDiDatabase == null || !roleDiDatabase.trim().equalsIgnoreCase(role)) {
            return false;
        }
        
        return true;
    }
}

