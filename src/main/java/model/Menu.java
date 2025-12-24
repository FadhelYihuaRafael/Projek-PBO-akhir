package model;

/**
 * Model class untuk tabel menu
 * @author Admin
 */
public class Menu {
    private Integer id;
    private Integer kategoriId;
    private String namaMenu;
    private Integer hargaJual;
    private String deskripsi;
    private Integer createdBy;

    // Constructor default
    public Menu() {
    }

    // Constructor dengan parameter
    public Menu(Integer id, Integer kategoriId, String namaMenu, Integer hargaJual, 
                String deskripsi, Integer createdBy) {
        this.id = id;
        this.kategoriId = kategoriId;
        this.namaMenu = namaMenu;
        this.hargaJual = hargaJual;
        this.deskripsi = deskripsi;
        this.createdBy = createdBy;
    }

    // Constructor tanpa id (untuk insert)
    public Menu(Integer kategoriId, String namaMenu, Integer hargaJual, 
                String deskripsi, Integer createdBy) {
        this.kategoriId = kategoriId;
        this.namaMenu = namaMenu;
        this.hargaJual = hargaJual;
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

    public Integer getKategoriId() {
        return kategoriId;
    }

    public void setKategoriId(Integer kategoriId) {
        this.kategoriId = kategoriId;
    }

    public String getNamaMenu() {
        return namaMenu;
    }

    public void setNamaMenu(String namaMenu) {
        this.namaMenu = namaMenu;
    }

    public Integer getHargaJual() {
        return hargaJual;
    }

    public void setHargaJual(Integer hargaJual) {
        this.hargaJual = hargaJual;
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
        return "Menu{" + "id=" + id + ", kategoriId=" + kategoriId + ", namaMenu=" + namaMenu + ", hargaJual=" + hargaJual + ", deskripsi=" + deskripsi + ", createdBy=" + createdBy + '}';
    }
}

