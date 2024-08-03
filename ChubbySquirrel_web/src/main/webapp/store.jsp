<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-店鋪資訊</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="店鋪資訊"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/store.css">	

		<script>
		//520 X 340
		var index = 1;
		var photoNum = 4;
		
		$(document).ready(init);
		function init() {
			$("#next").click(nextHandler);
			$("#prev").click(prevHandler);
			$(".pic").append("<img src='./images/store"+photoNum+".png' />");
			for (var i = 1; i <= photoNum; i++) {
				$(".pic").append("<img src='./images/store" + i + ".png' />");
			}
			$(".pic").append("<img src='./images/store1.png' />");
		}

		function nextHandler(e) {
			index++;
			if (index <= photoNum ) {
				$(".pic").animate({ "left": -((index) * 520) + "px" }, 300);
			} else {
				$(".pic").animate({ "left": -((index) * 520) + "px" }, 300, photosStart);
				index = 1;
			}
		}

		function prevHandler(e) {
			index--;
			if (index > 0) {
				$(".pic").animate({ "left": -((index) * 520) + "px" }, 300);
			} else {
				$(".pic").animate({ "left": -((index) * 520) + "px" }, 300, photosEnd);
				index = photoNum;
			}
		}
		function photosStart() {
			$(".pic").css({ "left": "-520px" });
		}
		function photosEnd() {
			$(".pic").css({ "left": "-2080px" });
		}
		</script>
	</head>
	<body>
		<article>
			<div class="store">
				<div class="storeContainer">
					<div class='text'>
						<h1>胖松鼠堅果<img src="./images/squirrel.png"></h1>
						<h3>新北市新店區中正路270號1樓</h3>
						<p><i class="fa-solid fa-phone" style="color: #444444;"></i> 訂購電話：0931-040-357</p>
						<p><i class="fa-regular fa-clock" style="color: #444444;"></i> 營業時間：每周三、六、日，08:00 am ~ 12:30 am</p>		
						<br>
						<i class="fa-solid fa-slash fa-xl" style="color: #444444;"></i>
						<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #444444;"></i><i class="fa-solid fa-slash fa-xl" style="color: #444444;"></i>
						<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #444444;"></i><i class="fa-solid fa-slash fa-xl" style="color: #444444;"></i>
						<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #444444;"></i><i class="fa-solid fa-slash fa-xl" style="color: #444444;"></i>
						<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #444444;"></i><i class="fa-solid fa-slash fa-xl" style="color: #444444;"></i>
						<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #444444;"></i><i class="fa-solid fa-slash fa-xl" style="color: #444444;"></i>
						<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #444444;"></i>
						<br><br>
						<p>七張捷運站走路10分鐘　<i class="fa-solid fa-person-walking fa-2xl" style="color: #444444;"></i></p>
					</div>	
					<div class='storePic'>
						<div class='head'>
							<span>Picture</span>
							<span>
							<i class="fa-solid fa-minus" style="color: #444444;"></i>
							<i class="fa-regular fa-square" style="color: #444444;"></i>
							<i class="fa-solid fa-xmark" style="color: #444444;"></i>
							</span>							
						</div>
						<div class=picOuter>
							<div class="pic"></div>
						</div>
						<div id="prev"><i class="fa-regular fa-circle-left fa-xl" style="color: #444444;"></i></div>
						<div id="next"><i class="fa-regular fa-circle-right fa-xl" style="color: #444444;"></i></div>
					</div>		
				</div>
				<div class="storeMap">
					<iframe class="storeMap" width='100%' height='800px' frameborder='0' 
						src='https://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q=24.9736474,121.5390084&z=16&output=embed'>
					</iframe>

				</div>
			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>