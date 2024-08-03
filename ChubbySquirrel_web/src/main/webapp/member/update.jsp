<!-- <%@ page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="uuu.cs.entity.VIP"%>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-會員修改</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="會員修改"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/cs.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/update.css">
		
		<style>
		</style>
		<script>
		
			$(init);
			function init(){
			    <%List<String> errors = (List<String>) request.getAttribute("errors");
			    
			    	if("POST".equals(request.getMethod())) {
			        if (errors != null && !errors.isEmpty()) { %>
			            repopulateForm();
			    <%}%>
			    <%} else if("GET".equals(request.getMethod())) {%>
			        populateMemberData();
			    <%}%>
			    $("#changePassword").change(checkboxHandler);
			}			

			//refreshCaptcha方法, 用於更新驗證碼圖片, 將url+時間(新的url)以達到刷新驗證碼圖片的效果
			function refreshCaptcha(){
				//alert("refresh Captcha");
				captchaImg.src="/cs/images/captcha_login.png?attr=" + new Date();
			}
			function repopulateForm(){
				alert("會員修改失敗，請重新操作!");	
				$("input[name=email]").val("${sessionScope.member.email}"); //不可修改, 要用session 不然會有漏洞(可用F12將readonly改掉)
				$("input[name=phone]").val("${param.phone}");
				$("input[name=name]").val("${param.name}");
				$("select[name=gender]").val("${param.gender}");
				$("input[name=birthday]").val("${member.birthday}");
				$("textarea[name=address]").val("${param.address}");
				<%--//$("input[name=subscribed]").prop("checked",${param.subscribed!=null});--%>
				refreshCaptcha();
			}
			function populateMemberData(){
				<%--//alert("${sessionScope.member.discountString}");--%>
				$("input[name=email]").val("${sessionScope.member.email}");
				$("input[name=phone]").val("${sessionScope.member.phone}");
				//$("input[name=password]").val("${member.password}"); //不帶回密碼, 要重新輸入
				$("input[name=name]").val("${member.name}"); //sessionScope可省略
				$("select[name=gender]").val("${member.gender}");
				$("input[name=birthday]").val("${member.birthday}");
				$("textarea[name=address]").val("${member.address}");
			}    
			function checkboxHandler(){
			    if($("#changePassword").is(":checked")) {
			        $('#newPassword').removeAttr('disabled');
			        $('#newPasswordCheck').removeAttr('disabled');
			    } else {
			        $('#newPassword').attr('disabled', true).val("");
			        $('#newPasswordCheck').attr('disabled', true).val("");
			    }
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
			
			<!-- 會員修改表單  -->
			<div class='updateContainer'>
				<form id="updateForm" action="update.do" method="POST"> 				
					<div id="leftDiv">		
								<!--div>
								Customer member = (Customer)session.getAttribute("member");
								if (member instanceof VIP) {
								<div>
									<input type="checkbox" checked disabled><label>享有VIP<span id='discount'>85折</span></label> ((VIP)member).getDiscountString() 
								</div-->
							<div>
								<label for="email" class="inputLabel">帳號</label>
								<input id="email" type="email" name="email" readonly>
								<br><span class='unableUpdateText'>※不可修改</span>
							</div>
							<div>
								<label for="phone" class="inputLabel">手機</label>
								<input id="phone" type="tel" name="phone" placeholder="請輸入手機號碼" required pattern="\d{10,20}">
							</div>
							<div>
								<label for="password" class="inputLabel">原密碼</label>
								<input id="password" type="password" name="password" placeholder="請輸入原密碼" required>
								
							</div>
							<div>
								<fieldset>
									<legend><input id='changePassword' type='checkbox'>修改密碼</legend>
									<div>
										<span>新密碼</span>
										<input id="newPassword" type="password" name="newPassword" placeholder="請輸入新密碼" disabled minlength="6" maxlength="20">
									</div>
									<div>
										<span>密碼確認</span>
										<input id="newPasswordCheck" type="password" name="newPasswordCheck" placeholder="請再次輸入密碼" disabled minlength="6" maxlength="20">
									</div>
								</fieldset>
							</div>
							<div>
						</div>
					</div>
					<div id="rightDiv">
						<div>
							<label for="name" class="inputLabel">姓名</label>
							<input id="name" type="text" name="name" placeholder="請輸入姓名" required	minlength="2" maxlength="20" >
						</div>		
						<div>
							<label for="gender" class="inputLabel">性別</label>
							<select id="gender" name="gender" required>
								<option value="">請選擇</option>
								<option value="M">男</option>
								<option value="F">女</option>
								<option value="O">其他</option>
							</select>
						</div>	
						<div>
							<label for="birthday" class="inputLabel">生日</label>
							<input id="birthday" type="date" name="birthday" min="1900-01-01" max="2100-12-31" required readonly>
							<br><span class='unableUpdateText'>※不可修改</span>
						</div>
						<div>
							<label for="address" class="inputLabel">地址</label>
							<textarea id="address" rows="2" cols="30" name="address"></textarea>
						</div>
						<div>
							<label for="captcha" class="inputLabel">驗證碼</label>
							<input id="captcha" type="text" name="captcha"  placeholder="請輸入驗證碼" required>
							<img id="captchaImg" alt="驗證碼圖片" src="../images/captcha_login.png"
								 title="點選圖片更新驗證碼" onclick="refreshCaptcha()">
						</div>
						<input id="updateSubmitBtn" type="submit" value="會員修改">
					</div>
				</form>
			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>