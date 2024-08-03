<%@page import="java.util.ArrayList"%>
<%@page import="uuu.cs.entity.SpecialOffer"%>
<%@page import="uuu.cs.entity.Product"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.service.ProductService"%>
<%@page import="uuu.cs.service.TrackService"%>
<%@page import="java.util.Set"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-產品清單</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="產品清單"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/products_list.css">
		
		<style>
			#modalWindow {
			    position: fixed;
			    left: 50%;
			    top: 50%;
			    width: 100vw;
			    height: 100vh;
			    background: rgba(0, 0, 0, 0.2);
			    display: flex;
			    align-items: center;
			    justify-content: center;
			    transform: translate(-50%, -50%);
			    display: none;
			}

		</style>
		
		<script>
			$(init);
			function init(){
				$("#categoryList ul a").on("mouseover", categoryMouseoverHandler);
				$("#categoryList ul").on("mouseleave", categoryMouseleaveHandler);
				
				//加入追蹤
			    $(".trackToggle i").click(function() {
				    	var productId = $(this).closest(".trackToggle").data("product-id");
				        var action = $(this).hasClass("fa-regular") ? "addTrack" : "removeTrack";
				        var $icon = $(this);
	
				        $.ajax({
				            url: "track.do",
				            type: "POST",
				            data: { action: action, productId: productId },
				            success: function(response) {
				                if(response === "success") {
				                    if(action === "addTrack") {
				                        $icon.removeClass("fa-regular").addClass("fa-solid");
				                    } else {
				                        $icon.removeClass("fa-solid").addClass("fa-regular");
				                    }
				                } else if (response === "not_logged_in") {
				                    alert("請先登入");
				                    window.location.href = "login.jsp";
				                } else {
				                    alert("加入追蹤清單失敗");
				                }
				            },
				            error: function() {
				                alert("加入追蹤清單失敗");
				            }
			        });
				});
			}
		    function categoryMouseoverHandler() {
		        var position = $(this).position();
		        var width = $(this).width();
		        $(".slideForCategory").show();
		        $(".slideForCategory").css({top:+(position.top+5), width: (width)});
		        // 移除所有文字的顏色
		        $("#categoryList ul a").removeClass("textcolor");
		        // 給點擊的文字添加顏色
		        $(this).addClass("textcolor");
		    }
		    function categoryMouseleaveHandler(){
		        $(".slideForCategory").hide();
		        $("#categoryList ul a").removeClass("textcolor");
		    }
			function submitHandler() {
			    var minPrice = Number($("#minPrice").val());
			    var maxPrice = Number($("#maxPrice").val());
				//檢查
				if (minPrice == 0) $("#minPrice").val("0");
			    if (maxPrice == 0) $("#maxPrice").val("999999");
			    
			    //重新獲取值
			    minPrice = Number($("#minPrice").val());
			    maxPrice = Number($("#maxPrice").val());
			    if (isNaN(minPrice) || isNaN(maxPrice)) alert("請輸入有效的數字！");	
			    if (minPrice < 0 || maxPrice < 0)  alert("價格不得為負值！");
			    if (minPrice > maxPrice) alert("最低價不能大於最高價！");	
			    // 提交表單			    
			    $("#priceForm").submit();
			}		
			function loadSmallProductDetail(productId){
				$.ajax({
					url:"small_product_detail.jsp?productId=" + productId,
					method: "GET"
				}).done(smallProductDetail_doneHandler);
			}
			function smallProductDetail_doneHandler(result, status, xhr){
				//alert("ajax結果成功回傳");
				$("#modalWindow").html(result);		
				$("#modalWindow").css("display", "block");
				
	            // 為表單添加提交事件處理器
	            $("#modalWindow form").on("submit", closeModalWindowHandler);
			}
			function closeModalWindowHandler(){
				$("#modalWindow").css("display", "none");
			}
			function getNoPhotoImg(theImg){
				theImg.src="/cs/images/errorphoto.png";
			}
    	</script>

	</head>
	<body>		
		<article>
		
		<div class="leftside">	        
			<div id="categoryList">
				<ul><h3>商品分類</h3>
					<li class="slideForCategory"></li>
					<li><a href="?" data-text="&nbsp;&nbsp;全部&nbsp;&nbsp;">&nbsp;&nbsp;全部&nbsp;&nbsp;</a></li>
					<li><a href="?category=NEWEST" data-text="&nbsp;&nbsp;NEWEST&nbsp;&nbsp;">&nbsp;&nbsp;最新上架&nbsp;&nbsp;</a></li>
					<li><a href="?category=綜合堅果" data-text="&nbsp;&nbsp;綜合堅果&nbsp;&nbsp;">&nbsp;&nbsp;綜合堅果&nbsp;&nbsp;</a></li>
					<li><a href="?category=單品堅果" data-text="&nbsp;&nbsp;單品堅果&nbsp;&nbsp;">&nbsp;&nbsp;單品堅果&nbsp;&nbsp;</a></li>
					<li><a href="?category=爆米香" data-text="&nbsp;&nbsp;爆米香&nbsp;&nbsp;">&nbsp;&nbsp;爆米香&nbsp;&nbsp;</a></li>
					<li><a href="?category=果乾" data-text="&nbsp;&nbsp;果乾&nbsp;&nbsp;">&nbsp;&nbsp;果乾&nbsp;&nbsp;</a></li>
					<li><a href="?category=其他" data-text="&nbsp;&nbsp;其他&nbsp;&nbsp;">&nbsp;&nbsp;其他&nbsp;&nbsp;</a></li>
				</ul>
				<h3>價格區間</h3>
				<form action="" method="GET" id="priceForm">
				    <input id="minPrice" type="number" name="minPrice" min="0" placeholder="最低價" value="${param.minPrice}">
				    －
				    <input id="maxPrice" type="number" name="maxPrice" min="0" max="999999" placeholder="最高價" value="${param.maxPrice}">
				    <input id="searchbtn" type="submit" value="搜尋" onclick="submitHandler()">
				</form>
			</div>
		</div>
	     
		<div class="center">  
		     <!-- 程式 -->
		 
			 <%
