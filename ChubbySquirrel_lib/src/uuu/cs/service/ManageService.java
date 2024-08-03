package uuu.cs.service;

import java.sql.SQLException;
import java.util.List;

import uuu.cs.entity.Customer;
import uuu.cs.entity.Order;
import uuu.cs.entity.Product;
import uuu.cs.entity.ProductStats;
import uuu.cs.entity.Spec;
import uuu.cs.entity.SpecialOffer;
import uuu.cs.entity.VIP;
import uuu.cs.exception.CSException;

public class ManageService {

	private OrdersDAO orderDao = new OrdersDAO();

	private CustomersDAO customersDao = new CustomersDAO();

	private ProductSpecsDAO productsSpecsDAO = new ProductSpecsDAO();
	
	private ProductStatsDAO productStatsDAO = new ProductStatsDAO();
	
	private ProductsDAO productsDAO = new ProductsDAO();
	
	//查詢當年度指定月份產品銷售量
	public ProductStats getProductStatsMonth(int month) throws SQLException, CSException {
		return productStatsDAO.selectProductStatsMonth(month);
	}
	
	//查詢所有訂單
	public List<Order> getAllOrder() throws CSException {
		return orderDao.selectOrders();
	}
	
	//更新訂單狀態
	public void updateOrderStatus(int orderId, int status, String paymentNote, String shippingNote) throws CSException {
		if(orderId==0) throw new IllegalArgumentException("更新訂單狀態時，訂單id不得為0!");
		if(status==0) throw new IllegalArgumentException("更新訂單狀態時，訂單狀態不得為0!");
		orderDao.updateOrderStatus(orderId, status,paymentNote, shippingNote);
	}

	public List<VIP> getAllCustomers() throws CSException {
		return customersDao.selectAllCustomer();
	}

	public void updateCustomer(VIP updatedCustomer) throws CSException {
		customersDao.updateCustomer(updatedCustomer);
	}

	public void deleteCustomer(String email) throws CSException {
		customersDao.delete(email);
	}
	
	//後台查詢產品
	public List<Product> getProducts() throws CSException {
		return productsDAO.selectAllProducts();
	}
	
	//後台查詢產品規格
	public List<Spec> getSpecs(int productId) throws CSException {
		if(productId==0) throw new IllegalArgumentException("查詢產品規格時，產品id不得為0!");
		return productsSpecsDAO.selectByProductId(productId);
	}
	
	//後台新增產品
	public void addProduct(Product product) throws CSException {
		if(product==null) throw new IllegalArgumentException("新增產品時，產品不得為null!");
		productsDAO.insertProduct(product);
	}
	//查詢產品id給新增產品用
	public int selectProductId(String name) throws CSException {
		if(name==null || name.length()==0) throw new IllegalArgumentException("查詢產品id時，產品名稱不得為null!");
		return productsDAO.selectProductId(name);
	}
	//設置photoUrl給新增產品用
	public void UpdatePhotoUrl(String photourl, int productId) throws CSException {
		if(productId==0 )	throw new IllegalArgumentException("更新產品圖片時，產品id不得為0!");
		if(photourl==null || photourl.length()==0 )	throw new IllegalArgumentException("更新產品圖片時，photoUrl不得為null!");
		productsDAO.UpdatePhotoUrl(photourl, productId);
	}
	
	//後台新增規格
	public void addSpec(Spec spec) throws CSException {
		if(spec==null) throw new IllegalArgumentException("新增產品規格時，規格不得為null!");
		productsSpecsDAO.addProductSpecs(spec);
	}

	//後台更新產品
	public void updateProduct(SpecialOffer product) throws CSException {
		if(product==null) throw new IllegalArgumentException("更新產品時，產品不得為null!");
		productsDAO.updateProduct(product);
	}
	
	//後台更新產品規格
	public void updateSpec(Spec spec) throws CSException {
		if(spec==null) throw new IllegalArgumentException("更新產品規格時，規格不得為null!");
		productsSpecsDAO.updateSpec(spec);
	}
	
	//後台刪除產品
	public void deleteProduct(int id) throws CSException {
		if(id==0) throw new IllegalArgumentException("刪除產品時，產品id不得為0!");
		productsDAO.deleteProduct(id);
	}
	
	//後台更新產品狀態
	public void updateStatus(String productId, String status) throws CSException {
		if(productId==null || productId.length()==0 ) throw new IllegalArgumentException("更新產品狀態時，產品id不得為null!");
		if(status==null || status.length()==0 )	throw new IllegalArgumentException("更新產品狀態時，狀態不得為null!");
		productsDAO.updateStatus(productId, status);
		
	}

}
