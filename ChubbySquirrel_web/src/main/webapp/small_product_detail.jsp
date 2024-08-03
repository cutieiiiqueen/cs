<%@page import="uuu.cs.entity.Spec"%>
<%@page import="uuu.cs.entity.SpecialOffer"%>
<%@page import="uuu.cs.entity.Product"%>
<%@page import="uuu.cs.service.ProductService"%>
<%@page pageEncoding="UTF-8" contentType="text/html"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- jQuery -->
		<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
		crossorigin="anonymous"></script>
		
		<!-- 字體嵌入 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100..900&display=swap" rel="stylesheet">
		
		<style>
		*{
			font-family: "Noto Sans TC", sans-serif, Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", "LiHei Pro", 
	 					"微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;
		}
		#productWindow{
		    width: 700px;
		    height: 400px;
		    border: 3px solid #444;
		    border-radius: 15px;
		    box-shadow: 5px 6px 0 #c79600;
		    display: flex;
		    background: #fff;
		    align-items: center;
		    justify-content: space-around;
		}
		#productPhoto{
			width: 300px;
			height: 300px;
		}
		.productInfo{
			display: flex;
			flex-direction: column;
			width: 320px;
		}
		.productInfo h3{
			font-size: x-large;
   			font-weight: 400;
		}
		#discount, #price{
			font-size:x-large;
			font-weight: 600;
		}
		.specDiv select{
			background-color: #f4efed;
		    cursor: pointer;
		    font-size: 1em;
		    padding: 10px;
		}
		.specDiv, .qtyDiv, #addCartBtn{
			margin-top:20px;
		}
		.qtyDiv input[type=number]::-webkit-inner-spin-button,
		.qtyDiv input[type=number]::-webkit-outer-spin-button {
		    -webkit-appearance: none;
		    margin: 0;
		}
		.qtyDiv input{
		    border: none;
		    border-bottom: .25em solid #f4efed;
		    font-size: 18px;
		    width: 50px;
		    height: 50px;			    
		    margin: 0 30px;
		    text-align: center;			    
		}
		.qtyDiv button{
		    background-color: #f4efed;
		    border: none;
		    cursor: pointer;
		    font-size: 18px;
		    height: 50px;
		    width: 50px;
		    text-align: center;		
		}
		#addCartBtn{
			width: 150px;
		    height: 50px;
		    background: rgb(255, 204, 0);
		    box-shadow: 0 6px 0 0 #c79600;
		    border: none;
		    border-radius: 6px;
		    font-size: medium;
		    font-weight: 500;
		    color: #444;
		}
		#addCartBtn:hover{
			box-shadow: 0 0 0;
			transform: translateY(5px);
			cursor: pointer;
		}
		label{
			margin: 0 10px;
		}
		.closeBtn{
		    position: relative;
		    color: #000;
		    right: -330px;
		    top: -175px;
		    border-radius: 50%;
		    background: lightgray;
		    cursor: pointer;
		    width: 30px;
		    height: 30px;
		    text-align: center;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}
		</style>
		<script>
			$(document).ready(init);
			
			function init(){
				//當載入網頁時讓規格的第一個是選取狀態	
				$("select[name=spec]").change(changeSpec);
		        // 將數量的預設值設為1
		        $("#qty").val(1);
		        $(".closeBtn").click(closeBtnClickHandler);
		        $("#minus").click(minusQty);
		        $("#plus").click(plusQty);
			}		
			function closeBtnClickHandler(){
				$("#modalWindow").css("display" , "none");			
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
		</script>
	</head>
	<body>		
		<article>
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
			<div id="productWindow">
				<!--產品圖片(左邊)-->
				<div class="productPhotoDiv">
					<img id="productPhoto" onerror='getNoPhotoImg(this)'src="<%=p.getPhotoUrl()%>">
				</div>
			
				<!--產品簡介(右邊)-->
				<!--關閉按鈕元件 class="closeBtn"-->
				<div class="closeBtn"><i class="fa-solid fa-x"></i></div>
				<div class="productInfo">
					<h3><%= p.getName() %></h3>

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
					</div>
					<form id='addCartForm' method="POST" action="/cs/add_cart.do" onsubmit='addToCart(); return false;'>
						<!--將productId作為query string一起發送到request-->
						<input type="hidden" name="productId" value="<%=p.getId()%>">
						
						<%if(p.getSpecList()!=null && p.getSpecList().size()>0) {%>
						<div class="specDiv">
						<%//TODO: 改成ul li 套用CSS%>
							<label>規格</label>
							<select name="spec" required>
							<option value="">請選擇規格</option>
							<% for(int i=0; i<p.getSpecList().size(); i++) {
								Spec theSpec = p.getSpecList().get(i);%>
							<option value="<%=theSpec.getSpecName()%>" 
									data-stock="<%= theSpec.getStock() %>" 
									data-listPrice="NT <%= Product.priceFormat.format(theSpec.getListPrice()) %>" 
									data-price="NT <%= Product.priceFormat.format(theSpec.getPrice()) %>"
									<% if(theSpec.getPhotoUrl()!=null) {%>
									data-photo="<%= theSpec.getPhotoUrl() %>"
									<%} %>>
								<%= theSpec.getSpecName() %>
							</option>
							<% } %>
							</select>		
						<%} %>
						</div>  
						<div class="qtyDiv">
							<label>數量</label>
							<button id="minus"><i class="fa-solid fa-minus" style="color: #444444;"></i></button>
							<input id="qty" type="number" name="quantity" min="<%=p.getStock()==0?0:1 %>" max="<%= p.getStock()==0?0:p.getStock() %>" required>
							<button id="plus"><i class="fa-solid fa-plus" style="color: #444444;"></i></button>
						</div>
						<input id="addCartBtn" type="submit" value="加入購物車">
					</form>
				</div>
				<%} %>
			</div>
		</article>
	</body>
</html>