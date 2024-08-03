<%@page import="uuu.cs.entity.OrderStatusLog"%>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.entity.PaymentType"%>
<%@page import="uuu.cs.entity.Product"%>
<%@page import="uuu.cs.entity.OrderItem"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="uuu.cs.entity.Order"%>
<%@page import="uuu.cs.service.OrderService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>胖松鼠-訂單明細</title>
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="訂單明細"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/cs.css">
				
		<style>
			header{
				width: 100%;
				margin: auto;
				display: flex;
				justify-content: center;
				/* margin-top: 15px; */
				position: fixed;
				z-index: 3;
				height: 120px;
				background: rgb(255 204 0);
			}
			body{
				background:transparent;
			}
			article{
				margin-bottom: 50px;
			}
			.statusDiv{
				display: flex;
				width: fit-content;
			    margin: auto;
			    margin-top: 50px;
			    margin-bottom: 50px;
			}
			.orderInfo{
				text-align: left;
				border-spacing: 15px;
				width: 1000px;				
			}
			.orderInfo td{
				width: 100px;
			}
			.orderInfo td:nth-child(2), .orderInfo td:nth-child(4){
				width: 350px;
			}
			.orderInfo td:nth-child(1), .orderInfo td:nth-child(3){
				background: #444;
				color: #fff;
				letter-spacing: 3px;			
			}
			.orderInfo a:visited{
				color: blue;
			}
			.orderDiv{
				background: #fff;
			    width: fit-content;
			    margin: auto;
			}
			.orderItem {
				width: 1000px;
				margin: auto;
				text-decoration: none;
				border-collapse: collapse;
			}
			.tableHead{
				width: 1000px;
			    text-align: center;
			    font-weight: bold;
			    border-bottom: 4px solid #444;
			    padding: 5px;
			    margin: 10px;
			    font-size: 18px;
			}
			.orderItem th{
				background: #444;
				color: #fff;
				letter-spacing: 3px;
				font-weight: 400;
				margin-top: 5px;
				border: 1px solid #fff;
			}
			.orderItem tr, .orderItem td{
				border: 1px solid #ddd;
			}
			.orderItem img{
				height: 50px;
				float: left;
				display: inline-block;
				margin-right: 10px;
			}
			.orderItem td a {
				text-decoration: none;
				color:black;
			}
			.orderItem td:nth-last-child(-n+3){
				text-align: right;
			}
			.orderItem td{
				padding: 8px;
			}
			.statusDiv div span{
				height: 40px;
				width: 80px;
				padding: 8px 15px;
			    color: #444;
			    font-weight: 600;
			    border-radius: 5px;
			    border: 2px solid #444;
			}
			.statusDiv div .ok{
			 	background: rgb(255, 204, 0);
			}

			.fa-caret-right {	
			    width: 30px;
			    height: 40px;
			    text-align: center;
			    align-content: center;
			}

		</style>
	</head>
	<body>
		<% 
			String orderId = request.getParameter("orderId");
			Customer member = (Customer)session.getAttribute("member");
			OrderService oService = new OrderService();
			Order order = null;
			List<OrderStatusLog> statusLogList = null;
			if(orderId!=null){
				order = oService.getOrderById(member, orderId);
				if(order!=null){
					statusLogList = oService.getOrderStatusLog(orderId);
				}
			}
		%>
		<article>
			<div class="orderDiv">
 			<% if(order==null) {%>
 			<div>訂單不存在或已刪除!</div>
 			<% }else{ %>
             <div class="statusDiv"><!-- 狀態列，可不做 -->
 				<div id="log0"><span class="status0 ok">新訂單</span><i class="fa-solid fa-caret-right fa-xl" style="color: #444444;"></i></div>
 				<div id="log1" style="display: none;"><span class="status1"></span><i class="fa-solid fa-caret-right fa-xl" style="color: #444444;"></i></div>
 				<div id="log2"><span class="status2">付　款</span><i class="fa-solid fa-caret-right fa-xl" style="color: #444444;"></i></div>
 				<div id="log3"><span class="status3">出　貨</span><i class="fa-solid fa-caret-right fa-xl" style="color: #444444;"></i></div>
 				<div id="log4"><span class="status4">到　貨</span><i class="fa-solid fa-caret-right fa-xl" style="color: #444444;"></i></div>
 				<div id="log5"><span class="status5">取　貨</span><i class="fa-solid fa-caret-right fa-xl" style="color: #444444;"></i></div>
 				<div id="log6"><span class="status6">完　成</span><i class="fa-solid fa-caret-right fa-xl" style="color: transparent;"></i></div>
 			</div>
			<div class="tableHead">訂單資訊</div>
			<table class="orderInfo">
				<tbody>
					<tr>
						<td>訂單編號</td>
						<td><%= order.getId() %></td>	
						<td>收件人</td>
						<td><%= order.getRecipientName() %></td>
					</tr>
					<tr>					
						<td>下單日期</td>
						<td><%=order.getCreatedDate() %> <%= order.getCreatedTime() %></td>
						<td>收件人電話</td>
						<td><%= order.getRecipientPhone() %></td>
					</tr>
					<tr>	
						<td>訂單狀態</td>
						<td><%= order.getStatus() %>:<%= order.getStatusDescription() %></td>
						<td>收件人信箱</td>
						<td><%= order.getRecipientEmail() %></td>
					</tr>
					<tr>
						<td>付款方式</td>
						<td><%=order.getPaymentType().getDescription() %></td>
						<td>收件地址</td>
						<td><%= order.getShippingAddress() %></td>
					</tr>
					<tr>
						<td>付款備註</td>
						<td>
						<i style='color:blue'><%= order.getPaymentNote()==null?"尚未付款":order.getPaymentNote()%>
						&nbsp;&nbsp;<% if(PaymentType.ATM==order.getPaymentType() && order.getStatus()==0) { %>
						<a href='atm_transfered.jsp?orderId=<%= order.getId() %>'>請填寫轉帳訊息</a>
						<% } %>
						</i>
						</td>
						<td>貨運方式</td>
						<td><%=order.getShippingType().getDescription() %></td>
					</tr>
					<tr>
						<td style="background:transparent;"></td>
						<td></td>
						<td>運送備註</td>
						<td><%= order.getShippingNote()==null?"尚未出貨":order.getShippingNote()%></td>
					</tr>
					<tr>
				</tbody>
			</table>	

 				<div class="tableHead">訂單明細</div>
				<table class="orderItem">
					<thead>
						<tr>
							<th>產品編號</th>
							<th>產品名稱</th>
							<th>規格</th>
							<th>數量</th>
							<th>單價</th>
							<th>金額</th>
						</tr>
					</thead>
					<tbody>
						<% for(OrderItem item:order.getOrderItemSet()) {%>
						<tr>
							<td><%= item.getProductId() %></td>
							<td><%= item.getProductName() %>
								<img onerror="getNoPhotoImg(this)" src='<%= item.getPhotoUrl()%>'>
							</td>						
							<td><%= item.getSpecName() %></td>
							<td><%=item.getQuantity() %></td>
							<td><%= Product.priceFormat.format(item.getPrice()) %></td>
							<td><%= Product.priceFormat.format(item.getAmount()) %></td>
						</tr>
						<% } %>
						<tr>
							<td><%= order.size() %>項</td>	
							<td></td>	
							<td></td>
							<td><%= order.getTotalQuantity() %>件</td>
							<td>小計</td>	
							<td><%= Product.priceFormat.format(order.getSubtotal()) %></td>
						</tr>
						<% if (order.getSubtotal() != order.getDiscountAmount()) { %>
						<tr>
							<td colspan="5">VIP會員折扣後金額</td>	
							<td><%= Product.priceFormat.format(order.getDiscountAmount()) %></td>
						</tr>
						<% } %>
						<tr>
							<td colspan="5">金流手續費</td>						
							<td><%= Product.priceFormat.format(order.getPaymentFee()) %></td>
						</tr>							
						<tr>
							<td colspan="5">運費</td>
							<td><%= Product.priceFormat.format(order.getShippingFee()) %></td>
						</tr>
						<tr>					
							<td colspan="5">總金額</td>
							<td><%= Product.priceFormat.format(order.getTotalAmount()) %></td>
						</tr>
					</tbody>
					<tfoot></tfoot>
				</table>
			</div>
			<% } %>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
		
		<script>
			$(init);
			function init(){
				setStatus();			
			}
			function setStatus(){				
				<% if(statusLogList!=null && statusLogList.size()>0){
					for(OrderStatusLog log:statusLogList){ %>
						if(<%= log.getStatus() %>==1){
							$("#log<%= log.getStatus() %>").show();
							$(".status<%= log.getStatus() %>").addClass("ok");			
							$(".status<%= log.getStatus() %>").text("<%= order.getStatusDescription(log.getStatus()) %>");
						}
							$(".status<%= log.getStatus() %>").addClass("ok");
							$(".status<%= log.getStatus() %>").text("<%= order.getStatusDescription(log.getStatus()) %>");
							$(".status<%= log.getStatus() %>").attr("title", "<%= log.getLogTime()%>");		
							console.log("ok: <%= log.getStatus() %>");
						if(!$(".status<%= log.getStatus()-1 %>").hasClass('ok')){
							console.log("ok: <%= log.getStatus()-1 %>");
							$("#log<%= log.getStatus()-1 %>").hide();
						}
				<%	}
					
				}%>
			}
			//當沒有照片時, 會自動帶入此張圖片
			function getNoPhotoImg(theImg){
				theImg.src="/cs/images/errorphoto.png";
			}
		</script>
	</body>
</html>

