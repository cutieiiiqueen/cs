<%@page import="uuu.cs.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<meta http-equiv="refresh" content="10; url=./"/> <!--自動轉址-->
		<title>胖松鼠-會員註冊</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="會員註冊"/>
		</jsp:include>
		
		<!-- CSS -->
		
		<style>
			article{
				min-height:1000px;
				margin:auto;
				width:1235px;
				box-sizing:border-box;
				text-align: center;
			}
		</style>

	</head>
	<body>
		<article>
			<!-- 顯示註冊成功訊息 -->
			<%--
				<%
					Customer c = (Customer)request.getAttribute("customer"); //要轉型
				%>
				<h2><%= c!=null?"註冊成功! "+c.getName()+"你好:D":"沒有c"%></h2>
			--%>
			<!-- h2>${customer.getName()}您好：D，註冊成功</h2-->
			<p>10秒後會自動轉址到<a href="./">首頁</a>，請重新登入!</p><!--TODO:倒數計時-->
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>