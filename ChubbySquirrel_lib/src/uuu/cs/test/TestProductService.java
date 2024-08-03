package uuu.cs.test;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.cs.entity.Product;
import uuu.cs.exception.CSDataInvalidException;
import uuu.cs.exception.CSException;
import uuu.cs.service.ProductService;

public class TestProductService {

		public static void main(String[] args) {
			ProductService pService = new ProductService();
			try {
				List<Product> list1 = pService.getAllProducts();
				List<Product> list2 = pService.getProductsByCategory("書籍");
				List<Product> list3 = pService.getProductsByKeyword("爆米香");
				List<Product> list4 = pService.getNewestProducts();
				List<Product> list5 = pService.getProductByPriceInRange("100", "200");

//				System.out.println(list1);
//				System.out.println(list2);
				//System.out.println(list3);
//				System.out.println(list4);
//				System.out.println(list5);
				
				Product p = pService.getProductById("18");
				System.out.println(p);
				
			}catch(CSException e){
				Logger.getLogger("測試E04產品查詢").log(Level.SEVERE, e.getMessage(),e); //for developer, admin, tester
				System.err.println(e.getMessage()+", 請聯絡系統管理人員(Admin)"); //for user
			}catch(CSDataInvalidException e) {
				System.err.println(e.getMessage() + ", 請修改資料");//for user 
			}catch(Exception e) {
				Logger.getLogger("系統發生錯誤").log(Level.SEVERE, "系統發生非預期錯誤",e); //for developer, admin, tester
				System.err.println(e.getMessage()+", 請聯絡系統管理人員(Admin)"); //for user
			}
		}
}
