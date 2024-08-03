<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-最新消息</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="NEWS"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/news.css">
		
		<style>
		</style>
		<script>
			//自訂的javascript function
		</script>
	</head>
	
	<body>
		<article>
			<div class="news">
			<h1>NEWS</h1>
			<div class='newsContainer'>
				<div class="date"><span>2024/06/01</span></div>
				<div class="head"><h2>營業時間變更</h2>
				</div>
				<div class="text">
				<p>即日起營業時間如下：</p>
				<div class="tableDiv">
					<table>
					<tr>
						<th>原營業時間</th>
					</tr>
					<tr>
						<td>每周三、六&雙周日</td>
					</tr>
					</table>
					&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-arrow-right-long"></i>&nbsp;&nbsp;&nbsp;
					<table>
					<tr>
						<th>變更後營業時間</th>
					</tr>
					<tr>
						<td>每周三、六、日</td>
					</tr>
					</table>					
				</div>
				<p>營業時間:08:00am~12:30am</p>
				<p>謝謝大家!
				</div>
			</div>
			<div class='newsContainer'>
				<div class="date"><span>2024/03/01</span></div>
				<div class="head"><h2>大量訂購享有優惠，歡迎來電訂購~</h2></div>
				<div class="text">
				<p>需要大量訂購者，歡迎來電訂購，享有特別優惠呦!</p>
				<p>訂購電話:0931-040-357</p>
				<p>(請至少提前一個月訂購)</p>
				</div>
			</div>
			<div class='newsContainer'>
				<div class="date"><span>2024/01/15</span></div>
				<div class="head"><h2>新春禮盒預定中</h2></div>
				<div class="text">
				<img src="./images/box.png">
				<p>過年新春禮盒預定中，禮盒數量有限，請盡速來電預定呦~</p>
				<p>訂購電話:0931-040-357</p>
				</div>
			</div>
			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>