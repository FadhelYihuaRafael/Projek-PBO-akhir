package util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

/**
 * Pricing Calculator untuk menghitung COGS (HPP) dan Harga Jual
 * menggunakan Margin Pricing (bukan Markup)
 * 
 * @author Senior Software Engineer
 */
public class PricingCalculator {
    
    /**
     * Result class untuk menyimpan hasil perhitungan
     */
    public static class PricingResult {
        private final BigDecimal totalCOGS;
        private final BigDecimal cogsPerUnit;
        private final BigDecimal suggestedSellingPrice;
        private final BigDecimal grossProfitPerUnit;
        private final String formattedTotalCOGS;
        private final String formattedCOGSPerUnit;
        private final String formattedSellingPrice;
        private final String formattedGrossProfit;
        
        public PricingResult(BigDecimal totalCOGS, BigDecimal cogsPerUnit, 
                           BigDecimal suggestedSellingPrice, BigDecimal grossProfitPerUnit) {
            this.totalCOGS = totalCOGS;
            this.cogsPerUnit = cogsPerUnit;
            this.suggestedSellingPrice = suggestedSellingPrice;
            this.grossProfitPerUnit = grossProfitPerUnit;
            
            // Format untuk IDR
            DecimalFormat idrFormat = new DecimalFormat("#,###", 
                new DecimalFormatSymbols(Locale.ITALIAN));
            idrFormat.setRoundingMode(RoundingMode.UP);
            
            this.formattedTotalCOGS = "Rp " + idrFormat.format(totalCOGS);
            this.formattedCOGSPerUnit = "Rp " + idrFormat.format(cogsPerUnit);
            this.formattedSellingPrice = "Rp " + idrFormat.format(suggestedSellingPrice);
            this.formattedGrossProfit = "Rp " + idrFormat.format(grossProfitPerUnit);
        }
        
        // Getters
        public BigDecimal getTotalCOGS() { return totalCOGS; }
        public BigDecimal getCogsPerUnit() { return cogsPerUnit; }
        public BigDecimal getSuggestedSellingPrice() { return suggestedSellingPrice; }
        public BigDecimal getGrossProfitPerUnit() { return grossProfitPerUnit; }
        public String getFormattedTotalCOGS() { return formattedTotalCOGS; }
        public String getFormattedCOGSPerUnit() { return formattedCOGSPerUnit; }
        public String getFormattedSellingPrice() { return formattedSellingPrice; }
        public String getFormattedGrossProfit() { return formattedGrossProfit; }
    }
    
    /**
     * Menghitung COGS dan Harga Jual berdasarkan business rules
     * 
     * @param initialInventory Nilai inventory awal
     * @param netPurchases Net purchases (purchases + freight - returns)
     * @param finalInventory Nilai inventory akhir
     * @param totalQuantity Total quantity yang terjual
     * @param targetMargin Target margin dalam decimal (contoh: 0.20 untuk 20%)
     * @return PricingResult yang berisi semua hasil perhitungan
     * @throws IllegalArgumentException jika parameter tidak valid
     */
    public static PricingResult calculatePricing(
            double initialInventory,
            double netPurchases,
            double finalInventory,
            double totalQuantity,
            double targetMargin) {
        
        // Validasi input
        validateInputs(initialInventory, netPurchases, finalInventory, totalQuantity, targetMargin);
        
        // Hitung Total COGS
        // Formula: COGS = Initial Inventory + Net Purchases - Final Inventory
        BigDecimal initialInv = BigDecimal.valueOf(initialInventory);
        BigDecimal netPurch = BigDecimal.valueOf(netPurchases);
        BigDecimal finalInv = BigDecimal.valueOf(finalInventory);
        
        BigDecimal totalCOGS = initialInv
            .add(netPurch)
            .subtract(finalInv)
            .setScale(2, RoundingMode.HALF_UP);
        
        // Validasi: Total COGS tidak boleh negatif
        if (totalCOGS.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Total COGS tidak boleh negatif. Periksa nilai inventory dan purchases.");
        }
        
        // Hitung COGS per Unit
        // Formula: COGS per Unit = Total COGS / Total Quantity
        BigDecimal quantity = BigDecimal.valueOf(totalQuantity);
        BigDecimal cogsPerUnit;
        
        if (quantity.compareTo(BigDecimal.ZERO) == 0) {
            // Edge case: division by zero
            throw new IllegalArgumentException("Total Quantity tidak boleh 0. Tidak dapat menghitung COGS per unit.");
        }
        
        cogsPerUnit = totalCOGS
            .divide(quantity, 2, RoundingMode.HALF_UP)
            .setScale(2, RoundingMode.HALF_UP);
        
        // Hitung Suggested Selling Price menggunakan Margin Pricing
        // Formula: Price = COGS_per_Unit / (1 - Desired_Margin_Percentage)
        BigDecimal margin = BigDecimal.valueOf(targetMargin);
        BigDecimal oneMinusMargin = BigDecimal.ONE.subtract(margin);
        
        if (oneMinusMargin.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Margin tidak boleh 1 (100%) atau lebih. Ini akan menghasilkan harga tak terhingga.");
        }
        
        BigDecimal suggestedSellingPrice = cogsPerUnit
            .divide(oneMinusMargin, 2, RoundingMode.HALF_UP)
            .setScale(0, RoundingMode.UP); // Round up untuk harga jual
        
        // Hitung Gross Profit per Unit
        // Gross Profit = Selling Price - COGS per Unit
        BigDecimal grossProfitPerUnit = suggestedSellingPrice
            .subtract(cogsPerUnit)
            .setScale(2, RoundingMode.HALF_UP);
        
        return new PricingResult(
            totalCOGS,
            cogsPerUnit,
            suggestedSellingPrice,
            grossProfitPerUnit
        );
    }
    
