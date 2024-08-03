package uuu.cs.entity;

import java.util.List;

public class ProductStats {
	
	private List<String> productNames;
    private List<Integer> quantities;

    public ProductStats(List<String> productNames, List<Integer> quantities) {
        this.productNames = productNames;
        this.quantities = quantities;
    }

    public List<String> getProductNames() {
        return productNames;
    }

    public List<Integer> getQuantities() {
        return quantities;
    }
}
