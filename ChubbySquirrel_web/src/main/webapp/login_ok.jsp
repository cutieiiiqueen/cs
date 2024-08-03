<!-- <%@ page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<%@page import="uuu.cs.entity.Customer"%>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<meta http-equiv="refresh" content="10; url=./"/><!--自動轉址-->
		<title>胖松鼠-會員登入</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="會員登入"/>
		</jsp:include>
				
		<style>
			h2{
				text-align: center;
				color: #1c1e21;
				font-weight: bold;
			}
			a{
				color: blue;
			}
			p{
				text-align: center;
			}
		</style>
		<script>
			var seconds = 10;
			$(document).ready(init);
			
			function init(){
			  interval = window.setInterval((updateSecs), 1000);
			}
			function updateSecs(){
				seconds--;
			  	$('#secs').text(seconds)
	
			  if (seconds == 0) {
			    clearInterval(interval);
			    //window.location.href = "https://sdwh.dev";
			  }
			}
		</script>
	</head>	
	<body>

		<article>
			<!-- 顯示登入成功訊息 -->
			<%--
				<%
					Customer member = (Customer)session.getAttribute("member"); //要轉型
				%>
				<h2><%=member!=null?member.getName()+"您好:D，歡迎回來":"尚未登入"%></h2>
			 --%>
			<!-- h2>${member!=null?member.getName():""}您好:D，歡迎回來</h2-->
			<h2>您將於10秒後自動重新導向至首頁：<span id="secs">10</span></h2>
			<p>如果您的瀏覽器未自動重新導向，請點擊<a href="<%=request.getContextPath() %>/index.jsp">這裡</a>。</p>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>