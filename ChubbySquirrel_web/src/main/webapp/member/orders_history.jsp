<%@page import="uuu.cs.entity.Product"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.entity.Order"%>
<%@page import="uuu.cs.service.OrderService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-歷史訂單</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="歷史訂單"/>
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
				min-height: 60vh;
    			margin-bottom: 100px;
			}
			.orderHistoryDiv{
				width: 80%;
				text-align: center;
				margin: auto;
			}
			#range input[type="radio"] {			
			  visibility: hidden; /* 把原本的input藏起來 */
			}
			#range label {
				cursor: pointer;
			    position: relative;
			    padding-left: 30px;
			}
			#range .radioSpan {
			  /* 自定義樣式的span */
				height: 15px;
			    width: 15px;
			    border: 3px solid #444;
			    border-radius: 50%;
			    display: inline-block;
			    position: absolute;
			    left: 0;
			    top: 10%;
			}
			#range .radioSpan::after { /* 中間點點 */
			    content: "";
			    display: block;
			    height: 11px;
			    width: 11px;
			    border-radius: 50%;
			    position: absolute;
			    transform: translate(2px, 2px);
			    background-color: #444;
			    opacity: 0;
			    transition: opacity 0.2s;
			}
			#range input[type="radio"]:checked + label .radioSpan::after {
			  /* 選中radio時 才顯示中間點點 */
			  opacity: 1;
			}
			.orderHistoryDiv ul{
		 		padding: 0;
				margin: 0;
			}
		 	.orderHistoryDiv ul span {
		 		display:inline-block;
		 		width: 190px;
		 	}
		 	.orderHistoryDiv p{
		 		text-align: center;
		 	}
		 	.orderHistoryDiv #head{
		 		font-weight: bold;
		 	}
		 	.orderHistoryDiv h2{
		 		margin: 5px;
		 	}
		</style>
		<script>
			//自訂的javascript function
		</script>
	</head>
	<body>
		<% 
			String range = request.getParameter("range");
			OrderService oService = new OrderService();
			Customer member = (Customer)session.getAttribute("member");
			
			List<Order> list = null;			
			list = oService.getOrdersHistory(member, range);
			System.out.println(list==null?"null":list);
		%>
		<article>
		<div class='orderHistoryDiv'>
			<h2>歷史訂單</h2>			
			<form action="" method="GET">
				<fieldset id="range">
					<legend><button>查詢歷史訂單</button></legend>
					查詢範圍：
					<input type="radio" id="1" name="range" value="1" checked>
					<label for="1">
						<span class='radioSpan'></span>
						一個月
					</label>
					<input type="radio" id="6" name="range" value="6">
					<label for="6">
						<span class='radioSpan'></span>
						半年
					</label>
					<input type="radio" id="2" name="range" value="2">
					<label for="2">
						<span class='radioSpan'></span>
						兩年
					</label>
				</fieldset>
			</form>
			<br>
			<hr>
			<br>
			<% if(list==null || list.isEmpty()) { %>
			<p>查無該範圍內的歷史訂單</p>
			<% }else{ %>
			<ul type="none">
				<li id="head">
					<span>訂單編號</span>
					<span>訂購日期時間</span>
					<span>貨運方式</span> 
					<span>付款方式</span> 
					<span>處理狀態</span>
					<span>總金額</span>
				</li>
				<% for(Order order:list) {%>	
				<li>
					<span>
						<a href='order.jsp?orderId=<%= order.getId() %>'><%= order.getId() %></a>
					</span>
					<span><%= order.getCreatedDate()%> <%= order.getCreatedTime()%></span>
					<span><%= order.getShippingType().getDescription() %></span>
					<span><%= order.getPaymentType().getDescription() %></span>
					<span><%= order.getStatusDescription()%></span>
					<span><%= Product.priceFormat.format(order.getTotalAmount()) %></span>
				</li>
				<% } %>
			</ul>
			<% } %>
		</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>