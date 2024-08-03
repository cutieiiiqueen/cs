package uuu.cs.service;

import java.util.List;
import java.util.Set;

import uuu.cs.entity.Product;
import uuu.cs.exception.CSException;

public class TrackService {
	private TrackDAO dao = new TrackDAO();
	
	//查詢追蹤清單
	public List<Product> getTrackedProducts(String email) throws CSException {
		if(email==null || email.isEmpty()) throw new IllegalArgumentException("查詢追蹤清單必須有email!");
		return dao.selectTrackedProducts(email);
	}
	
	//加入追蹤
	public void addTrackedProduct(String email, int productId) throws CSException {
		if(email==null || email.isEmpty()) throw new IllegalArgumentException("查詢追蹤清單,會員email不得為null!");
		if(productId==0) throw new IllegalArgumentException("查詢追蹤清單,productId不得為0!");
		dao.insertTrackedProduct(email, productId);
	}
	
	//移除追蹤
	public void removeTrackedProduct(String email, int productId) throws CSException {
		if(email==null || email.isEmpty()) throw new IllegalArgumentException("移除追蹤產品,會員email不得為null!");
		if(productId==0) throw new IllegalArgumentException("移除追蹤產品,productId不得為0!");
		dao.deleteTrackedProduct(email, productId);
	}
	
	//查詢會員所追蹤的產品id
	public Set<Integer> getTrackedProductIds(String email) throws CSException {
        return dao.selectTrackedProductIds(email);
    }

}