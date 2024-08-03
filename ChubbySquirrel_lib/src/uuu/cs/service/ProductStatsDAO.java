package uuu.cs.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import uuu.cs.entity.ProductStats;
import uuu.cs.exception.CSException;

class ProductStatsDAO {
	
	//查詢當年度某月份產品銷售量
	private static final String SELECT_PRODUCT_STATS_MONTH = "SELECT products.name,order_items.spec_name, SUM(quantity) AS total_quantity " 
			+ "FROM cs.order_items "
			+ "JOIN cs.products ON order_items.product_id = products.id "
			+ "JOIN cs.orders ON order_items.order_id = orders.id " 
			//月份查詢
			+ "WHERE MONTH(orders.created_date) = ? "
			//設定為該年度
			+ "AND YEAR(orders.created_date) = YEAR(CURDATE()) " 
			+ "GROUP BY product_id,spec_name "
			+ "order by SUM(quantity) desc";
	
	ProductStats selectProductStatsMonth(int month) throws CSException {

		List<String> productNames = new ArrayList<>();
		List<Integer> quantities = new ArrayList<>();

		try (
				Connection connection = MySQLConnection.getConnection(); //1.&2.載入Driver並取得連線	
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_STATS_MONTH)  //3.準備指令
				) {
			
				//3.1傳入?的值
				pstmt.setInt(1, month);
				
				try (ResultSet rs = pstmt.executeQuery(); ) { //4.執行SELECT指令
						
					//5.讀取rs
					while (rs.next()) {
						productNames.add(rs.getString("name") + " " + rs.getString("spec_name"));
						quantities.add(rs.getInt("total_quantity"));
					}
				}
				
		} catch (SQLException e) {
			throw new CSException("[查詢當年度某月份的產品銷售量]失敗",e);
		}
		return new ProductStats(productNames, quantities);
	}
}
