<%@page import="java.util.Set"%>
<%@page import="uuu.cs.service.TrackService"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="uuu.cs.entity.Spec"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.entity.SpecialOffer"%>
<%@page import="java.awt.print.PrinterGraphics"%>
<%@page import="uuu.cs.service.ProductService"%>
<%@page import="uuu.cs.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!--根據設備的寬度自動調整-->
		<title>胖松鼠-產品明細</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="產品明細"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/product_detail.css">

		<script>
			$(document).ready(init);
			
			function init(){
				//當載入網頁時讓規格的第一個是選取狀態	
				$("select[name=spec]").change(changeSpec);
		        // 將數量的預設值設為1
		        $("#qty").val(1);
				$("#categoryList ul a").on("mouseover", categoryMouseoverHandler);
				$("#categoryList ul").on("mouseleave", categoryMouseleaveHandler);
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
			//選擇[規格]後,照片、庫存、數量上限、價格會轉換成當前選擇的
			function changeSpec(){
				var photoUrl = $("select[name=spec] option:selected").attr("data-photo");
				var listPrice = $("select[name=spec] option:selected").attr("data-listPrice");
				var price = $("select[name=spec] option:selected").attr("data-price");
				var stock = $("select[name=spec] option:selected").attr("data-stock");
				console.log(photoUrl);
				if(photoUrl){ //如果不同規格有不同的photo, 將[規格]的圖片帶入畫面
					$("#productPhoto").attr("src",photoUrl);
				}
				
				$("#listPrice").text(listPrice);
				$("#price").text(price);
				qty.max=stock;
			}
			function plusQty() {
				event.preventDefault()
			  	var qtyInt = Number($("#qty").val());
				var maxQty = Number($("#qty").attr("max"));
			  	if (isNaN(qtyInt)) {
				  	qtyInt = 0;
			  	}
		       if (qtyInt < maxQty) {
		            $("#qty").val(qtyInt + 1);
		        } else {
		            alert("數量不能超過庫存量");
		        }
			}
			function minusQty() {
				event.preventDefault()
			  	var qtyInt = Number($("#qty").val());
			  	if (isNaN(qtyInt) || qtyInt <= 1) {
					qtyInt = 1;
			  	} else {
					qtyInt--;
			  	}
			 	$("#qty").val(qtyInt);
			}
			//價格區間最小值及最大值控制
			function submitHandler() {
			    var minPrice = Number($("#minPrice").val());
			    var maxPrice = Number($("#maxPrice").val());
				//檢查
			    if (isNaN(minPrice) || isNaN(maxPrice)) alert("請輸入有效的數字！");	
			    if (minPrice < 0 || maxPrice < 0)  alert("價格不得為負值！");
			    if (minPrice > maxPrice) alert("最低價不能大於最高價！");	
			    // 提交表單
			    $("#priceForm").submit();
			}
			//當沒有照片時, 會自動帶入此張圖片
			function getNoPhotoImg(theImg){
				theImg.src="/cs/images/errorphoto.png";
			}
			
			function addToCart(){
				//send ajax
				$.ajax({
					url: $("#addCartForm").attr("action"),
					method: $("#addCartForm").attr("method"),
					data: $("#addCartForm").serialize() //把資料打包
				}).done(addToCartDoneHandler);
				
				//return false;
			}
			
			function addToCartDoneHandler(result, status, xhr){
				//alert("加入購物車成功!");
				//console.log(result);
				$(".cartNum").text(result.totalQty);
				if ($(".cartNum").text().trim() !== '') {
					$(".cartNum").show();
				}
			}
			function checkOut() {
			    var form = $("#addCartForm")[0];
			    
			    // 手動檢查表單是否有效
			    if (!form.checkValidity()) {
			        form.reportValidity();
			        return false;
			    }

			    // 創建一個新的 Promise 來處理異步操作
			    return new Promise((resolve, reject) => {
			        $.ajax({
			            url: $("#addCartForm").attr("action"),   
			            method: $("#addCartForm").attr("method"), 
			            data: $("#addCartForm").serialize()
			        }).done(function(result) {
			            // 請求成功時執行
			            addToCartDoneHandler(result);  
			            resolve(result);
			        }).fail(function(error) {
			            // 請求失敗時執行
			            reject(error);
			        });
			    }).then(() => {
			        // Promise 解析後執行
			        // 跳轉到購物車頁面
			        window.location.href = "member/cart.jsp";
			    }).catch((error) => {
			        // Promise 被拒絕時執行
			        console.error("Error adding to cart:", error);  
			        alert("添加到購物車時發生錯誤，請稍後再試。"); 
			    });

			    return false; // 防止表單默認提交
			}
			function trackHandler(isLoggedIn, isTracked, productId) {
			    if (!isLoggedIn) {
			        alert('請先登入會員');
			        window.location.href = 'login.jsp';
			        return;
			    }
			    if (isTracked) {
			        alert('此商品已在追蹤清單中');
			    } else {
			        addTrack(productId);
			    }
			}
			function addTrack(productId) {
			    $.ajax({
			        url: "track.do",
			        method: "POST",
			        data: {
			            action: "addTrack",
			            productId: productId
			        },
		            success: function(response) {
		                if(response === "success") {		                 
	                    	alert("加入追蹤清單成功");
	                    } else {
		                    alert("加入追蹤清單失敗");
			            }
		            },
		            error: function() {
		                alert("加入追蹤清單失敗");
		    		}
				});
			}
			function aleadyTrack(){
				alert("產品已在追蹤清單中!");
			}
		</script>

	</head>
	<body>
		
		<article>
			<div class="leftside">	        
				<div id="categoryList">
					<ul><h3>商品分類</h3>		
						<li class="slideForCategory"></li>
						<li><a href="<%=request.getContextPath() %>/products_list.jsp?" data-text="&nbsp;&nbsp;全部&nbsp;&nbsp;">&nbsp;&nbsp;全部&nbsp;&nbsp;</a></li>
						<li><a href="<%=request.getContextPath() %>/products_list.jsp?category=NEWEST" data-text="&nbsp;&nbsp;NEWEST&nbsp;&nbsp;">&nbsp;&nbsp;最新上架&nbsp;&nbsp;</a></li>
						<li><a href="<%=request.getContextPath() %>/products_list.jsp?category=綜合堅果" data-text="&nbsp;&nbsp;綜合堅果&nbsp;&nbsp;">&nbsp;&nbsp;綜合堅果&nbsp;&nbsp;</a></li>
						<li><a href="<%=request.getContextPath() %>/products_list.jsp?category=單品堅果" data-text="&nbsp;&nbsp;單品堅果&nbsp;&nbsp;">&nbsp;&nbsp;單品堅果&nbsp;&nbsp;</a></li>
						<li><a href="<%=request.getContextPath() %>/products_list.jsp?category=爆米香" data-text="&nbsp;&nbsp;爆米香&nbsp;&nbsp;">&nbsp;&nbsp;爆米香&nbsp;&nbsp;</a></li>
						<li><a href="<%=request.getContextPath() %>/products_list.jsp?category=果乾" data-text="&nbsp;&nbsp;果乾&nbsp;&nbsp;">&nbsp;&nbsp;果乾&nbsp;&nbsp;</a></li>
						<li><a href="<%=request.getContextPath() %>/products_list.jsp?category=其他" data-text="&nbsp;&nbsp;其他&nbsp;&nbsp;">&nbsp;&nbsp;其他&nbsp;&nbsp;</a></li>
					</ul>
					<h3>價格區間</h3>
					<form action="<%=request.getContextPath() %>/products_list.jsp" method="GET" id="priceForm">
					    <input id="minPrice" type="number" name="minPrice" min="0" placeholder="最低價" value="${param.minPrice}">
					    －
					    <input id="maxPrice" type="number" name="maxPrice" min="0" max="999999" placeholder="最高價" value="${param.maxPrice}">
					    <input id="searchbtn" type="submit" value="搜尋" onclick="submitHandler()">
					</form>
				</div>
			</div>
			<%
				String productId = request.getParameter("productId");
				ProductService pService = new ProductService();
				Product p = null;
				
				if(productId!=null){ //&& productId.matches("\\d+") 
					//int id = Integer.parseInt(productId);	因為MYSQL會幫忙檢查及轉換所以這行可以不用寫
					p = pService.getProductById(productId);
					
				}
			%>
		
			<%if(p==null){ %>
				<div>
					<h2>查無資料，請重新查詢!</h2>
				</div>
			<%}else{ %>
			
			<div class="rightside">
				<div class="rightside_top">
					<!--產品圖片(左邊)-->
					<div class="productPhotoDiv">
						<img id="productPhoto" onerror='getNoPhotoImg(this)'src="<%=p.getPhotoUrl()%>">
					</div>
				
					<!--產品簡介(右邊)-->
					<div class="productInfo">
						<div id="categoryText">
							<a href="<%=request.getContextPath() %>/products_list.jsp?category=<%=p.getCategory()%>"><%=p.getCategory()%></a>
						</div>
						<h3><%= p.getName() %></h3>
	
						<!-- div>
							<label>上架日期:</label>
							<span><%=p.getReleaseDate() %></span>
						</div-->			
						<%if(p instanceof SpecialOffer) {%>
						<div>
							<!-- 售價 -->				
							<span id="listPrice">NT <%= Product.priceFormat.format(((SpecialOffer)p).getListPrice()) %></span>
						</div>
						<% } %>
						<div>
							<!-- 打完折後的優惠價 -->
							<span id="discount"><%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %></span>
							<span id="price">NT <%= Product.priceFormat.format(p.getUnitPrice()) %></span>
							<br><br><br>
						</div>
						<div>
							<label>庫存:</label>
							<span>共<%=p.getStock() %>件</span>
							<span id="specStockSpan"></span>
						</div>
						<form id='addCartForm' method="POST" action="add_cart.do" onsubmit='addToCart(); return false;'>
							<!--將productId作為query string一起發送到request-->
							<input type="hidden" name="productId" value="<%=p.getId()%>">							
							<% if(p.getSpecList()!=null && p.getSpecList().size()>0) { %>
							    <div class="specDiv">
							        <label>規格</label>
							        <select name="spec" required>
							            <option value="">請選擇規格</option>
							            <% for(int i=0; i<p.getSpecList().size(); i++) {
							                   Spec theSpec = p.getSpecList().get(i); %>
							            <option value="<%=theSpec.getSpecName()%>" 
							                    data-stock="<%= theSpec.getStock() %>" 
							                    data-listPrice="NT <%= Product.priceFormat.format(theSpec.getListPrice()) %>" 
							                    data-price="NT <%= Product.priceFormat.format(theSpec.getPrice()) %>"
							                    <% if(theSpec.getPhotoUrl()!=null) { %>
							                    data-photo="<%= theSpec.getPhotoUrl() %>"
							                    <% } %>>
							                <%= theSpec.getSpecName() %>
							            </option>
							            <% } %>
							        </select>
							    </div>
							<% } else { %>
							    <!-- 如果沒有規格，顯示適當的訊息或者隱藏相關的 HTML 元素 -->
							    <p>此產品沒有特定的規格可供選擇。</p>
							<% } %>
							 
							<div class="qtyDiv">
								<label>數量</label>
								<button onclick="minusQty()"><i class="fa-solid fa-minus" style="color: #444444;"></i></button>
								<input id="qty" type="number" name="quantity" min="1" max="<%=p.getStock()%>" required>
								<button onclick="plusQty()"><i class="fa-solid fa-plus" style="color: #444444;"></i></button>
							</div>
							<input id="addCartBtn" type="submit" value="加入購物車">
							<input id="checkOutBtn" type="button" value="直接購買" onclick="checkOut()">
							<%
								Customer member = (Customer) session.getAttribute("member");
								TrackService trackService = new TrackService();
								Set<Integer> trackedProductIds = null;								
								boolean isLoggedIn = (member != null);
								boolean isTracked = false;
								
								if (isLoggedIn) {
								    trackedProductIds = trackService.getTrackedProductIds(member.getEmail());
									isTracked = (trackedProductIds != null && trackedProductIds.contains(p.getId()));
								}
								%>
								
								<input id="addTrackBtn" type="button" value="加入追蹤" 
								       onclick="trackHandler(<%= isLoggedIn %>, <%= isTracked %>, <%= p.getId() %>)">
						</form>
					</div> 
				</div>
				<div class="rightside_bottom">
					<!--產品描述(下面)-->
					<div id="descriptionDiv">
						<hr>
						<h2>【商品描述】</h2>
						<%=p.getDescription() %>
					</div>
					<%} %>
				</div>			
			</div>
		</article>
	</body>
	<%@ include file="/WEB-INF/subviews/footer.jsp" %>
</html>