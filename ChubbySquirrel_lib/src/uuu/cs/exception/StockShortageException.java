package uuu.cs.exception;

import uuu.cs.entity.OrderItem;

public class StockShortageException extends CSException {
	private final OrderItem orderItem; //必要

	public StockShortageException(OrderItem orderItem) {
		this("庫存不足",orderItem);		
	}

	public StockShortageException(String message, OrderItem orderItem) {
		super(message);
		this.orderItem = orderItem;
	}

	public OrderItem getOrderItem() {
		return orderItem;
	}

	@Override
	public String toString() {
		String msg = String.format("%s:%s-%s 購買數量%s，庫存不足",getMessage(),
				orderItem.getProductId(), orderItem.getSpecName(), orderItem.getQuantity() );
		return msg;
	}
	
	
}
