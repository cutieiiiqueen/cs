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
				/*min-height: 100vh;*/
				display: flex;
			    align-items: center;
			    justify-content: flex-start;
			    flex-direction: column;
			    margin-bottom: 50px;
			}
			#loadingOverlay {
				position: fixed;
				top: 0;
				left: 0;
				width: 100%;
				height: 100%;
				background-color: rgba(0, 0, 0, 0.5);
				z-index: 9999;
				display: flex;
				justify-content: center;
				align-items: center;			
			}
			#loadingMessage {
				background-color: white;
			    padding: 5px 10px;
			    border-radius: 5px;
			    font-size: 30px;
			    font-weight: bold;
			    display: flex;
			    justify-content: center;
			    align-items: center;
			}	
			#loadingMessage span{
				padding: 15px;
			}
			#squirrelProcess {
		        height: 80px;
			    margin-bottom: 15px;
			    padding: 5px;
			}
			.messageDiv{				
				text-align: center;
			}
			.forgetPwd{
				display: flex;
			    flex-direction: column;
			    align-items: center;
			}
			.container{
				border: 3px solid #444;
			    background: #fff;
			    border-radius: 15px;
			    padding: 15px;
			    padding-top: 30px;
			    box-shadow: 5px 5px 0px #c79600;
			    width: fit-content;
			    height: 250px;
			}
			.forgetPwd p {
    			margin: 10px 30px;
			}
			.forgetPwd #forgetPwd_email, .forgetPwd #forgetPwd_captcha{
				border: 1px solid gray;
			    border-radius: 15px;
			    width: 220px;
			    height: 30px;
			    box-sizing: border-box;
			    padding: 10px;
			    background: rgb(222 214 193 / 46%);
			}
			.forgetPwd #forgetPwd_captcha{
			    width: 110px;
			    margin-right:5px;
			}
			#captcha_p{
				display: flex;
			    justify-content: center;
			    align-items: center;
			}
			#forgetPwd_submit{
				display: block;
			    width: 70px;
			    height: 35px;
			    border: 1px solid rgb(255 204 0);
			    border-radius: 5px;
			    box-sizing: border-box;
			    text-align: center;
			    color: #444444;
			    background: rgb(255 204 0);
			    cursor: pointer;
			    margin: 10px;
			    font-weight: bold;
			    box-shadow: 0px 5px 0px 0px #c79600;
			    font-size: 14px;
			}
			#forgetPwd_submit:hover{
				transform: translateY(5px);
				box-shadow: 0px 0px 0px 0px;
			}
		</style>
		<script type="text/javascript">
			$(init);
			
			function init() {
				$('.forgetPwd').on('submit', handleFormSubmit);
			}
			
			function handleFormSubmit(e) {
				var email = $('input[name="email"]').val(); // 獲取email欄位值
				var captcha = $('input[name="captcha"]').val(); // 獲取驗證碼欄位值
				
				if (email === "" || captcha === "") {
				  $('#messageText').text("信箱或驗證碼不得為空!"); // 顯示錯誤訊息
				  $('.email').val(""); // 清空email欄位
				  $('.captcha').val(""); // 清空驗證碼欄位
				  e.preventDefault(); // 防止表單提交
				} else {
				  $('#messageText').text(""); // 清空錯誤訊息
				  $('#loadingOverlay').show(); // 顯示載入中畫面
				}
			}
		</script>
	</head>
	<body>
		<article>
			<!--處理中的畫面-->
			<div id="loadingOverlay" style="display: none;">
				<div id="loadingMessage">
					<span>處理中...</span>
					<img id="squirrelProcess" src="<%=request.getContextPath() %>/images/squirrel.png">			
				</div>
			</div>
			<!-- 顯示後端傳遞的訊息 -->
			<div class="errorsDiv">
				<p id='errorsText'>${errors}</p> <!-- EL寫法 -->
			</div>
			<div class='container'>
				<form class="forgetPwd" action="<%=request.getContextPath() %>/ResetPassword.do" method="POST">
					<h3>忘記密碼</h3>
					<p>
						<input id="forgetPwd_email" type='text' name="email" placeholder="請輸入email/手機號碼">
					</p>
					<p id="captcha_p">
						<input id="forgetPwd_captcha" type="text" name="captcha"  placeholder="請輸入驗證碼">
						<img id="captchaImg" alt="驗證碼圖片" src="<%=request.getContextPath() %>/images/captcha_login.png" title="點選圖片更新驗證碼" onclick="refreshCaptcha()">
					</p>
					<p>
						<input id="forgetPwd_submit" type="submit" value="重設密碼">
					</p>
				</form>
			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>