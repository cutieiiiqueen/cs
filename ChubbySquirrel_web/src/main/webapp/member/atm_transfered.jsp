<%@page import="java.time.LocalDate"%>
<%@page import="uuu.cs.entity.Order"%>
<%@page import="uuu.cs.entity.PaymentType"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="uuu.cs.service.OrderService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/cs.css">	
		<title>胖松鼠-轉帳通知</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="轉帳通知"/>
		</jsp:include>
		
		<!-- CSS -->
		<style>
			.atmDiv{
			    width: fit-content;
			    background: #fff;
			    border: 3px solid #444;
			    box-shadow: 5px 5px 0 #c79600;
			    margin: auto;
			    padding: 50px;
			    border-radius: 15px;
			}
			.atmDiv label{
				display: inline-block;
			    width: 80px;
			    font-weight: 500;
			    color: #444;
			}
			.atmDiv p:last-child{
				display: flex;
			    height: 50px;
			    justify-content: space-evenly;
			    align-items: flex-end;
			}
			.atmDiv input[type='reset'], .atmDiv input[type='submit']{
				width: 100px;
			    height: 35px;
			    background: rgb(255, 204, 0);
			    border: none;
			    border-radius: 5px;
			    box-shadow: 0 5px 0 #c79600;
			    font-size: 14px;
			    font-weight: 600;
			    color: #444;
			    cursor: pointer;
			}
			.atmDiv input[type='reset']:hover, .atmDiv input[type='submit']:hover{
			    box-shadow: 0 0 0;
			    transform: translateY(5px);			    
			}
		</style>
		<script>
			//自訂的javascript function
		</script>
	</head>
	
	<body>
		<%
			String orderId = request.getParameter("orderId");
			Customer member = (Customer)session.getAttribute("member");
			Order order = null;
			OrderService oService = new OrderService();
			if(member!=null && orderId!=null){
				order = oService.getOrderById(member, orderId);
			}
		%>
		<article>		
		<% if(order==null || !(PaymentType.ATM==order.getPaymentType() && order.getStatus()==0)) { %>
			<p>查無須通知轉帳的訂單資料，回<a href='orders_history.jsp'>歷史訂單</a></p>
		<% }else{ %>
			<div class="errorsDiv">
         	 ${errors}         	 
			</div>
			<div class='atmDiv'>
				<form action="atm_transfered.do" method="POST">
					<p>
						<label>訂單編號</label>
						<input type="hidden" name="orderId" value="<%= orderId %>" readonly>
						<input value="<%= order.getId() %>" readonly>
					</p>
					<p>
						<label>轉帳銀行</label>
						<input name='bank' required placeholder='請輸入轉帳銀行名稱'>
					</p>
					<p>
						<label>帳號後5碼</label>
						<input name='last5Code' required placeholder='請輸入轉帳帳號後五碼' pattern="\d{5}">
					</p>
					<p>
						<label>轉帳金額</label>
						<input name='amount' required value='<%= order.getTotalAmount() %>'>
					</p>
					<p>
						<label>轉帳時間</label>
						<input type='date' name='transDate' required min='<%= order.getCreatedDate() %>' max='<%= LocalDate.now()%>'>
						<input type='time' name='transTime' required>
					</p>
					<p>
						<input type='reset' value='Reset'>
						<input type='submit' value='確定'>
					</p>
				</form>
			</div>
		<% } %>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>