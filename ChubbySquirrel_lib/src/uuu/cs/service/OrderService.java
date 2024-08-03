package uuu.cs.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import uuu.cs.entity.Customer;
import uuu.cs.entity.Order;
import uuu.cs.entity.OrderStatusLog;
import uuu.cs.exception.CSException;
import uuu.cs.exception.CSException;

public class OrderService {
	
	private OrdersDAO dao = new OrdersDAO();
	
	public void checkOut(Order order) throws CSException{
		if(order == null) throw new IllegalArgumentException("建立訂單時order物件不得為null");
		System.out.println(order);
		dao.insert(order);
	}
	
	public List<Order> getOrdersHistory(Customer member, String range) throws CSException{
		if(member == null) throw new IllegalArgumentException("查詢歷史訂單時member物件不得為null");
		int rangeNumber = 1; //預設rangeNumber是1
		//如果前端傳來的range不是null=而且符合2或6就將數字轉為int存進rangeNumber
		if(range!=null && range.matches("[26]")) { 
			rangeNumber = Integer.parseInt(range);
		}
		//將2年轉換成24個月
		if(rangeNumber==2) rangeNumber=24;
		return dao.selectOrdersHistory(member.getEmail(), rangeNumber);
	}
	
	public Order getOrderById(Customer member, String orderId) throws CSException {
		return dao.selectOrderById(member.getEmail(), orderId);
	}
	
	public void updateStatusToTransfered(Customer member, String orderId, String bank, String last5, double amount,
			LocalDate TransferedDate, String TransferedTime) throws CSException{
		if(member==null || orderId==null || !orderId.matches("\\d+")) {
			throw new IllegalArgumentException("通知轉帳時，member|orderId不得為null");
		}
		
		StringBuilder paymentNote = new StringBuilder();
		paymentNote.append(bank).append(", ").append(last5);
		paymentNote.append(", 轉帳金額:").append(amount);
		paymentNote.append(", 轉帳時間約:").append(TransferedDate).append("").append(TransferedTime);
		
		dao.updateStatusToTransfered(member.getEmail(), Integer.parseInt(orderId), paymentNote.toString());	
	}
	
	public List<OrderStatusLog> getOrderStatusLog(String orderId)//記得要import OrderStatusLog
	        throws CSException{
	    return dao.selecOrderStatusLog(orderId);
	}
	
	/**
	 * 提供信用卡刷卡完成後的訂單狀態修改與相關資訊紀錄(卡號、授權碼)
	 * @param member
	 * @param orderId
	 * @param cardF6
	 * @param cardL4
	 * @param auth 授權碼
	 * @param paymentDate
	 * @param amount
	 * @throws VGBException
	 */
	public void updateOrderStatusToPAID(Customer member,String orderId, String cardF6, String cardL4,
            String auth, String paymentDate, String amount) throws CSException {
      StringBuilder paymentNote = new StringBuilder("信用卡號:");
      paymentNote.append(cardF6==null?"4311-95":cardF6).append("**-****").append(cardL4==null?2222:cardL4);
      paymentNote.append(",授權碼:").append(auth==null?"777777":auth);
      paymentNote.append(",交易時間:").append(paymentDate==null?LocalDateTime.now():paymentDate); //必須import java.time.LocalDateTime      
//    paymentNote.append(",刷卡金額:").append(amount);
      System.out.println("orderId = " + orderId);
      System.out.println("memberId = " + member.getEmail());
      System.out.println("paymentNote = " + paymentNote);
      dao.updateOrderStatusToPAID(member.getEmail(), Integer.parseInt(orderId), paymentNote.toString());
	}
}
