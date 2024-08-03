<%@page import="uuu.cs.entity.Customer"%>
<%@page import="uuu.cs.entity.VIP"%>
<%@page import="uuu.cs.entity.Product"%>
<%@page import="uuu.cs.entity.PaymentType"%>
<%@page import="uuu.cs.entity.ShippingType"%>
<%@page import="uuu.cs.entity.ShoppingCart"%>
<%@page import="uuu.cs.entity.CartItem"%>
<%@page import="java.util.Set"%>
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
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/check_out.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/cs.css">		
		
		<script>
		$(init);
		function init(){
			$("#copyButton").click(copyMemberData);
			$("select[name='shippingType']").change(shippingTypeChange);
			$("select[name='paymentType']").change(paymentTypeChange);
			<% if("POST".equals(request.getMethod())){ %>
				repopulateFormDate();
			<% } %>	
		}
		function copyMemberData(){
			$("input[name=recipientName]").val("${sessionScope.member.name}"); //sessionScope可省略
			$("input[name=recipientPhone]").val("${sessionScope.member.phone}");
			$("input[name=recipientEmail]").val("${sessionScope.member.getEmail()}"); //寫email跟getEmail()都可以, 但是在el的寫法中用屬性名稱xxx可以替代用getXxx()來讀取屬性
			//如果貨運方式選擇HOME，地址就帶入訂購人地址
			var sType = $('select[name="shippingType"]').val();
			if(sType=="HOME"){
				$("input[name=shippingAddress]").val("${sessionScope.member.getAddress()}");
			}
		}
		function shippingTypeChange(){
			//從shippingType的val()調整paymentType對應option
			twistPaymentOption();
			
			//shippingAddress與[選擇超商]/[shopslist門市選單]互動
			twistShippingAddress();
			
			//試算總金額+手續費
			calculateFeeWithTotalAmount();			
		}
		function paymentTypeChange(){
			//試算總金額+手續費
			calculateFeeWithTotalAmount();
		}
		function twistPaymentOption(){
			//從shippingType中的val()調整對應的paymentType option
			var pArrayData = $('select[name="shippingType"] option:selected').attr("data-paymentArray");
			//將所有選項設為disabled
			$('select[name="paymentType"] option').prop("disabled", true);
				//如果pArrayData不是undefined則執行if裡面的內容
				if(pArrayData != undefined){
					//把字串用,分開存入pOptions
					var pOptions = pArrayData.split(','); 
					//遍歷每個pOptions
					for(index in pOptions){  
						//將此屬性作為select[name="paymentType"] option的value，並移除disabled屬性
						$('select[name="paymentType"] option[value='+pOptions[index]+']').removeAttr("disabled");
					}
				}
				//確保第一個選項永遠是開放的
				$($('select[name="paymentType"] option')[0]).prop("disabled", false);				
		}
		function twistShippingAddress(){
			var sType = $('select[name="shippingType"]').val();		
			
			$('input[name="shippingAddress"]').removeAttr("list");	
			
			$("#chooseStoreBtn").hide();
			switch (sType){
			case 'SHOP':			
				//alert(sType);
				$('input[name=shippingAddress]').attr("list", "shopsList");
				$('input[name=shippingAddress]').attr("autocomplete", "off");
				break;
			case 'HOME':
				$('input[name=shippingAddress]').removeAttr("readonly");
				$('input[name=shippingAddress]').attr("autocomplete", "on");
				break;
			case 'STORE':
				$("#chooseStoreBtn").show();
				$('input[name=shippingAddress]').prop("readonly", true);
				$('input[name=shippingAddress]').attr("autocomplete", "off");
				$('input[name=shippingAddress]').val("");
				break;				
			}
		}
		function calculateFeeWithTotalAmount(){
			var sum = Number($("#totalAmountSpan").text()); //取得totalAmountSpan的內容並轉型成Number(以利後續運算)
			var sumVIP = Number($("#discountAmountSpan").text()); //取得totalAmountSpanVIP的內容並轉型成Number(以利後續運算)
			var sFee = Number($("select[name='shippingType'] option:selected").attr("data-fee")); //取得選中的shippingType的data-fee屬性值
			var pFee = Number($("select[name='paymentType'] option:selected").attr("data-fee")); //取得選中的paymentType的data-fee屬性值
			console.log(sum, sumVIP, sFee, pFee);

			if (!isNaN(sumVIP) && sumVIP!=0) {
			sum = sumVIP; // 如果 sumVIP 有值，則將 sum 設置為 sumVIP

			}
			if (!isNaN(sFee)) sum += sFee;
			if (!isNaN(pFee)) sum += pFee;

			$("#totalAmountWithFeeSpan").text(sum);
			$("#totalAmount").val(sum);
			
		}
		
		function repopulateFormDate(){
			$("select[name=shippingType]").val("${param.shippingType}");
			$("select[name=shippingType]").trigger("change");
			
			$("select[name=paymentType]").val("${param.paymentType}");
			$("select[name=shippingType]").trigger("change");

			$("input[name=recipientName]").val("${param.recipientName}");
			$("input[name=recipientPhone]").val("${param.recipientPhone}");
			$("input[name=recipientEmail]").val("${param.recipientEmail}");
			$("input[name=shippingAddress]").val("${param.shippingAddress}");
		}
		function getNoPhotoImg(theImg){
			theImg.src="../images/errorphoto.png";
		}
		</script>
	</head>
	<body>
		<article>
			<div class="errorsDiv">
				<p id='errorsText'>${errors}</p>
			</div>
			<!--div style="white-space:pre">
				${sessionScope.cart}
			</div-->
			<form id="cartForm" action="check_out.do" method="POST">
			<%
				ShoppingCart checkoutCart = (ShoppingCart)session.getAttribute("checkoutCart"); //獲取購物車內容
				if(checkoutCart==null || checkoutCart.isEmpty()){
			%>
			<h2>購物車是空的，請先購物後才能檢視內容!</h2>
			<%}else{ %>
			<div class="cartDiv">
			<table class="cart">
				<caption>購物車</caption>
				<thead>
					<tr>
						<td width="50px">編號</td>
						<td>名稱</td>
						<td>規格</td>
						<td>金額</td>
						<td>數量</td>
						<td>小計</td>
					</tr>
				</thead>
				<tbody>
					<%
						Set<CartItem> cartItemSet = checkoutCart.getCartItemSet();
						for(CartItem cartItem:cartItemSet){
					%>
					<tr class='cartItem'>
						<td><%= cartItem.getProductId() %></td>
						<td>
							<a href="../product_detail.jsp?productId=<%= cartItem.getProductId() %>">
							<img onerror='getNoPhotoImg(this)' class='cartItemPhoto' src='<%= cartItem.getPhotoUrl() %>'>
							<span class="productName"><%= cartItem.getProductName() %></span>
							</a>
						</td>
						<td><%= cartItem.getSpecName() %></td>
						<td>
							<div class='listPrice'>
							<% if(cartItem.getDiscountString().isEmpty()) { %>
								<%= Math.round(cartItem.getListPrice()) %></div>
							<% }else{ %>
							<%= cartItem.getListPrice() %>元<br>
							<%= cartItem.getDiscountString()%><%= Math.round(cartItem.getUnitPrice()) %>
							<% } %>
						</td>
						<td><%= checkoutCart.getQuantity(cartItem) %></td>
						<td><%= Math.round(checkoutCart.getAmount(cartItem)) %></td>
					</tr>
					<% } %>
					</tbody>
					<tfoot>
					<tr class='total_tr'>
						<%
						    Customer c = (Customer)session.getAttribute("member");
						    double subTotal = Math.round(checkoutCart.getTotalAmount());
						    double discountAmount = subTotal;
						    double totalAmount = subTotal;
						    
						    // 將總金額存儲到 session 中
						    session.setAttribute("subTotal", subTotal);
						%>
						<td colspan="4">
						<div>共<%= checkoutCart.size() %>項, <%= checkoutCart.getTotalQuantity() %>件 </div>
						</td>
						<td>
							<div><span>總金額:</span></div>
						</td>
						<td>
							<span id='totalAmountSpan'><%= Math.round(subTotal) %></span>
						</td>
					</tr>
						<%
						    if (c instanceof VIP && ((VIP)c).getDiscount() > 0) {
					            VIP vipMember = (VIP)c;
					            double discount = vipMember.getDiscount();
					            discountAmount = Math.round(subTotal * ((100 - discount) / 100));
					            totalAmount = discountAmount;
					            
					            // 將折扣後金額存儲到 session 中
					            session.setAttribute("discountAmount", discountAmount); %>	

							    <tr class='VIP'>
						        <td colspan="4" style="text-align: right;">VIP會員<%= vipMember.getDiscountString() %></td>
						        <td>折扣後金額:</td>
						        <td>
						            <div><span id='discountAmountSpan'><%= Math.round(discountAmount) %></span></div>
						        </td>
						    </tr>
					            
						 <% } else {
						    	session.setAttribute("discountAmount", subTotal);
						    } %>	
					<tr class='checkOut'>
						<td colspan="4" id="left-align">
							<span>
								<label>運送方式：</label>
								<select name="shippingType" required>
									<option value="">請選擇</option>
									<%for(ShippingType sType:ShippingType.values()) { %>
									<option value="<%= sType.name() %>" data-fee="<%= sType.getFee() %>"
										data-paymentArray="<%= sType.getPaymentTypeArrayString() %>">
										<%= sType %>
									</option>
									<% } %>
								</select>
							</span>
							<span>
								<label>付款方式：</label>
								<select name="paymentType" required>
									<option value="">請選擇</option>
									<%for(PaymentType pType:PaymentType.values()) { %>
									<option value="<%= pType.name() %>" data-fee="<%=pType.getFee() %>">
										<%= pType %>
									</option>
									<% } %>
								</select>
							</span>
						</td>	
						<td>
							<span>總金額+手續費:</span>
						</td>		
						<td>
						    <input type="hidden" name="totalAmount" id="totalAmount">
						    <span id='totalAmountWithFeeSpan'><%= Math.round(totalAmount) %></span>
						</td>								
					</tr>
					<tr>
					<tr class='checkOut'>
						<td colspan="6">
						<fieldset>
							<legend>收件人：<input id='copyButton' type="button" value="同訂購人">&nbsp;<input id="resetButton" type="reset" type="button" value="清除" style="width:50px;"></legend>
							<div><label>姓名：</label><input name="recipientName" required></div>
							<div><label>手機：</label><input type=tel name="recipientPhone" required></div>
							<div><label>Email：</label><input type=email name="recipientEmail" required></div>
							<div><label>收件地址：</label><input name="shippingAddress" required>
							<input id="chooseStoreBtn" type='button' style="display:none" value="選擇超商" onclick="goEZShip()"></div>
							<datalist id='shopsList'>
								<option>胖松鼠實體店　新北市新店區中正路270號1樓</option>
							</datalist>
						</fieldset>
						</td>
					</tr>
					<tr>
						<td colspan="6"><input type="submit" value="結帳" style="text-align:right;float:right;"></td>
					</tr>					
				</tfoot>						
			</table>
			</div>
			
			</form>		
		<script>
			function goEZShip() {//前往EZShip選擇門市
// 				if (confirm("Go EZShip前，你的網址已經改用ip Address了嗎?")) {
// 					alert("出發至EZShip[選擇超商]");
// 				} else {
// 					alert("快改網址!並重新登入與購買");
// 					return;
//                 }
				//去除文字欄位資料前後的多餘空白
				$("input[name=recipientName]").val($("input[name=recipientName]").val().trim());
				$("input[name=recipientEmail]").val($("input[name=recipientEmail]").val().trim());
				$("input[name=recipientPhone]").val($("input[name=recipientPhone]").val().trim());
				$("input[name=shippingAddress]").val($("input[name=shippingAddress]").val().trim());

				var protocol = "https"; //之後務必要改成https
				var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
				var url = protocol + "://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ezship_callback.jsp";                 
				$("#rtURL").val(url);          
				
				//$("#webPara").val($("form[action='check_out.do']").serialize());             
				
				$("#webPara").val($("#cartForm").serialize());           
// 				alert('現在網址不得為[localhost]: '+url); //測試用，測試完畢後請將此行comment           
// 				alert($("#webPara").val()) //測試用，測試完畢後請將此行comment
				
				$("#ezForm").submit();
           }
		</script>

		<form id="ezForm" method="post" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web.jsp" >
			<input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->         
			<input type="hidden" name="processID" value="VGB202107050000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->      
			<input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->       
			<input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->          
			<input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->         
			<input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->       
		</form>
		<% } %>
		</article>
		<%@ include file="/WEB-INF/subviews/footer.jsp" %>
	</body>
</html>