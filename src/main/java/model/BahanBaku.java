package model;

/**
 * Model class untuk tabel bahan_baku
 * @author Admin
 */
public class BahanBaku {
    private Integer id;
    private Integer supplierId;
    private String namaBahan;
    private String satuan;
    private Float hargaPerSatuan;
    private Integer stok;
    private Integer createdBy;

    // Constructor default
    public BahanBaku() {
    }

    // Constructor dengan parameter
    public BahanBaku(Integer id, Integer supplierId, String namaBahan, String satuan, 
                     Float hargaPerSatuan, Integer stok, Integer createdBy) {
        this.id = id;
        this.supplierId = supplierId;
        this.namaBahan = namaBahan;
        this.satuan = satuan;
        this.hargaPerSatuan = hargaPerSatuan;
        this.stok = stok;
        this.createdBy = createdBy;
    }

    // Constructor tanpa id (untuk insert)
    public BahanBaku(Integer supplierId, String namaBahan, String satuan, 
                     Float hargaPerSatuan, Integer stok, Integer createdBy) {
        this.supplierId = supplierId;
        this.namaBahan = namaBahan;
        this.satuan = satuan;
        this.hargaPerSatuan = hargaPerSatuan;
        this.stok = stok;
        this.createdBy = createdBy;
    }

    // Getter dan Setter
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public String getNamaBahan() {
        return namaBahan;
    }

    public void setNamaBahan(String namaBahan) {
        this.namaBahan = namaBahan;
    }

    public String getSatuan() {
        return satuan;
    }

    public void setSatuan(String satuan) {
        this.satuan = satuan;
    }

    public Float getHargaPerSatuan() {
        return hargaPerSatuan;
    }

    public void setHargaPerSatuan(Float hargaPerSatuan) {
        this.hargaPerSatuan = hargaPerSatuan;
    }

    public Integer getStok() {
        return stok;
    }

    public void setStok(Integer stok) {
        this.stok = stok;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return "BahanBaku{" + "id=" + id + ", supplierId=" + supplierId + ", namaBahan=" + namaBahan + ", satuan=" + satuan + ", hargaPerSatuan=" + hargaPerSatuan + ", stok=" + stok + ", createdBy=" + createdBy + '}';
    }
}

