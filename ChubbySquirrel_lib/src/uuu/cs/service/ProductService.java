package uuu.cs.service;

import java.util.List;

import uuu.cs.entity.Product;
import uuu.cs.exception.CSException;

public class ProductService {

		private ProductsDAO dao = new ProductsDAO();
		
		public List<Product> getAllProducts() throws CSException{
			return dao.selectAllProducts();
		}
		
		public List<Product> getProductsByCategory (String category) throws CSException{
			if(category==null || category.length()==0) { 
				throw new IllegalArgumentException("依分類查詢產品，category必須有值");
			}
			return dao.selectProductsByCategory(category);
		}
		
		public List<Product> getProductsByKeyword (String keyword) throws CSException{
			if(keyword==null || keyword.length()==0) {
				throw new IllegalArgumentException("依關鍵字查詢產品，keyword必須有值");
			}
			return dao.selectProductsByKeyword(keyword);
		}
		public List<Product> getNewestProducts()throws CSException{
			return dao.selectNewestProducts();
		}
		public List<Product> getProductByPriceInRange(String minPrice,String maxPrice)throws CSException{
			return dao.SelectProductsByPriceInRange(minPrice, maxPrice);
		}
		
		public Product getProductById(String id) throws CSException {
			return dao.selectProductById(id);
		}
		
		public int getStockByProductIdSpecName(int productId, String specName) throws CSException{
			if(productId<=0) throw new IllegalArgumentException("查詢庫存必須有productId");
			if(specName==null) specName = "";
			
			return dao.selectStockByProductIdSpecName(productId, specName);
		}
}
