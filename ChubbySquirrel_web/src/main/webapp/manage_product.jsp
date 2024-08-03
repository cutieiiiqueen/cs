<%@page import="java.util.List"%>
<%@page import="uuu.cs.entity.Product"%>
<%@page import="uuu.cs.entity.SpecialOffer"%>
<%@page import="uuu.cs.service.ManageService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>胖松鼠-後台管理系統-產品管理</title>
		
		<!-- 子網頁sidebar -->
	    <jsp:include page="WEB-INF/subviews/sidebar.jsp" />
	
		<style>
			h3{
				font-weight: bold;
				text-align: center
			}
			.productTable{
				width: 100%;
			}
			.dataTables_filter {
				margin-bottom: 10px;
			}
			
			.dataTables_filter label input {
				width: 200px;
			}
			
			.table-container {
				margin: 50px auto;
				width: 90%;
			}
			
			img {
				max-width: 100px;
			}
			
			.add-btn-container {
				float: right;
				margin-bottom: 10px;
			}
		</style>
		<script>
		$(document).ready(init);
		
		function init() {	
			
			//datatable layout 設定
			var table = $('#productTable').DataTable({
		        "paging": true,
		        "info": true,
		        "autoWidth": false,
		        "language": {
		            "decimal": "",
		            "emptyTable": "沒有數據",
		            "info": "顯示 _START_ 到 _END_ 筆，共 _TOTAL_ 筆",
		            "infoEmpty": "顯示 0 到 0 筆，共 0 筆",
		            "infoFiltered": "(從 _MAX_ 筆數據中篩選)",
		            "infoPostFix": "",
		            "thousands": ",",
		            "lengthMenu": "顯示 _MENU_ 筆",
		            "loadingRecords": "加載中...",
		            "processing": "處理中...",
		            "search": "搜尋:",
		            "zeroRecords": "沒有匹配的數據",
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
		
			// 點擊修改按鈕，呈現產品規格與產品資訊的編輯視窗
		    $('#productTable tbody ').on('click', '.edit-btn', function() {
		    	//取得點擊的該行資料, 將該行的資料依序放進編輯的表單中
		        var data = table.row($(this).parents('tr')).data(); //DataTables API 方法，用來選擇特定的行
		        $('#editModal input[name="id"]').val(data[0]);
		        $('#editModal input[name="name"]').val(data[1]);
		        $('#editModal input[name="category"]').val(data[2]);
		        $('#editModal input[name="unitPrice"]').val(data[3]);
		        $('#editModal input[name="stock"]').val(data[4]);
		        $('#editModal input[name="releaseDate"]').val(data[5]);
		        var imgSrc = $(data[6]).attr('src'); //先標籤標籤，再從標籤提取值
		        $('#editModal input[name="photoUrl"]').val(imgSrc);
		        $('#img_edit_upload').attr('src', imgSrc);
		        $('#editModal input[name="description"]').val(data[7]);
		        $('#editModal input[name="discount"]').val(data[8]);
				
				//產品規格存放區
		        var specs = [];
				//依照產品編號查詢產品規格
		        $.ajax({
		            url: '/cs/manageProduct.do',
		            method: 'GET',
					// 產品編號
		            data: { 
		            	action: 'getSpecs', 
		            	productId: data[0] 
		            },
		            dataType: 'json',
		            success: function(response) {
		            	try {
							//存放到產品規格暫存區
		            		specs = response;
		                } catch (e) {
		                    console.error("解析 JSON 回應時發生錯誤: ", e);
		                    console.log("收到的回應: ", response);
		                }
		                console.log(specs);
		                var specSelect = $('#specNameSelect');
						//清空產品規格，保持每次都是新的
		                specSelect.empty();
		             	// 將每個產品規格加入到選單中
		                specs.forEach(function(spec) {
		                    specSelect.append(new Option(spec.specName, spec.specName));
		                });
		
						// 預設顯示第一個產品規格
		                if (specs.length > 0) {
		                    var firstSpec = specs[0];
		                    $('#specListPrice').val(firstSpec.listPrice);
		                    $('#specStock').val(firstSpec.stock);
		                    $('#specPhotoUrl').val(firstSpec.photoUrl);
		                    $('#spec_img_edit_upload').attr('src', firstSpec.photoUrl);
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error("發生錯誤: ", error);
		                console.log("回應內容: ", xhr.responseText);
		            }
		        });
		
				//選擇不同規格時，變更規格資訊
		        $('#specNameSelect').change(function() {
		            var selectedSpecName = $(this).val();
					//依規格名稱查詢產品規格
		            var selectedSpec = specs.find(spec => spec.specName === selectedSpecName);
		            if (selectedSpec) {
		                $('#specListPrice').val(selectedSpec.listPrice);
		                $('#specStock').val(selectedSpec.stock);
		                $('#specPhotoUrl').val(selectedSpec.photoUrl);
		                $('#spec_img_edit_upload').attr('src', selectedSpec.photoUrl);
		            }
		        });
		
		        $('#editModal').modal('show');
		    });
		
			//更新產品
		    $('#editForm').on('submit', function(e) {
		        e.preventDefault();
		        var formData = new FormData(this); //FormData是一個內建的API，用來創建表單數據的對象
		        formData.append("action", "update");
		        $.ajax({
		            url: '/cs/manageProduct.do',
		            method: 'POST',
		            data: formData,
		            processData: false, //告訴 jQuery 不要處理發送的數據，直接發送 FormData 對象本身
		            contentType: false, // 告訴jQuery不要設置Content-Type頭部，讓FormData自行設置
		            success: function(response) {
		                if (response === 'success') {
		                    alert('更新產品成功');
		                    location.reload(); //重新加載當前頁面
		                } else {
		                    alert('更新產品失敗');
		                }
		            },
		            error: function() {
		                alert('更新產品失敗');
		            }
		        });
		    });
			
		    //更新產品規格
		    $('#editSpecForm').on('submit', function(e) {
		        e.preventDefault();
		        var formData = new FormData(this);
		        formData.append("action", "updateSpec");
		        formData.append("productId", $('#editModal input[name="id"]').val());
		        formData.append("specName", $('#specNameSelect').val());
		        $.ajax({
		            url: '/cs/manageProduct.do',
		            method: 'POST',
		            data: formData,
		            processData: false, //告訴 jQuery 不要處理發送的數據，直接發送 FormData 對象本身
		            contentType: false, // 告訴jQuery不要設置Content-Type頭部，讓FormData自行設置
		            success: function(response) {
		                if (response === 'success') {
		                    alert('更新產品規格成功');
		                    location.reload(); //重新加載當前頁面
		                } else {
		                    alert('更新產品規格失敗');
		                }
		            },
		            error: function() {
		                alert('更新產品規格失敗');
		            }
		        });
		    });
		    
			//更新產品圖片預覽
		    $('#file_edit').change(function () {
		        var file = $("#file_edit")[0].files[0];
		        var reader = new FileReader;
		        reader.onload = function (e) {
		            $('#img_edit_upload').attr('src', e.target.result);
		        };
				//讀取圖片
		        reader.readAsDataURL(file);
		    });
			
		    //更新規格圖片預覽
		    $('#spec_file_edit').change(function () {
		        var file = $("#spec_file_edit")[0].files[0];
		        var reader = new FileReader;
		        reader.onload = function (e) {
		            $('#spec_img_edit_upload').attr('src', e.target.result);
		        };
				//讀取圖片
		        reader.readAsDataURL(file);
		    });
		    
		    
			//新增產品
		    $('#addForm').on('submit', function(e) {
		        e.preventDefault();
		        var formData = new FormData(this);
		        formData.append("action", "add");
		        $.ajax({
		            url: '/cs/manageProduct.do',
		            method: 'POST',
		            data: formData,
		            processData: false,
		            contentType: false,
		            success: function(response) {
		                if (response === 'success') {
		                    alert('新增產品成功');
		                    location.reload(); //重新加載當前頁面
		                } else {
		                    alert('新增產品失敗');
		                }
		            },
		            error: function() {
		                alert('新增產品失敗');
		            }
		        });
		    });
			
		    //新增產品規格
		    $('#addSpecForm').on('submit', function(e) {
		        e.preventDefault();
		        var formData = new FormData(this);
		        formData.append("action", "addSpec");	
		        $.ajax({
		            url: '/cs/manageProduct.do',
		            method: 'POST',
		            data: formData,
		            processData: false,
		            contentType: false,
		            success: function(response) {
		                if (response === 'success') {
		                    alert('新增規格成功');
		                    console.log(formData);
		                    location.reload();
		                } else {
		                    alert('新增規格失敗');
		                }
		            },
		            error: function() {
		                alert('新增規格失敗');
		            }
		        });
		    });		
			
			//新增產品圖片預覽
		    $('#file_add').change(function () {
		        var file = $("#file_add")[0].files[0];
		        var reader = new FileReader;
		        reader.onload = function (e) {
		            $('#img_add_upload').attr('src', e.target.result);
		        };
				//讀取圖片
		        reader.readAsDataURL(file);
		    });
			
		    //新增規格圖片預覽
		    $('#spec_file_add').change(function () {
		        var file = $("#spec_file_add")[0].files[0];
		        var reader = new FileReader;
		        reader.onload = function (e) {
		            $('#spec_img_add_upload').attr('src', e.target.result);
		        };
				//讀取圖片
		        reader.readAsDataURL(file);
		    });	    
		    
		    
			//刪除產品
		    /*$('#productTable tbody').on('click', '.delete-btn', function() {
		        var data = table.row($(this).parents('tr')).data();
		        if (confirm('確定要刪除商品 ' + data[1] + ' 嗎？')) {
		            $.ajax({
		                url: '/cs/manageProduct.do',
		                method: 'POST',
		                data: { action: 'delete', id: data[0] },
		                success: function(response) {
		                    if (response === 'success') {
		                        alert('刪除成功');
		                        location.reload();
		                    } else {
		                        alert('刪除失敗');
		                    }
		                },
		                error: function() {
		                    alert('刪除失敗');
		                }
		            });
		        }
		    });*/
			
			
		    $('#productTable').on('click', '.dropdown-item', function(e) {
	            e.preventDefault();
	            var productId = $(this).data('product-id');
	            var newStatus = $(this).data('product-status');
	            var statuText = $(this).text();            
	            if (confirm('確定要 '+ statuText +' 商品 ' + productId + ' 嗎？')) {
		            $.ajax({
		                url: '/cs/manageProduct.do',
		                method: 'POST',
		                data: { action: 'updateStatus', productId: productId, status: newStatus },
		                success: function(response) {
		                	if (response === 'success') {
		                		console.log('產品狀態更新成功');
		                        alert('產品狀態更新成功');
		                        location.reload();
		                	}else {
		                        alert('產品狀態更新失敗');
		                	}
		                },
		                error: function() {
		                    console.error('產品狀態更新失敗:', error);
		                    alert('產品狀態更新失敗');
		                }
			        });	
	            }
			});
		   
		    $('#statusFilter').on('change', function() {
		        var status = $(this).val(); // 獲取篩選選項的值
				console.log($(this).val());
		        // 使用 dataTables 的篩選功能來篩選已上架和已下架的產品
		        if (status === '') {
		            table.columns(9).search('').draw(); // 清除篩選條件並重新繪製表格
		        } else {
		        	table.column(9).search(status).draw(); // 根據篩選條件篩選並重新繪製表格
		        }
		    });
		
		}
		function quickAdd(){
			$("#addForm input[name='name']").val("草莓乾");
		    $("#addForm select[name='category']").val("果乾");
		    $("#addForm input[name='unitPrice']").val("250");
		    $("#addForm input[name='stock']").val("0");
		    $("#addForm input[name='releaseDate']").val(new Date().toISOString().split('T')[0]);
		    $("#addForm input[name='description']").val("美味可口的草莓乾");
		}
		function quickAddSpec(){
			$("#addSpecForm input[name='specName']").val("250g");
		    $("#addSpecForm input[name='listPrice']").val("250");
		    $("#addSpecForm input[name='stock']").val("20");
		}
		function getNoPhotoImg(theImg){
			theImg.src="/cs/images/errorphoto.png";
		}
		</script>

	</head>
	<body>
		<div class="table-container">

			<h3>產品管理</h3>
			
			<!-- 新增產品/規格按鈕 -->
			<div class="add-btn-container">
				<button type="button" class="btn btn-warning" data-toggle="modal"
					data-target="#addModal">新增產品/規格</button>
			</div>
			<!-- 狀態篩選 -->
			<div class="filter-container mb-3">產品狀態:
			    <select id="statusFilter" class="form-select">			    	
			        <option value="">全部狀態</option>
			        <option value="上架中">上架中</option>
			        <option value="已下架">已下架</option>
			    </select>
			</div>
			<!-- 表格 -->
			<table id="productTable" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th width="9%">產品編號</th>
						<th>產品名稱</th>
						<th>產品分類</th>
						<th>定價</th>
						<th>庫存</th>
						<th>上架日期</th>
						<th>圖片</th>
						<th width="14%">描述</th>
						<th>折扣</th>
						<th>狀態</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<%
					ManageService manageService = new ManageService();
					List<Product> productList = manageService.getProducts();
					for (Product product : productList) { 
						int discount = 0;
						Double unitPrice = product.getUnitPrice();
						if (product instanceof SpecialOffer) {
							discount = ((SpecialOffer) product).getDiscount();
							unitPrice = ((SpecialOffer) product).getListPrice();
						}
						%>
						<tr class="product-row">
						<td><%= product.getId() %></td>
						<td><%= product.getName() %></td>
						<td><%= product.getCategory() %></td>
						<td><%= unitPrice %></td>
						<td><%= product.getStock() %></td>
						<td><%= product.getReleaseDate() %></td>
						<td><img onerror='getNoPhotoImg(this)' src="<%= product.getPhotoUrl()%>" alt='Product Image'></td>
						<td><%= product.getDescription() %></td>
						<td><%= discount %></td>
						<td>
							<div class="dropdown" value="">
							  <button class="btn btn-success dropdown-toggle" type="button" 
   									  id="dropdownMenuButton_<%= product.getId() %>" 
									  data-toggle="dropdown" 
									  aria-haspopup="true" 
									  aria-expanded="false"
									  data-status="<%= product.getStatus() %>">
							    <%
							    switch (product.getStatus()) {
							      case 0: out.println("上架中"); break;
							      case 1: out.println("已下架"); break;
							    }
							    %>
							  </button>
							  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_<%= product.getId() %>">
							    <a class="dropdown-item" href="#" data-product-id="<%= product.getId() %>" data-product-status="0">上架</a>
							    <a class="dropdown-item" href="#" data-product-id="<%= product.getId() %>" data-product-status="1">下架</a>
							  </div>
							</div>											
						</td>
						<td>
							<button type='button' class='btn btn-primary edit-btn'>修改</button>
							<!-- button type='button' class='btn btn-danger delete-btn'>刪除</button-->
						</td>
						</tr>
					<% } %>				
				</tbody>
			</table>
		</div>
		
		<!-- 新增產品/規格模態框 -->
		<!-- Modal -->
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <!-- 模態框標頭 -->
		            <div class="modal-header">
		                <!-- 模態框標題 -->
		                <h5 class="modal-title" id="addModalLabel">新增產品/規格</h5>
		                <!-- 關閉按鈕 -->
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <!-- 模態框主要內容 -->
		            <div class="modal-body">
		                <!-- 選項卡導航 -->
		                <ul class="nav nav-tabs" id="myTab" role="tablist">
		                    <!-- 第一個選項卡 - 產品資訊 -->
		                    <li class="nav-item">
		                        <a class="nav-link active" id="product-tab" data-toggle="tab" href="#product" role="tab"
		                           aria-controls="product" aria-selected="true">產品資訊</a>
		                    </li>
		                    <!-- 第二個選項卡 - 產品規格 -->
		                    <li class="nav-item">
		                        <a class="nav-link" id="spec-tab" data-toggle="tab" href="#spec" role="tab"
		                           aria-controls="spec" aria-selected="false">產品規格</a>
		                    </li>
		                </ul>
		                <!-- 選項卡內容 -->
		                <div class="tab-content" id="myTabContent">
		                    <!-- 第一個選項卡內容 - 產品資訊 -->
		                    <div class="tab-pane fade show active" id="product" role="tabpanel" aria-labelledby="product-tab">
		                        <form id="addForm" enctype="multipart/form-data">
		                            <!-- 產品名稱 -->
		                            <div class="form-group">
		                                <label for="name">產品名稱</label>
		                                <input type="text" class="form-control" name="name">
		                            </div>
		                            <!-- 產品分類 -->
		                            <div class="form-group">
		                                <label for="category">產品分類</label>
		                                <select class="form-control" name="category">
		                                    <option value="綜合堅果">綜合堅果</option>
		                                    <option value="單品堅果">單品堅果</option>
		                                    <option value="爆米香">爆米香</option>
		                                    <option value="果乾">果乾</option>
		                                    <option value="其他">其他</option>
		                                </select>
		                            </div>
		                            <!-- 定價 -->
		                            <div class="form-group">
		                                <label for="unitPrice">定價</label>
		                                <input type="number" class="form-control" name="unitPrice">
		                            </div>
		                            <!-- 庫存 -->
		                            <div class="form-group">
		                                <label for="stock">庫存</label>
		                                <input type="number" class="form-control" name="stock">
		                            </div>
		                            <!-- 上架日期 -->
		                            <div class="form-group">
		                                <label for="releaseDate">上架日期</label>
		                                <input type="date" class="form-control" name="releaseDate" max>
		                            </div>
		                            <!-- 圖片上傳 -->
		                            <div class="form-group">
		                                <label for="photoUrl">圖片</label><br>
		                                <input type='file' id="file_add" name="postImage" class="btn-secondary mt-2" style="max-width: 200px" />
		                                <div class="container mt-2">
		                                    <img id="img_add_upload" style="max-width: 200px;" accept="image/*" />
		                                </div>
		                            </div>
		                            <!-- 描述 -->
		                            <div class="form-group">
		                                <label for="description">描述</label>
		                                <input type="text" class="form-control" name="description">
		                            </div>
		                            <!-- 模態框底部按鈕 -->
		                            <div class="modal-footer">
		                                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		                                <button type="submit" class="btn btn-primary">送出</button>
		                                <button type="button" class="btn btn-light" onclick="quickAdd()">快速新增</button>
		                            </div>
		                        </form>
		                    </div>
		                    <!-- 第二個選項卡內容 - 產品規格 -->
		                    <div class="tab-pane fade" id="spec" role="tabpanel" aria-labelledby="spec-tab">
		                        <form id="addSpecForm" enctype="multipart/form-data">
		                            <!-- 產品名稱下拉選單 -->
		                            <div class="form-group">
		                                <label for="productId">產品名稱</label>
		                                <select class="form-control" name="productId">
		                                    <!-- 使用Java迴圈動態生成選項 -->
		                                    <%
		                                    for (Product product : productList) { %>
		                                        <option value="<%= product.getId() %>"><%= product.getName() %></option>
		                                    <% } %>
		                                </select>
		                            </div>
		                            <!-- 產品規格 -->
		                            <div class="form-group">
		                                <label for="specName">產品規格</label>
		                                <input type="text" class="form-control" name="specName">
		                            </div>
		                            <!-- 單價 -->
		                            <div class="form-group">
		                                <label for="listPrice">單價</label>
		                                <input type="number" class="form-control" name="listPrice">
		                            </div>
		                            <!-- 庫存 -->
		                            <div class="form-group">
		                                <label for="stock">庫存</label>
		                                <input type="number" class="form-control" name="stock">
		                            </div>
		                            <!-- 圖片上傳 -->
		                            <div class="form-group">
		                                <label for="photoUrl">圖片</label><br>
		                                <input type='file' id="spec_file_add" name="postImage" class="btn-secondary mt-2" style="max-width: 200px" />
		                                <div class="container mt-2">
		                                    <img id="spec_img_add_upload" style="max-width: 200px;" accept="image/*" />
		                                </div>
		                            </div>
		                            <!-- 模態框底部按鈕 -->
		                            <div class="modal-footer">
		                                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		                                <button type="submit" class="btn btn-primary">送出</button>
		                                <button type="button" class="btn btn-light" onclick="quickAddSpec()">快速新增</button>
		                            </div>
		                        </form>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
		<!-- 修改產品/規格模態框 -->
		<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <!-- 模態框標頭 -->
		            <div class="modal-header">
		                <!-- 模態框標題 -->
		                <h5 class="modal-title" id="editModalLabel">修改產品</h5>
		                <!-- 關閉按鈕 -->
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <!-- 模態框主要內容 -->
		            <div class="modal-body">
		                <!-- 選項卡導航 -->
		                <ul class="nav nav-tabs" id="editTab" role="tablist">
		                    <!-- 第一個選項卡 - 產品資訊 -->
		                    <li class="nav-item">
		                        <a class="nav-link active" id="edit-product-tab" data-toggle="tab" href="#edit-product" role="tab"
		                           aria-controls="edit-product" aria-selected="true">產品資訊</a>
		                    </li>
		                    <!-- 第二個選項卡 - 產品規格 -->
		                    <li class="nav-item">
		                        <a class="nav-link" id="edit-spec-tab" data-toggle="tab" href="#edit-spec" role="tab"
		                           aria-controls="edit-spec" aria-selected="false">產品規格</a>
		                    </li>
		                </ul>
		                <!-- 選項卡內容 -->
		                <div class="tab-content" id="editTabContent">
		                    <!-- 第一個選項卡內容 - 產品資訊 -->
		                    <div class="tab-pane fade show active" id="edit-product" role="tabpanel" aria-labelledby="edit-product-tab">
		                        <form id="editForm" enctype="multipart/form-data">
		                            <!-- 隱藏的產品ID欄位 -->
		                            <div class="form-group">
		                                <input type="text" class="form-control" name="id" readonly hidden>
		                            </div>
		                            <!-- 產品名稱 -->
		                            <div class="form-group">
		                                <label for="name">產品名稱</label>
		                                <input type="text" class="form-control" name="name">
		                            </div>
		                            <!-- 產品分類 -->
		                            <div class="form-group">
		                                <label for="category">產品分類</label>
		                                <select class="form-control" name="category">
		                                    <option value="綜合堅果">綜合堅果</option>
		                                    <option value="單品堅果">單品堅果</option>
		                                    <option value="爆米香">爆米香</option>
		                                    <option value="果乾">果乾</option>
		                                    <option value="其他">其他</option>
		                                </select>
		                            </div>
		                            <!-- 定價 -->
		                            <div class="form-group">
		                                <label for="unitPrice">定價</label>
		                                <input type="number" class="form-control" name="unitPrice">
		                            </div>
		                            <!-- 庫存 -->
		                            <div class="form-group">
		                                <label for="stock">庫存</label>
		                                <input type="number" class="form-control" name="stock">
		                            </div>
		                            <!-- 上架日期 -->
		                            <div class="form-group">
		                                <label for="releaseDate">上架日期</label>
		                                <input type="date" class="form-control" name="releaseDate">
		                            </div>
		                            <!-- 圖片相關 -->
		                            <div class="form-group">
		                                <label for="photoUrl">圖片</label>
		                                <!-- 顯示圖片路徑的隱藏欄位 -->
		                                <input type="text" class="form-control" name="photoUrl" readonly hidden>
		                                <br>
		                                <!-- 上傳圖片的按鈕 -->
		                                <input type='file' id="file_edit" name="postImage" class="btn-secondary mt-2" style="max-width: 200px" />
		                                <div class="container mt-2">
		                                    <!-- 顯示上傳的圖片 -->
		                                    <img id="img_edit_upload" style="max-width: 200px;" accept="image/*" />
		                                </div>
		                            </div>
		                            <!-- 描述 -->
		                            <div class="form-group">
		                                <label for="description">描述</label>
		                                <input type="text" class="form-control" name="description">
		                            </div>
		                            <!-- 折扣 -->
		                            <div class="form-group">
		                                <label for="discount">折扣</label>
		                                <input type="number" class="form-control" name="discount">
		                            </div>
		                            <!-- 模態框底部按鈕 -->
		                            <div class="modal-footer">
		                                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		                                <button type="submit" class="btn btn-primary">更新</button>
		                            </div>
		                        </form>
		                    </div>
		                    <!-- 第二個選項卡內容 - 產品規格 -->
		                    <div class="tab-pane fade" id="edit-spec" role="tabpanel" aria-labelledby="edit-spec-tab">
		                        <form id="editSpecForm" enctype="multipart/form-data">
		                            <!-- 產品規格下拉選單 -->
		                            <div class="form-group">
		                                <label for="specName">產品規格</label>
		                                <select class="form-control" name="specName" id="specNameSelect">
		                                    <!-- 使用JavaScript動態生成選項 -->
		                                </select>
		                            </div>
		                            <!-- 單價 -->
		                            <div class="form-group">
		                                <label for="specListPrice">單價</label>
		                                <input type="number" class="form-control" name="listPrice" id="specListPrice">
		                            </div>
		                            <!-- 庫存 -->
		                            <div class="form-group">
		                                <label for="specStock">庫存</label>
		                                <input type="number" class="form-control" name="stock" id="specStock">
		                            </div>
		                            <!-- 圖片相關 -->
		                            <div class="form-group">
		                                <label for="specPhotoUrl">圖片</label>
		                                <!-- 顯示圖片路徑的隱藏欄位 -->
		                                <input type="text" class="form-control" name="photoUrl" id="specPhotoUrl" readonly hidden>
		                                <br>
		                                <!-- 上傳圖片的按鈕 -->
		                                <input type='file' id="spec_file_edit" name="postImage" class="btn-secondary mt-2" style="max-width: 200px" />
		                                <div class="container mt-2">
		                                    <!-- 顯示上傳的圖片 -->
		                                    <img id="spec_img_edit_upload" style="max-width: 200px;" accept="image/*" />
		                                </div>
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
	</body>
</html>