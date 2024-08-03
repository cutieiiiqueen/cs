<%@ page pageEncoding="UTF-8" contentType="application/json"%>
{
	"totalQty": ${cart == null || cart.isEmpty() ? "" : cart.getTotalQuantity()}
}
