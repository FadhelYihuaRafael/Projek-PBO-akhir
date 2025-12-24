package model;

/**
 * Model class untuk tabel supplier
 * @author Admin
 */
public class Supplier {
    private Integer id;
    private String nama;
    private String telepon;
    private String alamat;
    private Integer createdBy;

    // Constructor default
    public Supplier() {
    }

    // Constructor dengan parameter
    public Supplier(Integer id, String nama, String telepon, String alamat, Integer createdBy) {
        this.id = id;
        this.nama = nama;
        this.telepon = telepon;
        this.alamat = alamat;
        this.createdBy = createdBy;
    }

    // Constructor tanpa id (untuk insert)
    public Supplier(String nama, String telepon, String alamat, Integer createdBy) {
        this.nama = nama;
        this.telepon = telepon;
        this.alamat = alamat;
        this.createdBy = createdBy;
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

    public String getTelepon() {
        return telepon;
    }

    public void setTelepon(String telepon) {
        this.telepon = telepon;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "Supplier{" + "id=" + id + ", nama=" + nama + ", telepon=" + telepon + ", alamat=" + alamat + ", createdBy=" + createdBy + '}';
    }
}

