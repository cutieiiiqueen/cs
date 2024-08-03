package uuu.cs.test;

import uuu.cs.entity.Product;

public class TestProductMemory {
	public static void main(String[] args) {
		
	
	Product p2 = new Product(2, "招牌綜合堅果", 250, 5);
	p2.setCategory("堅果");
	p2.setPhotoUrl("");
	p2.setDescription("");
	p2.setReleaseDate("2024-03-29");
	
	System.out.printf("p2.id:%s\n",p2.getId());
	System.out.printf("p2.name:%s\n",p2.getName());
	System.out.printf("p2.unitPrice:%s\n",p2.getUnitPrice());
	System.out.printf("p2.stock:%s\n",p2.getStock());
	System.out.printf("p2.category:%s\n",p2.getCategory());
	System.out.printf("p2.photoUrl:%s\n",p2.getPhotoUrl());
	System.out.printf("p2.description:%s\n",p2.getDescription());
	System.out.printf("p2.releaseDate:%s\n",p2.getReleaseDate());
	
	ProductUtility.addPrice(p2.getUnitPrice());
	System.out.println(p2.getUnitPrice());
	
	ProductUtility.addPrice(p2);
	System.out.println(p2.getUnitPrice());
	
	}
}
/**
 * 測試用類別，寄生在TestProductMemory.java
 */

class ProductUtility{
	
	public static void addPrice(double price) { //基本型別
		price = price+100;
	}
	
	public static void addPrice(Product p) { //參考型別
		double price = p.getUnitPrice();
		price = price+100;
		p.setUnitPrice(price);
	}
}