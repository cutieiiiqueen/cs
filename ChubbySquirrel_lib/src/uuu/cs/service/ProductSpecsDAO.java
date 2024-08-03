package uuu.cs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import uuu.cs.entity.Product;
import uuu.cs.entity.Spec;
import uuu.cs.entity.SpecialOffer;
import uuu.cs.exception.CSException;

class ProductSpecsDAO {
	private static final String INSERT_PRODUCT_SPECS = "INSERT INTO product_specs (product_id, spec_name, unit_price, stock, photo_url) VALUES (?, ?, ?, ?, ?)";

	void addProductSpecs(Spec spec) throws CSException {
		try (Connection connection = MySQLConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(INSERT_PRODUCT_SPECS)) {

			pstmt.setInt(1, spec.getProductId());
			pstmt.setString(2, spec.getSpecName());
			pstmt.setDouble(3, spec.getListPrice());
			pstmt.setInt(4, spec.getStock());
			pstmt.setString(5, spec.getPhotoUrl());


			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CSException("更新失敗", e);
		}
	}

	private static final String SELECT_PRODUCT_SPECS_BY_ID = "SELECT * FROM  product_specs WHERE product_id=?";

	public List<Spec> selectByProductId(int productId) throws CSException {
		List<Spec> list = new ArrayList<>();
		try (Connection connection = MySQLConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_SPECS_BY_ID)) {
			pstmt.setInt(1, productId);
			try (ResultSet rs = pstmt.executeQuery(); // 4. 執行SELECT指令，獲取結果集
			) {
				// 5.讀取rs
				while (rs.next()) { // 資料庫查詢不確定會查詢到幾筆, 所以用while(0-多)
					Spec s = new Spec();

					// 從資料庫讀取資料後給s物件回傳
					s.setProductId(productId);
					s.setSpecName(rs.getString("spec_name"));
					s.setListPrice(rs.getDouble("unit_price"));
					;
					s.setStock(rs.getInt("stock"));
					s.setPhotoUrl(rs.getString("photo_url"));

					list.add(s); // 將p物件添加到列表中
				}
			}
		} catch (SQLException e) {
			throw new CSException("更新失敗", e);
		}
		return list;
	}

	private static final String UPDATE_SPECS = "UPDATE product_specs SET unit_price=? ,stock=?,  photo_url=? WHERE product_id=? and spec_name=?";

	void updateSpec(Spec spec) throws CSException {
		try (
				Connection connection = MySQLConnection.getConnection(); //1.2.建立連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_SPECS) //3.準備指令
				) {
			
				//3.1傳入?的值
				pstmt.setDouble(1, spec.getListPrice());
				pstmt.setInt(2, spec.getStock());
				pstmt.setString(3, spec.getPhotoUrl());
				pstmt.setInt(4, spec.getProductId());
				pstmt.setString(5, spec.getSpecName());
				
				//4.執行指令
				pstmt.executeUpdate();
				
		} catch (SQLException e) {
			throw new CSException("更新[產品規格]失敗", e);
		}
	}
}
