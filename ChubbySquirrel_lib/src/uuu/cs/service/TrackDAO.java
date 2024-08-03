package uuu.cs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import uuu.cs.entity.Product;
import uuu.cs.entity.SpecialOffer;
import uuu.cs.exception.CSException;

public class TrackDAO {
	
	//查詢顧客已追蹤的商品列表
	private static final String SELECT_TRACKED_PRODUCTS = "SELECT p.id, p.name, p.category, p.unit_price, "
			+ "p.stock, p.release_date, p.photo_url, p.description, p.discount FROM products_list_view p "
			+ "JOIN tracked_products t ON p.id = t.product_id WHERE t.customer_email = ?";

	public List<Product> selectTrackedProducts(String email) throws CSException {
		List<Product> list = new ArrayList<>();
		try (
				Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_TRACKED_PRODUCTS); //3.準備指令
				) {
			
				//3.1傳入?值
				pstmt.setString(1, email);
				
			try (
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
					) {
				
					//5.處理rs
					while (rs.next()) {
						Product p;
						int discount = rs.getInt("discount");
						if (discount == 0) {
							p = new Product();
						} else {
							p = new SpecialOffer();
							((SpecialOffer) p).setDiscount(discount);
						}
						p.setId(rs.getInt("id"));
						p.setName(rs.getString("name"));
						p.setCategory(rs.getString("category"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setStock(rs.getInt("stock"));
						p.setReleaseDate(rs.getString("release_date"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setDescription(rs.getString("description"));
						
						list.add(p);
					}
			}
		} catch (SQLException e) {
			throw new CSException("查詢追蹤清單失敗", e);
		}
		return list;
	}
	
	private static final String INSERT_TRACKED_PRODUCT = "INSERT INTO tracked_products (customer_email, product_id) VALUES (?, ?)";

	public void insertTrackedProduct(String email, int productId) throws CSException {
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
				PreparedStatement pstmt = connection.prepareStatement(INSERT_TRACKED_PRODUCT); //3.準備指令
				){
			
				//3.1傳入?的值
				pstmt.setString(1, email);
				pstmt.setInt(2, productId);
				
				//4.執行指令
				pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new CSException("新增追蹤失敗", e);
		}
	}
	
	//移除追蹤
	private static final String DELETE_TRACKED_PRODUCT = "DELETE FROM tracked_products WHERE customer_email = ? AND product_id = ?";
	
	public void deleteTrackedProduct(String email, int productId) throws CSException {
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
				PreparedStatement pstmt = connection.prepareStatement(DELETE_TRACKED_PRODUCT); //3.準備指令
				){
			
				//3.1傳入?的值
				pstmt.setString(1, email);			
				pstmt.setInt(2, productId);
				
				//4.執行指令
				pstmt.executeUpdate();
				
		} catch (SQLException e) {
			throw new CSException("移除追蹤失敗", e);
		}
	}
	
	//查詢會員所追蹤的產品id
	private static final String SELECT_TRACKED_PRODUCT_ID = "SELECT product_id FROM tracked_products WHERE customer_email = ?";
	
	public Set<Integer> selectTrackedProductIds(String email) throws CSException {
		
		Set<Integer> set = new HashSet<>();
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1.&2.建立連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_TRACKED_PRODUCT_ID) //3.準備指令
				){
			
				//3.1傳入?的值
				pstmt.setString(1, email);
				
				//4.執行指令
			try ( ResultSet rs = pstmt.executeQuery() ) {
				
				//5.處理rs
				while (rs.next()) {
					set.add(rs.getInt("product_id"));
				}
			}
		} catch (SQLException e) {
			throw new CSException("查詢追蹤清單失敗", e);
		}
		return set;
	}
}