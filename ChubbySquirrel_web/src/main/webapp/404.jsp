<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-找不到網頁</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="找不到網頁"/>
		</jsp:include>
		
		<style>
			article{
				margin: 120px 0 0 0;
			    flex: 1 0 auto;
			    background: #ffe9c6;
			}
			article img {
 				width: 1300px;
 				min-width:1000px;
				display:block;
				margin:auto;
			}			
		</style>
		<script>
			//自訂的javascript function
		</script>
	</head>
	<body>
		<article>
			<!--h3>網頁URL: <%=request.getAttribute("javax.servlet.error.request_uri")%></h3-->
			<img src="<%=request.getContextPath() %>/images/404.png">
		</article>		
	</body>
</html>