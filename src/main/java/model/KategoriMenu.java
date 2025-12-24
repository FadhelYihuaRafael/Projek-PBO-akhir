package model;

/**
 * Model class untuk tabel kategori_menu
 * @author Admin
 */
public class KategoriMenu {
    private Integer id;
    private String nama;
    private String deskripsi;
    private Integer createdBy;

    // Constructor default
    public KategoriMenu() {
    }

    // Constructor dengan parameter
    public KategoriMenu(Integer id, String nama, String deskripsi, Integer createdBy) {
        this.id = id;
        this.nama = nama;
        this.deskripsi = deskripsi;
        this.createdBy = createdBy;
    }

    // Constructor tanpa id (untuk insert)
    public KategoriMenu(String nama, String deskripsi, Integer createdBy) {
        this.nama = nama;
        this.deskripsi = deskripsi;
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

    public String getDeskripsi() {
        return deskripsi;
    }

    public void setDeskripsi(String deskripsi) {
        this.deskripsi = deskripsi;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "KategoriMenu{" + "id=" + id + ", nama=" + nama + ", deskripsi=" + deskripsi + ", createdBy=" + createdBy + '}';
    }
}

