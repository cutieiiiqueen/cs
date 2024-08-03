package uuu.cs.test;

import uuu.cs.entity.Product;
import uuu.cs.entity.SpecialOffer;

public class TestSpecialOffer {
	public static void main(String[] args) {
//		SpecialOffer specialOffer = new SpecialOffer();
//		specialOffer.setId(3);
//		specialOffer.setName("腰果");
//		specialOffer.setCategory("堅果");
//		specialOffer.setPhotoUrl("");
//		specialOffer.setUnitPrice(200);
//		specialOffer.setStock(10);
//		specialOffer.setDescription("");
//		specialOffer.setReleaseDate("2024-04-01");
//		specialOffer.setDiscount(5);
		
		SpecialOffer specialOffer = new SpecialOffer(1,"堅果",200,5);
		
//		System.out.printf("特價品的id:%s\n",specialOffer.getId());
//		System.out.printf("特價品的產品名稱:%s\n",specialOffer.getName());
//		System.out.printf("特價品的定價:%s\n",specialOffer.getListPrice());
//		System.out.printf("特價品的庫存:%s\n",specialOffer.getStock());
//		System.out.printf("特價品的分類:%s\n",specialOffer.getCategory());
//		System.out.printf("特價品的photoUrl:%s\n",specialOffer.getPhotoUrl());
//		System.out.printf("特價品的描述:%s\n",specialOffer.getDescription());
//		System.out.printf("特價品的上架日期:%s\n",specialOffer.getReleaseDate());
//		System.out.printf("特價品的折扣:%s%% off\n", specialOffer.getDiscount());
//		System.out.printf("特價品優惠價:%s, %s元\n",specialOffer.getDiscountString(),specialOffer.getUnitPrice());
		System.out.println(specialOffer.toString());
		
		Product p = specialOffer; //Polymorphism區域變數
//		System.out.printf("特價品的%s, %s優惠\n",p.getName(),
//				specialOffer instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"無折扣");
		if(p instanceof SpecialOffer) {
			System.out.printf("特價品優惠價:%s, %s元\n",specialOffer.getDiscountString(),specialOffer.getUnitPrice());
		} else {
			System.out.printf("特價品優惠價:%s, %s元\n",p.getName(),"無折扣");			
		}
		
	
	}

}
