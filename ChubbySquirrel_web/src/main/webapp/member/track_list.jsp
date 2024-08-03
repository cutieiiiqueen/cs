<%@page import="uuu.cs.entity.SpecialOffer"%>
<%@page import="uuu.cs.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.service.TrackService"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>胖松鼠-追蹤清單</title>
		
		<!-- 子網頁header -->
		<jsp:include page="/WEB-INF/subviews/header.jsp">
			<jsp:param name="subheader" value="追蹤清單"/>
		</jsp:include>
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/cs.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/products_list.css">
		
		<style>
				#modalWindow {
					position: fixed;
					left: 0px;
					top: 0px;
					width: 100vw;
					height: 100vh;
					background: rgba(0, 0, 0, 0.2);
					display: flex;
					align-items:center;
					justify-content:center;
					display: none;
					padding-top: 100px;
				}
		</style>
		<script>
			//移除追蹤
			$(document).ready(function() {
				$(".removeTrack").click(function() {
			        var productId = $(this).data("product-id");
			        $.ajax({
			            url: "/cs/track.do",
			            type: "POST",
			            data: { action: "removeTrack", productId: productId },
			            success: function(response) {
			                if(response === "success") {
			                    location.reload();
			                } else {
			                    alert("移除追蹤失敗");
			                }
			            },
			            error: function() {
			                alert("移除追蹤失敗");
			            }
			        });
			    });
				
			});
			function loadSmallProductDetail(productId){
			    $.ajax({
			        url:"/cs/small_product_detail.jsp?productId=" + productId,
			        method: "GET"
			    }).done(smallProductDetail_doneHandler);
			}
			
			function smallProductDetail_doneHandler(result, status, xhr){
			    $("#modalWindow").html(result);        
			    $("#modalWindow").css("display", "block");
			    
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
		<div class="center">
		    <% 
			    Customer member = (Customer) session.getAttribute("member");		  
			    
			    TrackService trackService = new TrackService();
			    List<Product> trackedProducts = trackService.getTrackedProducts(member.getEmail());
		    
			    if (trackedProducts == null || trackedProducts.isEmpty()) { %>
			        <div id="message"><h2>目前沒有追蹤的產品!</h2></div>
			    <% } else { %>
			        <ul id="productList">
			            <% for (Product p : trackedProducts) { %>
			                <li class="productItem">
			                    <a href="product_detail.jsp?productId=<%= p.getId() %>">
			                        <div class="productNameDiv"><p><%= p.getName() %></p></div>
			                        <div class="productImgDiv"><img onerror='getNoPhotoImg(this)' src="<%= p.getPhotoUrl() %>"></div>
			                        <% if (p instanceof SpecialOffer) { %>
			                            <div id="price_text">NT <%= Product.priceFormat.format(((SpecialOffer)p).getUnitPrice()) %></div>
			                        <% } else { %>
			                            <div id="price_text">NT <%= Product.priceFormat.format(p.getUnitPrice()) %></div>
			                        <% } %>
			                    </a>
			                    <div id='smallBtn'>
			                        <span class="removeTrack" data-product-id="<%= p.getId() %>"><i class="fa-solid fa-trash-can fa-xl" style="color: #000;"></i></span>
									<span class='addCartSmallBtn'><i class="fa-solid fa-bag-shopping fa-xl" style="color: #000;" onclick="loadSmallProductDetail(<%= p.getId()%>)"></i></span>
			                    </div>
			                </li>
			            <% } %>
			        </ul>
			    <% } %>
		</div>
		</article>
		
		<div id="modalWindow"></div>
		
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>