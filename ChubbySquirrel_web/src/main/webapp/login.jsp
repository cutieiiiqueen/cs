<!-- <%@ page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-會員登入</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="會員登入"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/login.css">
		
		<script>
			function displayPassword() {
				if ($("#password").attr("type") === "password") {
	    			$("#password").attr("type", "text");
	    			$("#eyeIcon").attr("src", "/cs/images/eye_close_black.png");
	  			} else {
	   				$("#password").attr("type", "password");
					$("#eyeIcon").attr("src", "/cs/images/eye_open_black.png");
				}
			}
			//refreshCaptcha方法, 用於更新驗證碼圖片, 將url+時間(新的url)以達到刷新驗證碼圖片的效果
			function refreshCaptcha(){
 				//alert("refresh Captcha");
				captchaImg.src="/cs/images/captcha_login.png?attr=" + new Date();
			}
			
		</script>
	</head>
	<body>
		<article>
			<!-- 顯示後端傳遞的錯誤訊息 -->
			<div class="errorsDiv">			
			<%-- 
				<%
					List<String> errors = (List<String>) request.getAttribute("errors");
				%>
				<%= errors!=null?errors:"" %>
			--%>
				<p id='errorsText'>${errors}</p> <!-- EL寫法 -->
			</div>
			<div></div>
			<div class='container'>
				<img id="squirrel" src="<%=request.getContextPath() %>/images/squirrel.png">
				<!-- 登入表單 -->
				
				<form class="login" action="<%=request.getContextPath() %>/login.do" method="POST">
					<p>
						<input class="login_input" type='text' name="email" placeholder="請輸入email/手機號碼" >
					</p>
					<p class="login_password">
						<input class="login_input" type="password" id="password" name="password" placeholder="請輸入密碼" >
						<img id="eyeIcon" src="<%=request.getContextPath() %>/images/eye_open_black.png" onclick="displayPassword()">
					</p>
					<p>
						<input class="login_input" type="text" name="captcha"  placeholder="請輸入驗證碼" >
						<img id="captchaImg" alt="驗證碼圖片" src="<%=request.getContextPath() %>/images/captcha_login.png" title="點選圖片更新驗證碼" onclick="refreshCaptcha()">
					</p>
					<div>
						<a href="<%=request.getContextPath() %>/register.jsp">註冊會員</a>
						<a href="<%=request.getContextPath() %>/forget_password.jsp">忘記密碼</a>
					</div>
					<p>
						<input id="login_submit" type="submit" value="登入">
					</p>
					<p>
					    <input id="quick_login" type="submit" name="quickLogin" value="快速登入">
					</p>
				</form>
			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>