<%@page import="uuu.cs.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<!-- meta http-equiv="refresh" content="10; url=<%= request.getContextPath()%>"/--> <!--自動轉址-->
		<title>胖松鼠-會員修改</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="會員修改"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/styles/cs.css">
		<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/styles/update.css">
		
		<style>
			h2{
				text-align: center;
				color: #000;
				font-weight: bold;
				width: fit-content;
				margin: auto;
			}
		</style>
	</head>
	<body>
		<article>			
			<%
				//Customer member = (Customer)session.getAttribute("member"); //要轉型
			%>
			<h2>${member!=null? member.getName():"沒有member"}修改成功!</h2>
			
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>