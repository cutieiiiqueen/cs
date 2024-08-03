<!-- <%@ page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->	
		<title>胖松鼠-首頁</title>  
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="首頁"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/index.css">		
		
		<style>
		
		@media (min-width: 1200px) {
		    .backgroundText {
		        font-size: 7vw;
		    }
		
		    #indexImg {
		        height: 100vh;
		    }
		
		    .pokerItem {
		        width: 220px;
		        height: 330px;
		    }
		
		    .accessContainer #map, .accessContainer #text {
		        height: 500px;
		    }
		}

			

		</style>
		
		<script type="text/javascript">
		
			var myInterval, index = 0;
			$(document).ready(init);
			
			function init() {
				//圖片輪播
				$(".dot,#next,#prev").click(moveHandler);//run the same function				
				myInterval = setTimeout(moveHandler, 3000);//initial timer
				//首圖動畫效果
				setTimeout(indexImgHandler, 500);
			    //poker控制
			   	$(".pokerItem").on("mouseenter", pokerHandler);
			}

			function moveHandler(e) {
				//console.log(this) //window				
				clearInterval(myInterval);//reset timer  //沒有殺掉會吃掉秒數, 讓每次點擊後都還是有三秒鐘
				myInterval = setTimeout(moveHandler, 3000); //set timeer
				$(".dot:eq(" + index + ")").css("backgroundColor", "gray");//reset dot color
				if (this == window) { //看14行
					index++;//setInterval
				} else if ($(this).attr("myIndex")) { //#next, #prev沒有myIndex屬性所以會變undefined, Number(undefined)=NaN, if(NaN)=false 所以不會執行
					index = Number($(this).attr("myIndex"));//.dot
				} else {
					index += Number($(this).attr("direction"));// $#prev / #next //強迫轉型為數字
				}
				if (index > 2) index = 0;//last image //最後一張往後回到第一張
				if (index < 0) index = 2;//first image //第一張往前回到最後一張
				$(".dot:eq(" + index + ")").css("backgroundColor", "white");//set dot color
				$("#photos").stop().animate({ "marginLeft": -index * 1200 + "px" }, 1000);//image width=735px
			}
			function indexImgHandler() {
		        $('#indexImg').addClass('animate');
		    }
			function pokerHandler() {
		        $(this).addClass("open");
		    }
			function getNoPhotoImg(theImg){
				theImg.src="/cs/images/errorphoto.png";
			}
		</script>	
	</head>
	<body>
		<p class='backgroundText'>胖松鼠<br>健康養生堅果<br>美味又健康<span> </span><i class="fa-solid fa-thumbs-up"></i><!--i class="fa-solid fa-seedling"></i--></p>
		<article>
			<div id='indexImg'><img src="images/index_nuts.png"></div>
			<!-- div id="outer">
				<div id="photos">
					<a href="#"><img src="images/index_Img_1.png"></a>
					<a href="#"><img src="images/index_Img_2.png"></a>
					<a href="#"><img src="images/index_Img_3.png"></a>
				</div>
				<div id="prev" direction="-1"><i class="fa-solid fa-angle-left"></i></div>
				<div id="next" direction="1"><i class="fa-solid fa-angle-right"></i></div>
				<div id="dots">
					<div class="dot" myIndex="0"></div>
					<div class="dot" myIndex="1"></div>
					<div class="dot" myIndex="2"></div>
				</div>
			</div-->
			
			<div class='hotSaleDiv'>
			<div class='headDiv'><i class="fa-solid fa-slash fa-xl" style="color: #FFD43B;"></i>　熱銷排行　<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #FFD43B;"></i></div>
				<div class='pokerDiv'>
					<div class='topPokerDiv'>
						<div class="pokerItem">
							<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=1">
					        	<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/1_poker_back.png" class="poker_back">
					        </a>
					    </div>
						<div class="pokerItem">
							<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=2">
					       		<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/2_poker_back.png" class="poker_back">
					        </a>
					    </div>
					    <div class="pokerItem">
					    	<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=18">
						        <img src="./images/poker_front.png" class="poker_front">
						        <img src="./images/3_poker_back.png" class="poker_back">
						    </a>
					    </div>
					     <div class="pokerItem">
					     	<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=7">
					        	<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/4_poker_back.png" class="poker_back">
					        </a>
					    </div>		
					    <div class="pokerItem">
					    	<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=3">
					        	<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/5_poker_back.png" class="poker_back">
					        </a>
					    </div>	
					</div>	
					<div class='bottomPokerDiv'>
						<div class="pokerItem">
							<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=13">
					      		<img src="./images/poker_front.png" class="poker_front">
					       		<img src="./images/6_poker_back.png" class="poker_back">
					        </a>
					    </div>
						<div class="pokerItem">
							<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=4">
					        	<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/7_poker_back.png" class="poker_back">
					        </a>
					    </div>
					    <div class="pokerItem">
					    	<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=22">
					        	<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/8_poker_back.png" class="poker_back">
					        </a>
					    </div>
					     <div class="pokerItem">
					     	<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=16">
					        	<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/9_poker_back.png" class="poker_back">
					        </a>
					    </div>		
					    <div class="pokerItem">
					    	<a href="<%=request.getContextPath() %>/product_detail.jsp?productId=17">
					        	<img src="./images/poker_front.png" class="poker_front">
					        	<img src="./images/10_poker_back.png" class="poker_back">
					        </a>
					    </div>   
				    </div>  
			     </div>			    
				</div>
				
			<div class="newsDiv">
				<div class='headDiv'><i class="fa-solid fa-slash fa-xl" style="color: #FFD43B;"></i>　最新消息　<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #FFD43B;"></i></div>
				<div class="newsContainer">
					<div class="newsItem">
						<a href='news.jsp'>
							<div class="newsDate">2024/06/01</div>
							<div class="newsText">營業時間變更</div>
							<div class="newsBtn"><i class="fa-solid fa-arrow-right"></i></div>
						</a>
					</div>
					<div class="newsItem">
						<a href='news.jsp'>
							<div class="newsDate">2024/03/01</div>
							<div class="newsText">大量訂購享有優惠，歡迎來電訂購~</div>
							<div class="newsBtn"><i class="fa-solid fa-arrow-right"></i></div>
						</a>
					</div>
					<div class="newsItem">
						<a href='news.jsp'>
							<div class="newsDate">2024/01/15</div>
							<div class="newsText">新春禮盒預定中</div>
							<div class="newsBtn"><i class="fa-solid fa-arrow-right"></i></div>
						</a>
					</div>
				</div>
			</div>			
			
			<div class="accessDiv">
				<div class='headDiv'><i class="fa-solid fa-slash fa-xl" style="color: #FFD43B;"></i>　店鋪位置　<i class="fa-solid fa-slash fa-flip-vertical fa-xl" style="color: #FFD43B;"></i></div>
				<div class="accessContainer">
					<div id='map'>
						<iframe class="storeMap" width='95%' height='95%' frameborder='0' 
						src='https://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q=24.9736474,121.5390084&z=16&output=embed'>
						</iframe><br><br>
					</div>
					<div id='text'>
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
				</div>
			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>