package model;

/**
 * Model class untuk tabel users
 * @author Admin
 */
public class User {
    private Integer id;
    private String nama;
    private String email;
    private String password;
    private String role;

    // Constructor default
    public User() {
    }

    // Constructor dengan parameter
    public User(Integer id, String nama, String email, String password, String role) {
        this.id = id;
        this.nama = nama;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Constructor tanpa id (untuk insert)
    public User(String nama, String email, String password, String role) {
        this.nama = nama;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getter dan Setter
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", nama=" + nama + ", email=" + email + ", role=" + role + '}';
    }
}

