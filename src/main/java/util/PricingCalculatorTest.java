package util;

/**
 * Test class untuk PricingCalculator
 * Menjalankan berbagai test case termasuk edge cases
 */
public class PricingCalculatorTest {
    
    public static void main(String[] args) {
        System.out.println("=== TESTING PRICING CALCULATOR ===\n");
        
        // Test 1: Normal case
        testNormalCase();
        
        // Test 2: Edge case - Zero quantity
        testZeroQuantity();
        
        // Test 3: Edge case - Margin = 1 (100%)
        testMarginOne();
        
        // Test 4: Edge case - Negative values
        testNegativeValues();
        
        // Test 5: Edge case - High margin
        testHighMargin();
        
        // Test 6: Real-world example
        testRealWorldExample();
        
        System.out.println("\n=== SEMUA TEST SELESAI ===");
    }
    
    private static void testNormalCase() {
        System.out.println("Test 1: Normal Case");
        try {
            PricingCalculator.PricingResult result = PricingCalculator.calculatePricing(
                1000000,  // Initial Inventory
                5000000,  // Net Purchases
                2000000,  // Final Inventory
                100,      // Total Quantity
                0.20      // 20% margin
            );
            
            System.out.println("  ✓ Total COGS: " + result.getFormattedTotalCOGS());
            System.out.println("  ✓ COGS per Unit: " + result.getFormattedCOGSPerUnit());
            System.out.println("  ✓ Selling Price: " + result.getFormattedSellingPrice());
            System.out.println("  ✓ Gross Profit: " + result.getFormattedGrossProfit());
            System.out.println("  Expected COGS: Rp 4.000.000 (1M + 5M - 2M)");
            System.out.println("  Expected COGS/Unit: Rp 40.000 (4M / 100)");
            System.out.println("  Expected Price: Rp 50.000 (40.000 / 0.8)\n");
        } catch (Exception e) {
            System.out.println("  ✗ Error: " + e.getMessage() + "\n");
        }
    }
    
    private static void testZeroQuantity() {
        System.out.println("Test 2: Edge Case - Zero Quantity");
        try {
            PricingCalculator.PricingResult result = PricingCalculator.calculatePricing(
                1000000,
                5000000,
                2000000,
                0,        // Zero quantity - should throw error
                0.20
            );
            System.out.println("  ✗ Should have thrown exception but didn't\n");
        } catch (IllegalArgumentException e) {
            System.out.println("  ✓ Correctly caught error: " + e.getMessage() + "\n");
        }
    }
    
    private static void testMarginOne() {
        System.out.println("Test 3: Edge Case - Margin = 1 (100%)");
        try {
            PricingCalculator.PricingResult result = PricingCalculator.calculatePricing(
                1000000,
                5000000,
                2000000,
                100,
                1.0       // 100% margin - should throw error
            );
            System.out.println("  ✗ Should have thrown exception but didn't\n");
        } catch (IllegalArgumentException e) {
            System.out.println("  ✓ Correctly caught error: " + e.getMessage() + "\n");
        }
    }
    
    private static void testNegativeValues() {
        System.out.println("Test 4: Edge Case - Negative Values");
        try {
            PricingCalculator.PricingResult result = PricingCalculator.calculatePricing(
                -1000000,  // Negative - should throw error
                5000000,
                2000000,
                100,
                0.20
            );
            System.out.println("  ✗ Should have thrown exception but didn't\n");
        } catch (IllegalArgumentException e) {
            System.out.println("  ✓ Correctly caught error: " + e.getMessage() + "\n");
        }
    }
    
    private static void testHighMargin() {
        System.out.println("Test 5: Edge Case - High Margin (99%)");
        try {
            PricingCalculator.PricingResult result = PricingCalculator.calculatePricing(
                1000000,
                5000000,
                2000000,
                100,
                0.99      // 99% margin - very high but valid
            );
            System.out.println("  ✓ Total COGS: " + result.getFormattedTotalCOGS());
            System.out.println("  ✓ COGS per Unit: " + result.getFormattedCOGSPerUnit());
            System.out.println("  ✓ Selling Price: " + result.getFormattedSellingPrice());
            System.out.println("  ✓ Gross Profit: " + result.getFormattedGrossProfit());
            System.out.println("  Note: Price akan sangat tinggi dengan margin 99%\n");
        } catch (Exception e) {
            System.out.println("  ✗ Error: " + e.getMessage() + "\n");
        }
    }
    
    private static void testRealWorldExample() {
        System.out.println("Test 6: Real-World Example (Menu: Nasi Kebuli)");
        try {
            // Simulasi: Inventory awal, pembelian bahan, inventory akhir
            double initialInventory = 500000;   // Rp 500.000 (bahan awal)
            double netPurchases = 2000000;      // Rp 2.000.000 (pembelian bersih)
            double finalInventory = 300000;     // Rp 300.000 (sisa bahan)
            double totalQuantity = 50;          // 50 porsi dihasilkan
            double targetMargin = 0.30;         // 30% margin
            
            PricingCalculator.PricingResult result = PricingCalculator.calculatePricing(
                initialInventory,
                netPurchases,
                finalInventory,
                totalQuantity,
                targetMargin
            );
            
            System.out.println("  Input:");
            System.out.println("    Initial Inventory: Rp 500.000");
            System.out.println("    Net Purchases: Rp 2.000.000");
            System.out.println("    Final Inventory: Rp 300.000");
            System.out.println("    Total Quantity: 50 porsi");
            System.out.println("    Target Margin: 30%");
            System.out.println("  Output:");
            System.out.println("    ✓ Total COGS: " + result.getFormattedTotalCOGS());
            System.out.println("    ✓ COGS per Unit: " + result.getFormattedCOGSPerUnit());
            System.out.println("    ✓ Suggested Selling Price: " + result.getFormattedSellingPrice());
            System.out.println("    ✓ Gross Profit per Unit: " + result.getFormattedGrossProfit());
            System.out.println("  Calculation:");
            System.out.println("    Total COGS = 500.000 + 2.000.000 - 300.000 = Rp 2.200.000");
            System.out.println("    COGS/Unit = 2.200.000 / 50 = Rp 44.000");
            System.out.println("    Selling Price = 44.000 / (1 - 0.30) = 44.000 / 0.70 = Rp 62.857");
            System.out.println("    Gross Profit = 62.857 - 44.000 = Rp 18.857\n");
        } catch (Exception e) {
            System.out.println("  ✗ Error: " + e.getMessage() + "\n");
        }
    }
}

