<!-- <%@ page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-忘記密碼</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="忘記密碼"/>
		</jsp:include>
		
		
		<style>
			article{
				height: 553px;
				display: flex;
			    align-items: center;
			    justify-content: flex-start;
			    flex-direction: column;
			    margin-bottom: 50px;
			}
		</style>
		<script type="text/javascript">
			var seconds = 5;
			$(document).ready(init);
			
			function init(){
			  interval = window.setInterval((updateSecs), 1000);
			}
			function updateSecs(){
				seconds--;
			  	$('#secs').text(seconds)
	
			  if (seconds == 0) {
			    clearInterval(interval);
			    window.location.href = '<%=request.getContextPath()%>/login.jsp';
			  }
			}
		</script>
	</head>
	<body>
		<article>
			<h2>${memberName!=null? memberName:"親愛的會員"}您好，密碼已發送至註冊信箱，請重新登入並修改您的密碼！</h2>
			<div>五秒後回到登入頁面，倒數：<span id="secs">5</span>秒</div>
			<p>如果您的瀏覽器未自動重新導向，請點擊<a href="<%=request.getContextPath() %>/login.jsp">這裡</a>。</p>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>