    /**
     * Validasi input parameters
     */
    private static void validateInputs(
            double initialInventory,
            double netPurchases,
            double finalInventory,
            double totalQuantity,
            double targetMargin) {
        
        if (initialInventory < 0) {
            throw new IllegalArgumentException("Initial Inventory tidak boleh negatif.");
        }
        
        if (netPurchases < 0) {
            throw new IllegalArgumentException("Net Purchases tidak boleh negatif.");
        }
        
        if (finalInventory < 0) {
            throw new IllegalArgumentException("Final Inventory tidak boleh negatif.");
        }
        
        if (totalQuantity < 0) {
            throw new IllegalArgumentException("Total Quantity tidak boleh negatif.");
        }
        
        if (targetMargin < 0) {
            throw new IllegalArgumentException("Target Margin tidak boleh negatif.");
        }
        
        if (targetMargin >= 1.0) {
            throw new IllegalArgumentException("Target Margin tidak boleh 1 (100%) atau lebih. Gunakan nilai antara 0 dan 1 (contoh: 0.20 untuk 20%).");
        }
    }
    
    /**
     * Helper method untuk convert margin percentage ke decimal
     * Contoh: 20 -> 0.20
     */
    public static double marginPercentageToDecimal(double marginPercentage) {
        if (marginPercentage < 0 || marginPercentage >= 100) {
            throw new IllegalArgumentException("Margin percentage harus antara 0 dan 100.");
        }
        return marginPercentage / 100.0;
    }
    
    /**
     * Helper method untuk format currency IDR
     */
    public static String formatIDR(double amount) {
        DecimalFormat idrFormat = new DecimalFormat("#,###", 
            new DecimalFormatSymbols(Locale.ITALIAN));
        idrFormat.setRoundingMode(RoundingMode.UP);
        return "Rp " + idrFormat.format(amount);
    }
    
    /**
     * Test method untuk demonstrasi
     */
    public static void main(String[] args) {
        try {
            // Contoh penggunaan
            double initialInventory = 1000000.0;  // Rp 1.000.000
            double netPurchases = 5000000.0;      // Rp 5.000.000
            double finalInventory = 2000000.0;   // Rp 2.000.000
            double totalQuantity = 100.0;        // 100 unit
            double targetMargin = 0.20;          // 20% margin
            
            PricingResult result = calculatePricing(
                initialInventory,
                netPurchases,
                finalInventory,
                totalQuantity,
                targetMargin
            );
            
            System.out.println("=== HASIL PERHITUNGAN PRICING ===");
            System.out.println("Total COGS: " + result.getFormattedTotalCOGS());
            System.out.println("COGS per Unit: " + result.getFormattedCOGSPerUnit());
            System.out.println("Suggested Selling Price: " + result.getFormattedSellingPrice());
            System.out.println("Gross Profit per Unit: " + result.getFormattedGrossProfit());
            System.out.println("\n=== DETAIL NUMERIK ===");
            System.out.println("Total COGS: " + result.getTotalCOGS());
            System.out.println("COGS per Unit: " + result.getCogsPerUnit());
            System.out.println("Selling Price: " + result.getSuggestedSellingPrice());
            System.out.println("Gross Profit: " + result.getGrossProfitPerUnit());
            
        } catch (IllegalArgumentException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}

