package uuu.cs.test;

import uuu.cs.entity.Product;

public class TestProdut {
	public static void main(String[] args) {
		Product p = new Product();
		p.setId(1);
		p.setName("經典綜合堅果");
		p.setCategory("堅果");
		p.setPhotoUrl("");
		p.setUnitPrice(250);
		p.setStock(5);
		p.setDescription("");
		p.setReleaseDate("2024/04/15");
		
//		System.out.printf("p.id:%s\n",p.getId());
//		System.out.printf("p.name:%s\n",p.getName());
//		System.out.printf("p.unitPrice:%s\n",p.getUnitPrice());
//		System.out.printf("p.stock:%s\n",p.getStock());
//		System.out.printf("p.category:%s\n",p.getCategory());
//		System.out.printf("p.photoUrl:%s\n",p.getPhotoUrl());
//		System.out.printf("p.description:%s\n",p.getDescription());
//		System.out.printf("p.releaseDate:%s\n",p.getReleaseDate());
		
		System.out.printf("p:%s\n",p);
		
		Product p2 = new Product(2, "招牌綜合堅果", 250, 5);
		p2.setCategory("堅果");
		p2.setPhotoUrl("");
		p2.setDescription("");
		p2.setReleaseDate("2024-03-29");
		
//		System.out.printf("p2.id:%s\n",p2.getId());
//		System.out.printf("p2.name:%s\n",p2.getName());
//		System.out.printf("p2.unitPrice:%s\n",p2.getUnitPrice());
//		System.out.printf("p2.stock:%s\n",p2.getStock());
//		System.out.printf("p2.category:%s\n",p2.getCategory());
//		System.out.printf("p2.photoUrl:%s\n",p2.getPhotoUrl());
//		System.out.printf("p2.description:%s\n",p2.getDescription());
//		System.out.printf("p2.releaseDate:%s\n",p2.getReleaseDate());
		System.out.printf("p2:%s\n",p2);
	}

}
