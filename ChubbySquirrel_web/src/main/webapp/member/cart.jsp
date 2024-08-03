<%@page import="uuu.cs.entity.VIP"%>
<%@page import="uuu.cs.service.ProductService"%>
<%@page import="uuu.cs.entity.Product"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="uuu.cs.entity.ShoppingCart"%>
<%@page import="uuu.cs.entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-購物車</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="購物車"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/cart.css">
		
		<script>
			function getNoPhotoImg(theImg){
				theImg.src="../images/errorphoto.png";
			}
			$(init);
			function init(){
			    // 為checkbox和數量輸入框添加事件監聽器
			    $('input[type="checkbox"][name="selectedItems"], input[type="number"]').on('change', calculateTotal);
			}
		    function calculateTotal() {
		        var total = 0;
		        var totalItems = 0;
		        var totalQuantity = 0;

		        $('input[type="checkbox"][name="selectedItems"]:checked').each(function() {
		            var row = $(this).closest('tr');
		            var quantity = parseInt(row.find('input[type="number"]').val());
		            var price = parseFloat(row.find('td:eq(6)').text());
		            
		            total += price;
		            totalItems++;
		            totalQuantity += quantity;
		        });

		        // 更新總金額
		        $('#subTotalSpan').text(Math.round(total));

		     	// 如果有VIP折扣，更新折扣後金額
		        var discountSpan = $('#discountAmountSpan');
		        if (discountSpan.length > 0) {
		            var discountText = $('.VIP td:first').text();
		            var match = discountText.match(/(\d+)折/);
		            
		            if (match) {
		                var discountValue = parseInt(match[1]);
		                var discount;
		                
		                if (discountValue >= 10) { // 95折, 85折等情況
		                    discount = discountValue / 100;
		                } else { // 9折, 8折等情況 
		                    discount = discountValue / 10;
		                }		                
		                var discountedTotal = total * discount;
		                discountSpan.text(Math.round(discountedTotal));
		            }
		        }

		        // 更新商品數量和件數
		        $('.total_tr td:first').text('共' + totalItems + '項, ' + totalQuantity + '件');
		    }
		</script>
	</head>
	<body>
		<article>
			<div class="errorsDiv">
				<p id='errorsText'>${errors}</p>
			</div>
			<%
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
				if(cart==null || cart.isEmpty()){
			%>
			<h2>購物車是空的，請先購物後才能檢視內容!</h2>
			<% }else{ %>

			<form id="cartForm" action="update_cart.do" method="POST">
			<div class='cartDiv'>
			<table class="cart">
				<caption>購物車</caption>
				<thead>
					<tr>
						<th>選取</th>
						<th>產品編號</th>
						<th>名稱</th>
						<th>規格</th>						
						<th>數量</th>
						<th>單價</th>
						<th>小計</th>
						<th>刪除</th>
					</tr>
				</thead>
				<tbody>
					<%
						ProductService pService = new ProductService();
						Set<CartItem> cartItemSet = cart.getCartItemSet();
						for(CartItem cartItem:cartItemSet){
						int stk = pService.getStockByProductIdSpecName(cartItem.getProduct().getId(), cartItem.getSpecName());
		                cartItem.setStock(stk);
					%>
					<tr>
						<td><input type="checkbox" name="selectedItems" value="<%= cartItem.hashCode() %>" checked></td>
						<td><%= cartItem.getProductId() %></td>
						<td id='nameTd'>
							<a href="../product_detail.jsp?productId=<%= cartItem.getProductId() %>">
							<img onerror='getNoPhotoImg(this)' class='cartItemPhoto' src='<%= cartItem.getPhotoUrl() %>'>
							<div class="productName"><%= cartItem.getProductName() %><br><span style="font-size:small;">(庫存: <%= stk %>)</span></div>						
							</a>
						</td>
						<td><%= cartItem.getSpecName() %></td>
						<td><input type="number" name="quantity<%= cartItem.hashCode() %>" value="<%= cart.getQuantity(cartItem) %>" min="<%=cartItem.getStock()==0?0:1 %>" max="<%= cartItem.getStock()==0?0:cartItem.getStock() %>"></td>
						<td>
							<div class='listPrice'>
							<% if(cartItem.getDiscountString().isEmpty()) { %>
								<%= Math.round(cartItem.getListPrice()) %></div>
							<% }else{ %>
							<%= Math.round(cartItem.getListPrice()) %><br>
							<%= cartItem.getDiscountString()%><%= Math.round(cartItem.getUnitPrice()) %>
							<% } %>
						</td>
						<td><%= Math.round(cart.getAmount(cartItem)) %></td>
						<td><input type="checkbox" name="delete<%= cartItem.hashCode() %>"></td>
					</tr>		
					</tbody>			
					<% } %>
					<tfoot>
					<tr class='total_tr'>
						<td colspan="5" style="text-align: right;">共<%= cart.size() %>項, <%= cart.getTotalQuantity() %>件 </td>
						<td>
							<div style=""><span>總金額:</span></div>
						</td>
						<td>
							<div style=""><span id='subTotalSpan'><%= Math.round(cart.getTotalAmount()) %></span></div>
						</td>
						<td></td>
					</tr>					
					<%  Customer c = (Customer)session.getAttribute("member");
						if (c instanceof VIP) { %>
					<tr class='VIP'>
						<td colspan="5" style="text-align: right;">VIP會員<%= ((VIP)c).getDiscountString() %></td>
						<td>折扣後金額:</td>
						<td>
							<div><span id='discountAmountSpan'><%= Math.round(cart.getTotalAmount()*(100-((VIP)c).getDiscount())/100) %></span></div>
						</td>
						<td></td>
					</tr>												        
					<% }%>
					<tr>
						<td colspan="4"></td>
						<td><button type="button" name="submit" value="shopping"><a href="../products_list.jsp">繼續購物</a></button></td>
						<td><button type="submit" name="submit" value="reset">清空購物車</button></td>				
						<td><input type="submit" value="修改購物車"></td>
						<td><button type="submit" name="submit" value="checkOut">我要結帳</button></td>
					</tr>
					</tfoot>
			</table>
			</div>			
			</form>
			<% } %>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>