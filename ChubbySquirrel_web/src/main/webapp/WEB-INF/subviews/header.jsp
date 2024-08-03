<%@page import="uuu.cs.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<head>
		<!-- 字體嵌入 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100..900&display=swap" rel="stylesheet">
	    
	    <!-- 網頁icon -->
		<link rel="icon" href="<%=request.getContextPath() %>/images/squirrel.png"/>
		
		<!-- jQuery -->
		<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
		crossorigin="anonymous"></script>
		
		<!-- fontawesome -->
		<script src="https://kit.fontawesome.com/a1814338bf.js" crossorigin="anonymous"></script>
		
		<!-- CSS -->
		<link rel="preload" href="<%=request.getContextPath() %>/styles/cs.css" as="style">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/cs.css">
		
		<style>
		.loading {
			  position: fixed;
			  top: 0;
			  left: 0;
			  width: 100%;
			  height: 100%;
			  background: #fffdf4 /*rgb(255,204,0);*/
			  z-index: 12000;
			}
		</style>
		
		
		<script>
			$(document).ready(init);
			function init(){
				/*$("#searchSubmit").hover(showHandler);
				if ($(".searchBar").attr("value")==="")	{
					$(".nav_sub").mouseleave(HideHandler);
				}*/
				$(".nav a").on("mouseover", mouseoverHandler);
				$(".nav").on("mouseleave", mouseleaveHandler);
				$(".submit").click(submitForm);
				//$(".fa-search").on("mouseover", searchHandler);
				//$(document).mousemove(mousemoveHandler);
				if ($(".cartNum").text().trim() !== '') {
					$(".cartNum").show();
				}
				$(".menu-toggle").on("mouseover", menuMouseoverHandler);
				$(".nav").on("mouseleave", menuMouseleaveHandler);
			}
			function menuMouseoverHandler(){
				$(".nav").addClass("show");
			}
			function menuMouseleaveHandler(){
				$(".nav").removeClass("show");
			}
			function showHandler(){
				$(".searchBar").animate({width:"180px", opacity:"1"});
			}
			function HideHandler(){
				$(".searchBar").animate({width:"0px", opacity:"0"});
			}			
		    function mouseoverHandler() {
		        var position = $(this).parent().position();
		        var width = $(this).parent().width();
		        $(".nav .slide").show();
		        $(".nav .slide").css({left: +(position.left+10), width: (width-20)});
		        // 移除所有文字的白色顏色
		        $(".nav a").removeClass("textcolor");
		        // 給點擊的文字添加白色顏色
		        $(this).addClass("textcolor");
		    }
		    function mouseleaveHandler(){
		        $(".nav .slide").hide();
		        $(".nav a").removeClass("textcolor");
		    }
		    function submitForm(){
                event.preventDefault();  // 阻止默認行為
                $('#submitForm').submit();   // 提交表單
		    }
		    function searchHandler(){
		    	$(".fa-search").css("transform","translateX(80px)");
		    	$(".fa-search").css("opacity","0");
		    	$(".fa-hand-o-right").css("transform","translateX(80px)");
		    	$(".fa-hand-o-right").css("opacity","1");
		    }
		    /*function mousemoveHandler(e){
		    	$("#myName").offset({left:e.pageX-10, top:e.pageY+20});
		    }*/
		    
		 	// 在頁面切換前顯示加載動畫
		    window.addEventListener('beforeunload', function() {
		      document.body.classList.add('loading');
		    });

		    // 在新頁面加載完成後隱藏加載動畫
		    window.addEventListener('load', function() {
		      document.body.classList.remove('loading');
		    });
		</script>
	</head>
	<body>
		<!-- header.jsp start -->
		<header>
		        <div class="logo">
		            <a href="<%=request.getContextPath() %>/"><img src="<%=request.getContextPath() %>/images/logoImg.png" alt="Logo"></a>
		        </div>
		         <div class="searchContainer">
                   <form id="submitForm" action="<%=request.getContextPath() %>/products_list.jsp" method="GET">
                       <input class="searchBar" type="search" placeholder="搜尋產品" name="keyword" value="${param.keyword}" autocomplete="off" required>
                   </form>
                   <a href="#" class="submit">
	                   <i class="fa fa-hand-o-right"></i>
			           <i class="fa fa-search"></i>
                   </a>
		        </div> 
			<div class='navContainer'>
	        	<ul class="nav">
			        <li class="slide"></li>
			        <li><a href="<%=request.getContextPath() %>/">首頁</a></li>
			        <li><a href="<%=request.getContextPath() %>/products_list.jsp">全部商品</a></li>
			        <li><a href="<%=request.getContextPath() %>/news.jsp">最新消息</a></li>
			        <li><a href="<%=request.getContextPath() %>/store.jsp">店鋪資訊</a></li>			        
			    </ul>       
	            <ul class="nav_sub">
	            	<li>
	            		<a class="mailTo" href="mailto:chubbysquirrel662@gmail.com?subject=&body=">
	            			<div class="mailIcon"><i class="fa-solid fa-envelope" style="color: #000000;"></i></div>
	            		</a>
	            	</li>
	                <li>
	                	<a class="nav_cart" href="<%=request.getContextPath() %>/member/cart.jsp">
	                		<div class="cartIcon"><i class="fa-solid fa-cart-shopping"></i>
	                		<sup class="cartNum">${cart == null || cart.isEmpty() ? "" :  cart.getTotalQuantity() }</sup>
	                		</div>
	                	</a>
	                </li>
	                <li class="nav_member">
		                <a href="#">
		                <div class="memberIcon"><i class="fa-solid fa-user"></i></div>
	                </a>
	                    <div class="memberDropdown">
	                            <% Customer member = (Customer) session.getAttribute("member");
	                            if (member == null) { %>
	                                <a href="<%=request.getContextPath() %>/login.jsp">會員登入</a>
	                                <a href="<%=request.getContextPath() %>/register.jsp">會員註冊</a>
	                            <% } else { %>
	                                <a href="<%=request.getContextPath() %>/logout.do">會員登出</a>
	                                <a href="<%=request.getContextPath() %>/member/update.jsp">會員修改</a>
	                                <a href="<%=request.getContextPath() %>/member/track_list.jsp">追蹤清單</a>
	                                <a href="<%=request.getContextPath() %>/member/orders_history.jsp">歷史訂單</a>
	                            <% } %>
	                    </div>
	                </li>
	            </ul>
	            
	            <div class="welcomeSpan">
                	<span>${member != null ? member.getName() : "Hi, "}</span>你好 <i class="fa-regular fa-face-smile-wink fa-lg"></i></i>
           		</div>	
	        </div>
	        
		       <!-- 新的響應式導航 -->
			    <div class="responsive-nav">			        
				    <ul class="nav_sub">
				    	<li>
				    		<a class="menu-toggle" herf="#"><i class="fa-solid fa-bars"></i></a>
				    	</li>
			           	<li>
			           		<a class="mailTo" href="mailto:chubbysquirrel662@gmail.com?subject=&body=">
			           			<div class="mailIcon"><i class="fa-solid fa-envelope" style="color: #000000;"></i></div>
			           		</a>
			           	</li>
		               <li>
		               	<a class="nav_cart" href="<%=request.getContextPath() %>/member/cart.jsp">
		               		<div class="cartIcon"><i class="fa-solid fa-cart-shopping"></i>
		               		<sup class="cartNum">${cart == null || cart.isEmpty() ? "" :  cart.getTotalQuantity() }</sup>
		               		</div>
		               	</a>
		               </li>
		               <li class="nav_member">
			               <a href="#">
			               <div class="memberIcon"><i class="fa-solid fa-user"></i></div>
		               	   </a>
		                   <div class="memberDropdown">
		                           <% Customer member2 = (Customer) session.getAttribute("member");
		                           if (member2 == null) { %>
		                               <a href="<%=request.getContextPath() %>/login.jsp">會員登入</a>
		                               <a href="<%=request.getContextPath() %>/register.jsp">會員註冊</a>
		                           <% } else { %>
		                               <a href="<%=request.getContextPath() %>/logout.do">會員登出</a>
		                               <a href="<%=request.getContextPath() %>/member/update.jsp">會員修改</a>
		                               <a href="<%=request.getContextPath() %>/member/track_list.jsp">追蹤清單</a>
		                               <a href="<%=request.getContextPath() %>/member/orders_history.jsp">歷史訂單</a>
		                           <% } %>
		                   </div>
		               </li>
			       	</ul>
			       	<ul class="nav">
			       		<li class="searchContainer2">
				       		<form id="submitForm2" action="<%=request.getContextPath() %>/products_list.jsp" method="GET">
	                       		<input class="searchBar2" type="search" placeholder="搜尋" name="keyword" value="${param.keyword}" autocomplete="off" required>
		                   		<button type="submit" class="searchSubmitBtn"><i class="fa-solid fa-magnifying-glass"></i></button>
		                   	</form>		                   
		                </li>
				        <li><a href="<%=request.getContextPath() %>/">首頁</a></li>
				        <li><a href="<%=request.getContextPath() %>/products_list.jsp">全部商品</a></li>
				        <li><a href="<%=request.getContextPath() %>/news.jsp">最新消息</a></li>
				        <li><a href="<%=request.getContextPath() %>/store.jsp">店鋪資訊</a></li>	
	                </ul>
		    </div>
	        
	        <img id='myName' style='width:120px; height:120px; z-index:5;' src='<%=request.getContextPath() %>/images/me.png'>
		</header>
		<!-- header.jsp end -->
	</body>
</html>

