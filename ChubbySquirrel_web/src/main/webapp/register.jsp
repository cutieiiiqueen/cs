<!-- <%@ page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-會員註冊</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="會員註冊"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/register.css">

		<script>
			//refreshCaptcha方法, 用於更新驗證碼圖片, 將url+時間(新的url)以達到刷新驗證碼圖片的效果
			function refreshCaptcha(){
				//alert("refresh Captcha");
				captchaImg.src="/cs/images/captcha_login.png?attr=" + new Date();
			}
			
			$(init);
			
			function init(){
				<% if("POST".equals(request.getMethod())) { %>	
					repopulateForm();
				<% } %>
			}	
			function repopulateForm(){
				alert("會員註冊失敗，請重新註冊!");	
				$("input[name=email]").val("${param.email}");
				$("input[name=phone]").val("${param.phone}");
				$("input[name=name]").val("${param.name}");
				$("select[name=gender]").val("${param.gender}");
				$("input[name=birthday]").val("${param.birthday}");
				$("textarea[name=address]").val("${param.address}");
				//$("input[name=subscribed]").prop("checked",${param.subscribed!=null});
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
			
			<!-- 會員註冊表單  -->
			<div class='registerContainer'>
				<form id="registerForm" action="<%=request.getContextPath() %>/register.do" method="POST">
					<div id="leftDiv">
						<p>
							<label for="email" class="inputLabel">帳號<span>必填</span></label>
							<input id="email" type="email" name="email" placeholder="請輸入email"value="${param.id}" required>
						</p>
						<p>
							<label for="phone" class="inputLabel">手機<span>必填</span></label>
							<input id="phone" type="tel" name="phone" placeholder="請輸入手機號碼" required
								pattern="\d{10,20}"><!-- 只能輸入10~20個數字 -->
						</p>
						<p>
							<label for="password" class="inputLabel">密碼<span>必填</span></label>
							<input id="password" type="password" name="password" placeholder="請輸入密碼" required
								minlength="6" maxlength="20"><!-- 只能輸入6~20個字 -->
						</p>
						<p>
							<label for="password_check" class="inputLabel">密碼確認<span>必填</span></label>
							<input id="password_check" type="password" name="password_check" placeholder="請再次輸入密碼" required
								minlength="6" maxlength="20"><!-- 只能輸入6~20個字 -->
						</p>
					</div>
					<div id="rightDiv">
						<p>
							<label for="name" class="inputLabel">姓名<span>必填</span></label>
							<input id="name" type="text" name="name" placeholder="請輸入姓名" required
								minlength="2" maxlength="20" ><!-- 只能輸入2~20個字 -->
						</p>		
						<p>
							<label for="gender" class="inputLabel">性別<span>必填</span></label>
							<select id="gender" name="gender" required>
								<option value="">請選擇</option>
								<option value="M">男</option>
								<option value="F">女</option>
								<option value="O">其他</option>
							</select>
						</p>	
						<p>
							<label for="birthday" class="inputLabel">生日<span>必填</span></label>
							<input id="birthday" type="date" name="birthday" min="1900-01-01" max="2100-12-31" required>
						</p>
						<p>
							<label for="address" class="inputLabel">地址<span id="addressspan">必填</span></label>
							<textarea id="address" rows="2" cols="30" name="address" ></textarea>
						</p>
						<p>
							<label for="captcha" class="inputLabel">驗證碼<span>必填</span></label>
							<input id="captcha" type="text" name="captcha"  placeholder="請輸入驗證碼" required>
							<img id="captchaImg" alt="驗證碼圖片" src="<%=request.getContextPath() %>/images/captcha_login.png"
								 title="點選圖片更新驗證碼" onclick="refreshCaptcha()"><!-- 當點選驗證碼圖片時, 呼叫refreshCaptcha()方法更新驗證碼圖片 -->
						</p>
						<input id="registerSubmit" type="submit" value="註冊新會員">
					</div>				
				</form>
			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>