<%@page import="java.util.ArrayList"%>
<%@page import="uuu.cs.entity.Order"%>
<%@page import="uuu.cs.entity.OrderItem"%>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.service.ManageService"%>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">

		<title>胖松鼠-後台管理系統-訂單管理</title>
		
		<!-- 子網頁sidebar -->
	    <jsp:include page="WEB-INF/subviews/sidebar.jsp" />
	    
		<style>
			#allOrdersContainer{
				box-shadow: 2px 0px 10px #000000;
			    min-width: 100vw;
			    max-width: 100vw;
			    padding: 0 50px 0 70px;
			}
			table{
				font-size: 14px;
			}
			th{
				text-align: center;
    			align-content: center;
			}
			td{
				align-content: center;
			}
			h3 {
			    font-weight: bold;
			    text-align: center;
			}
		</style>
	
	<script>
		$(document).ready(init);
		
		function init() {
			
			 var table = $('#allOrdersTable').DataTable({
				    "paging": true,  // 啟用分頁功能
				    "pageLength": 10,  // 設置每頁顯示25條記錄
				    "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "全部"]], // 定義頁面長度選擇選項
				    "info": true,  // 顯示信息摘要
				    "autoWidth": false, // 禁用自動列寬計算
				    "order": [[0, "desc"]],  // 默認按第一列（索引0）降序排序
				    "responsive": true,  // 啟用響應式設計
			    	"language": {　//中文化
			             "decimal": "",
			             "emptyTable": "沒有訂單",
			             "info": "顯示 _START_ 到 _END_ 筆，共 _TOTAL_ 筆",
			             "infoEmpty": "顯示 0 到 0 筆，共 0 筆",
			             "infoFiltered": "(從 _MAX_ 筆數據中篩選)",
			             "infoPostFix": "",
			             "thousands": ",",
			             "lengthMenu": "顯示 _MENU_ 筆",
			             "loadingRecords": "加載中...",
			             "processing": "處理中...",
			             "search": "搜尋:",
			             "zeroRecords": "沒有匹配的訂單",
			             "paginate": {
			                 "first": "第一頁",
			                 "last": "最後一頁",
			                 "next": "下一頁",
			                 "previous": "上一頁"
			             },
			             "aria": {
			                 "sortAscending": ": 升序排列",
			                 "sortDescending": ": 降序排列"
			             }
			        }
				});
	    
				// 點擊修改按鈕，呈現訂單狀態的編輯視窗
			    $('#allOrdersTable tbody ').on('click', '#editStatus', function() {
			    	//取得點擊的該行資料, 將該行的資料依序放進編輯的表單中
			        var data = table.row($(this).parents('tr')).data(); //DataTables API 方法，用來選擇特定的行
			        $('#editOrderStatusForm input[name="orderId"]').val(data[0]);
			        $('#editOrderStatusForm input[name="paymentNote"]').val(data[7]);
					$('#editOrderStatusForm input[name="shippingNote"]').val(data[9]);
					$('#editOrderStatusForm select[name="orderStatus"]').val(data[10].split(':')[0]);
			        $('#editModal').modal('show');
			    });
			
				//更新訂單狀態
			    $('#editOrderStatusForm').on('submit', function(e) {
			        e.preventDefault();
			        var formData = new FormData(this); //FormData是一個內建的API，用來創建表單數據的對象
			        
			        // 檢查FormData內容
			        for (var pair of formData.entries()) {
			            console.log(pair[0] + ': ' + pair[1]);
			        }
			        
			        $.ajax({
			            url: '/cs/updateStatus.do',
			            method: 'POST',
			            data: formData,
			            processData: false, //告訴 jQuery 不要處理發送的數據，直接發送 FormData 對象本身
			            contentType: false, // 告訴jQuery不要設置Content-Type頭部，讓FormData自行設置
			            success: function(response) {
			                if (response === 'success') {
			                    alert('更新訂單狀態成功');
			                    location.reload();
			                } else {
			                    alert('更新訂單狀態失敗: ' + response);
			                }
			            },
			            error: function(jqXHR, textStatus, errorThrown) {
			                console.error('Error:', textStatus, errorThrown);
			                alert('更新訂單狀態失敗: ' + jqXHR.responseText);
			            }
			        });
			    });
		}
	</script>
	
	<title>管理所有訂單</title>
	</head>
	<body>
	 <section>
		<div class="container" id="allOrdersContainer">
			<br>
			<br>
			<h3>管理所有訂單</h3>
	       <br>
			<%
				ManageService manageService = new ManageService();
	            List<Order> ordersList = manageService.getAllOrder();
	            request.setAttribute("ordersList", ordersList);
	        %>
			<table class="table table-sm align-middle table-bordered table-hover" id="allOrdersTable">
				<thead>
			        <tr>
				        <th width=70px>訂單編號</th>
				        <th width=100px>訂購日期</th>
				        <th width=100px>訂購人</th>			        
				        <th width=120px>訂購人電話</th>
				        <th width=220px>訂單內容</th>
				        <th width=250px>寄件資料</th>
				        <th width=110px>付款方式</th>
				        <th width=240px>付款備註</th>
				        <th width=100px>貨運方式</th>
				        <th width=100px>貨運備註</th>
				        <th width=100px>訂單狀態</th>
				        <th width=100px>操作</th>
				    </tr>
				</thead>
				<tbody>
			        <% for (Order order : ordersList) { %>
	                   <tr>
	                   <td><%= order.getId()%></td>
	                   <td><%= order.getCreatedDate()%></td>
	                   <td><%= order.getMember().getName()%></td>
	                   <td><%= order.getMember().getPhone()%></td>
	                   <td>
	                   <% double sum = 0;
	                        for (OrderItem item : order.getOrderItemSet()) {
	                            out.println(item.getProduct().getName() + " " + item.getTheSpec().getSpecName() + " x " + item.getQuantity() + "<br>");
	                            sum += item.getAmount();
	                        } %>
	                   </td>
	                   <td>
		                   收件人:<%= order.getRecipientName()%><br>
		                   收件電話:<%= order.getRecipientPhone()%><br>
		                   收件地址:<%= order.getShippingAddress()%>
	                   </td>
	                   <td><%= order.getPaymentType().getDescription()%></td>
	                   <td><%= order.getPaymentNote()==null?"":order.getPaymentNote()%></td>
	                   <td><%= order.getShippingType().getDescription()%></td>
	                   <td><%= order.getShippingNote()==null?"":order.getShippingNote()%></td>
					   <td ><% 
							switch (order.getStatus()) {
								case 0: out.println("0:新訂單"); break;
								case 1: out.println("1:已轉帳"); break;
								case 2: out.println("2:已付款"); break;
								case 3: out.println("3:已出貨"); break;
								case 4: out.println("4:已到貨"); break;
								case 5: out.println("5:已簽收"); break;
								case 6: out.println("6:已完成"); break;
							}
					        %>
						</td>
						<td>
							<button id='editStatus' class="btn btn-primary" type='button'>修改</button>						
						</td>
	                    </tr>
	                   <% } %>
				</tbody>
			</table>
			<!-- 修改訂單狀態模態框 -->
			<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content">
			            <!-- 模態框標頭 -->
			            <div class="modal-header">
			                <!-- 模態框標題 -->
			                <h5 class="modal-title" id="editModalLabel">修改訂單狀態</h5>
			                <!-- 關閉按鈕 -->
			                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			                    <span aria-hidden="true">&times;</span>
			                </button>
			            </div>
			            <!-- 模態框主要內容 -->
			            <div class="modal-body">
			                <div class="tab-content" id="editTabContent">
			                    <div class="tab-pane fade show active" id="edit-product" role="tabpanel" aria-labelledby="edit-product-tab">
			                        <form id="editOrderStatusForm" enctype="multipart/form-data">
			                            <!-- 隱藏的orderId欄位 -->
			                            <div class="form-group">
			                                <input type="hidden" class="form-control" name="orderId" readonly>
			                            </div>
			                            <!-- 付款備註 -->
			                            <div class="form-group">
			                                <label for="paymentNote">付款備註</label>
			                                <input type="text" id="paymentNote" class="form-control" name="paymentNote">
			                            </div>
			                            <!-- 貨運備註 -->
			                            <div class="form-group">
			                                <label for="shippingNote">貨運備註</label>
			                                <input type="text" id="shippingNote" class="form-control" name="shippingNote">
			                            </div>
			                            <!-- 訂單狀態 -->
			                            <div class="form-group">
			                                <label for="orderStatus">訂單狀態</label>
			                                <select id="orderStatus" class="form-control" name="orderStatus">
			                                    <option value="0">0:新訂單</option>
			                                    <option value="1">1:已轉帳</option>
			                                    <option value="2">2:已付款</option>
			                                    <option value="3">3:已出貨</option>
			                                    <option value="4">4:已到貨</option>
			                                    <option value="5">5:已簽收</option>
			                                    <option value="6">6:已完成</option>
			                                </select>
			                            </div>
			                            <!-- 模態框底部按鈕 -->
			                            <div class="modal-footer">
			                                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
			                                <button type="submit" class="btn btn-primary">更新</button>
			                            </div>
			                        </form>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	 </section>	 
	</body>
</html>