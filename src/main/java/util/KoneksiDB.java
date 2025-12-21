/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Admin
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class KoneksiDB {

    public static Connection getConnection() {
        try {
            // Port 5432 dan database postgres
            String url = "jdbc:postgresql://localhost:5433/hitung_hpp";
            String user = "postgres";  // atau "riza" sesuai username Anda
            String pass = "root";
            Connection conn = DriverManager.getConnection(url, user, pass);
            System.out.println("Koneksi ke database postgres berhasil");
            return conn;
        } catch (Exception e) {
            System.err.println("Koneksi gagal: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        if (KoneksiDB.getConnection() != null) {
            System.out.println("Koneksi berhasil");
        }
    }
}
