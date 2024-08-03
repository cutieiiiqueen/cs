<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-結帳</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="結帳"/>
		</jsp:include>

		
		<style>
			/*自訂的CSS*/
			header{
				width: 100%;
				margin: auto;
				display: flex;
				justify-content: center;
				/* margin-top: 15px; */
				position: fixed;
				z-index: 3;
				height: 120px;
				background: rgb(255 204 0);
			}
			body{
				background:transparent;
			}
			article{
			    text-align: center;
			    display: flex;
			    flex-direction: column;
			    align-items: center;
			    margin-bottom: 50px;
			}
			article #check{
				display: block;
				margin: 50px;
				width: 150px;
			}
			.btn{
				width: 300px;
				display: flex;	
				justify-content: space-between;	
				margin: 50px;		
			}
			.btn div{
				background: rgb(255, 204, 0);
			    padding: 8px 35px;
			    border-radius: 5px;
			    box-shadow: 0px 5px 0px rgb(200, 150, 0);
			}
			.btn div:hover{
			    box-shadow: 0px 0px 0px;
			    transform: translateY(5px);
			}
			.btn a{
				text-decoration: none;
				color:#444;
				font-weight: bold;
				font-size: medium;
			}
			
			
		</style>
		<script>
			//自訂的javascript function
		</script>
	</head>
	<body>
		<article>
			<img id="check" src="../images/check.png">
			<h2>感謝您的購買</h2>
			<div>已收到訂單，請檢視訂單明細，確認您的付款狀態</div>
			<div class="btn">
			<div><a href='order.jsp?orderId=${order.getId()}'>查詢訂單</a></div>
			<div><a href='orders_history.jsp'>歷史訂單</a></div>
			</div>
			
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>