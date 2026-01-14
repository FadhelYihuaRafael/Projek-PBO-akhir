package model;

/**
 * Model class untuk tabel resep
 * @author Admin
 */
public class Resep {
    private Integer id;
    private Integer menuId;
    private Integer bahanBakuId;
    private Float jumlahDibutuhkan;
    private Float produkYangDihasilkan;
    private Integer createdBy;

    // Constructor default
    public Resep() {
    }

    // Constructor dengan parameter
    public Resep(Integer id, Integer menuId, Integer bahanBakuId, Float jumlahDibutuhkan, Float produkYangDihasilkan, Integer createdBy) {
        this.id = id;
        this.menuId = menuId;
        this.bahanBakuId = bahanBakuId;
        this.jumlahDibutuhkan = jumlahDibutuhkan;
        this.produkYangDihasilkan = produkYangDihasilkan;
        this.createdBy = createdBy;
    }

    // Constructor tanpa id (untuk insert)
    public Resep(Integer menuId, Integer bahanBakuId, Float jumlahDibutuhkan, Float produkYangDihasilkan, Integer createdBy) {
        this.menuId = menuId;
        this.bahanBakuId = bahanBakuId;
        this.jumlahDibutuhkan = jumlahDibutuhkan;
        this.produkYangDihasilkan = produkYangDihasilkan;
        this.createdBy = createdBy;
    }

    // Getter dan Setter
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public Integer getBahanBakuId() {
        return bahanBakuId;
    }

    public void setBahanBakuId(Integer bahanBakuId) {
        this.bahanBakuId = bahanBakuId;
    }

    public Float getJumlahDibutuhkan() {
        return jumlahDibutuhkan;
    }

    public void setJumlahDibutuhkan(Float jumlahDibutuhkan) {
        this.jumlahDibutuhkan = jumlahDibutuhkan;
    }

    public Float getProdukYangDihasilkan() {
        return produkYangDihasilkan;
    }

    public void setProdukYangDihasilkan(Float produkYangDihasilkan) {
        this.produkYangDihasilkan = produkYangDihasilkan;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "Resep{" + "id=" + id + ", menuId=" + menuId + ", bahanBakuId=" + bahanBakuId + ", jumlahDibutuhkan=" + jumlahDibutuhkan + ", produkYangDihasilkan=" + produkYangDihasilkan + ", createdBy=" + createdBy + '}';
    }
}