// 				request.setCharacterEncoding("UTF-8"); //當request為GET請求時可省略，url中的querystring資料一定是UTF-8編碼
				//1.讀取request的query string中指定的parameter
				String category = request.getParameter("category");
				String keyword = request.getParameter("keyword");				
				String minPrice = request.getParameter("minPrice");
				String maxPrice = request.getParameter("maxPrice");
				
				List<String> errors = new ArrayList<>();	
				ProductService pService = new ProductService();
				List<Product> list = new ArrayList<>();
				
				//查詢是否為會員，並取得會員的追蹤清單
				Customer member = (Customer) session.getAttribute("member");
			    TrackService trackService = new TrackService();
			    Set<Integer> trackedProductIds = null;				
				
			    if (member != null) {
				    trackService = new TrackService();
				    trackedProductIds =  trackService.getTrackedProductIds(member.getEmail());
			    }
				
				//out.println("minPrice=" + minPrice); //for test
				//out.println("maxPrice=" + maxPrice); //for test
				
				if ("NEWEST".equals(category)) {
				    list = pService.getNewestProducts();
				} else if (category != null && category.length() > 0) {
				    list = pService.getProductsByCategory(category);
				} else if (keyword != null && keyword.length() > 0) {
				    list = pService.getProductsByKeyword(keyword);
				} else if (minPrice != null && !minPrice.isEmpty() && maxPrice != null && !maxPrice.isEmpty()) {
				    //out.println("檢查minPrice以及maxPrice不為空字串"); //for test
				    try {
				        double minPriceValue = Double.parseDouble(minPrice);
				        double maxPriceValue = Double.parseDouble(maxPrice);
				        
				        if (minPriceValue < 0 || maxPriceValue < 0) {
				            //out.println("當minPrice或maxPrice是負值時"); //for test
				            errors.add("最低價或最高價不得輸入負值");
				            request.setAttribute("errors", errors);
				        } else {
				            //out.println("呼叫getProductByPriceInRange方法:pass"); //for test
				            list = pService.getProductByPriceInRange(minPrice, maxPrice);
				        }
				    } catch (NumberFormatException e) {
				        errors.add("價格必須是有效的數字");
				        request.setAttribute("errors", errors);
				    }
				} else {
				    list = pService.getAllProducts();
				}
				
				// 檢查是否有錯誤訊息，如果有就不進行後續的處理
				if (!errors.isEmpty()) {
				    // 顯示錯誤訊息的頁面或邏輯%>
				 	<div class="errorsDiv">
		         	 ${errors}		         	 
					</div>
				<%} else {
				    // 處理並顯示產品列表的邏輯
				}
				
				//out.print(list); //輸出
				//3.將資料輸出畫面
			%>				
			<%-- <%= list %>--%><%-- 測試用 --%>
			<%-- ${param.category} --%>
			
			<!-- 產品查詢結果 -->
			<% if(list==null || list.isEmpty()){ %>
				<div id="message"><h2>查無產品資料!</h2></div>
				
			<% }else{ %>
				
				<ul id="productList">
					<% for(int i=0;i<list.size();i++){
						Product p = list.get(i);
						if(p.getStatus()==0) {
					%>
					<li class="productItem">
						<!-- 點選圖片/產品名稱，跳至產品明細超連結 -->
						<a href="product_detail.jsp?productId=<%= p.getId()%>">
							<div class="productNameDiv"><p><%= p.getName()%></p></div>
							<div class="productImgDiv"><img onerror='getNoPhotoImg(this)' src="<%=p.getPhotoUrl()%>"></div>	
						    <% if(p instanceof SpecialOffer) { %>
						        <div id="price_text">NT <%= Product.priceFormat.format(((SpecialOffer)p).getUnitPrice()) %></div>
						    <% } else { %>
						        <div id="price_text">NT <%= Product.priceFormat.format(p.getUnitPrice())%></div>
						    <% } %>
						<!--div>優惠價:<%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %> <%= p.getUnitPrice()%>元</div>
						<div id="price_text">NT$  <%= p.getUnitPrice()%></div-->
						</a>
						<div id='smallBtn'>
							<!--新增追蹤按鈕，若會員已登入，且產品已在顧客的追蹤清單中，則顯示已追蹤-->
							<span class="trackToggle" data-product-id="<%= p.getId() %>">
	                            <i class="fa-<%= (member != null && trackedProductIds != null && trackedProductIds.contains(p.getId())) ? "solid" : "regular" %> fa-heart fa-xl" style="color: #000;"></i>
	                        </span>
							<span class='addCartSmallBtn'><i class="fa-solid fa-bag-shopping fa-xl" style="color: #000;" onclick="loadSmallProductDetail(<%= p.getId()%>)"></i></span>
						</div>
					</li>					
					<% }
					} %>
				</ul>
			<% } %>			
				
 			</div>
			<!--遮蔽元件外圍元件 id="modalWindow"-->
			<div id="modalWindow">

			</div>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
		</body>
		
</html>