<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v20.0" nonce="nacyos98"></script>
	<script src="https://kit.fontawesome.com/a1814338bf.js" crossorigin="anonymous"></script>
	<script>
		$(init);
		function init(){
			$("#goTop").click(goTopHandler);
		}
		function goTopHandler(){
			$("html, body").animate({scrollTop: 0}, 500);
		}		
	</script>
</head>
<body>
	<!-- footer.jsp start -->
		<footer>
			<div class="footerContainer">
				<div class='brand'>
					<div class="head">Brand</div>
					<div class="brandContainer">
						<img src="/cs/images/logoImg.png">
						<div class="text">
							<p style="">胖松鼠堅果</p>
							<p>&copy; 2024 Chubby Squirrel</p>
						</div>
					</div>					
				</div>
				<div class='access'>
					<div class="head">Access</div>
						<p><i class="fa-solid fa-location-dot" style="color: #444444;"></i>　新北市新店區中正路270號1樓</p>
						<p><i class="fa-solid fa-phone" style="color: #444444;"></i>　0931-040-357</p>
						<p><i class="fa-regular fa-clock" style="color: #444444;"></i>　每周三、六、日，08:00 am ~ 12:30 am</p>		
				</div>
				<div class='follow'>
					<div class="head">Follow</div>
					<div class="fb-page" 
						data-href="https://www.facebook.com/chubbysNuts" 
						data-tabs="timeline" 
						data-width="300" 
						data-height="60" 
						data-small-header="true" 
						data-adapt-container-width="true" 
						data-hide-cover="true" 
						data-show-facepile="true"
						style="margin: auto; margin-top:15px; display:block;width:300px;">
						<blockquote cite="https://www.facebook.com/chubbysNuts" class="fb-xfbml-parse-ignore">
						<a href="https://www.facebook.com/chubbysNuts">胖松鼠</a>
						</blockquote>
					</div>
				</div>
			</div>
			<div id="goTop">
				<i class="fa-regular fa-hand-point-up" style="color: #444; font-size:50px;"></i>
			</div>
		</footer>
		<!-- footer.jsp end -->
</body>	