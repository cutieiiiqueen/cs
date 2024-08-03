<%@page import="uuu.cs.entity.VIP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page import="uuu.cs.service.ManageService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>胖松鼠-後台管理系統-會員管理</title>
		
		<!-- 子網頁sidebar -->
	    <jsp:include page="WEB-INF/subviews/sidebar.jsp" />
	    
		<style>
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
		</style>
		<script>
			$(document).ready(function() {
				var table = $('#customerTable').DataTable({
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
				// 點擊修改按鈕，呈現會員的編輯視窗
			    $('#customerTable tbody').on('click', '.edit-btn', function() {
			        var data = table.row($(this).parents('tr')).data();
			        $('#editModal input[name="email"]').val(data[0]);
			        $('#editModal input[name="password"]').val(data[1]);
			        $('#editModal input[name="phone"]').val(data[2]);
			        $('#editModal input[name="name"]').val(data[3]);
			        var genderStr = data[4];
			        var gender ="";
			        if (genderStr === '男') {
			            gender = "M";
			        } else if (genderStr === '女') {
			            gender = "F";
			        } else if (genderStr === '其他') {
			            gender = "O";
			        }
			        $('#editModal select[name="gender"]').val(gender);
			        $('#editModal input[name="birthday"]').val(data[6]);
			        $('#editModal input[name="address"]').val(data[7]);
			        $('#editModal input[name="discount"]').val(data[8]);
			        $('#editModal').modal('show');
			    });
			    
			   //修改會員
			    $('#editForm').on('submit', function(e) {
			        e.preventDefault();
			        var formData = new FormData(this);
			        formData.append("action", "updateCustomer");
			        $.ajax({
			            url: '/cs/manageCustomer.do',
			            method: 'POST',
			            data: formData,
			            processData: false, //告訴 jQuery 不要處理發送的數據，直接發送 FormData 對象本身
			            contentType: false, // 告訴jQuery不要設置Content-Type頭部，讓FormData自行設置
			            success: function(response) {
			                if (response === 'success') {
			                    alert('更新成功');
			                    location.reload(); //重新加載當前頁面
			                } else {
			                    alert('更新失敗');
			                }
			            },
			            error: function() {
			                alert('更新失敗');
			            }
			        });
			    });
			    // 點擊刪除按鈕，刪除該會員
			    $('#customerTable tbody').on('click', '.delete-btn', function() {
			        var data = table.row($(this).parents('tr')).data();
			        if (confirm('確定要刪除會員 ' + data[0] + ' 嗎？')) {
			            $.ajax({
			                url: '/cs/manageCustomer',
			                method: 'POST',
			                data: { action: 'delete', email: data[0] },
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
			    });
			});
		</script>		
	</head>
	<body>
		<div class="table-container">
		    <h3 style="font-weight:bold;text-align:center">會員管理</h3>
		    <table id="customerTable" class="table table-striped table-bordered" style="width:100%">
		        <thead>
		            <tr>
		                <th>帳號</th>
		                <th>密碼</th>
		                <th>電話</th>
		                <th>姓名</th>
		                <th>性別</th>
		                <th>年齡</th>
		                <th>生日</th>
		                <th>地址</th>
		                <th>VIP折扣</th>
		                <th>操作</th>
		            </tr>
		        </thead>
		        <tbody>
		            <%
		                ManageService manageService = new ManageService();
		                List<VIP> customersList = manageService.getAllCustomers();
		                for (VIP customer : customersList) { %>
		                    <tr>
		                    <td><%= customer.getEmail() %></td>
		                    <td><%= customer.getPassword() %></td>
		                    <td><%= customer.getPhone() %></td>
		                    <td><%= customer.getName() %></td>
							<td>
							<%
							  char gender = customer.getGender();
							  out.print(gender == 'M' ? "男" : 
							            gender == 'F' ? "女" : "其他");
							%>
							</td>
		                    <td><%= customer.getAge() %></td>
		                    <td><%= customer.getBirthday() %></td>
		                    <td><%= customer.getAddress() %></td>
		                    <td><%= customer.getDiscount() %></td>
		                    <td>
			                    <button type='button' class='btn btn-primary edit-btn'>修改</button>
			                    <button type='button' class='btn btn-danger delete-btn'>刪除</button></td>
		                    </tr>
		                <% } %>
		        </tbody>
		    </table>
		</div>
	
		<!-- 更新 -->
		<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="editModalLabel">修改會員信息</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <form id="editForm">
		        <div class="modal-body">
		          <div class="form-group">
		            <label for="email">帳號</label>
		            <input type="text" class="form-control" name="email" readonly>
		          </div>
		          <div class="form-group">
		            <label for="name">密碼</label>
		            <input type="text" class="form-control" name="password">
		          </div>
		          <div class="form-group">
		            <label for="password">電話</label>
		            <input type="text" class="form-control" name="phone">
		          </div>
		          <div class="form-group">
		            <label for="phone">姓名</label>
		            <input type="text" class="form-control" name="name">
		          </div>
		          <div class="form-group">
		            <label for="phone">性別</label>
		            <select type="text" class="form-control" name="gender">
			             <option value="M">男</option>
                         <option value="F">女</option>
                         <option value="O">其他</option>
                     </select>
		          </div>
		          <div class="form-group">
		            <label for="birthday">生日</label>
		            <input type="date" class="form-control" name="birthday">
		          </div>
		          <div class="form-group">
		            <label for="address">地址</label>
		            <input type="text" class="form-control" name="address">
		          </div>
		          	<div class="form-group">
		            <label for="discount">VIP折扣</label>
		            <input type="text" class="form-control" name="discount">
		          </div>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
		          <button type="submit" class="btn btn-primary">保存</button>
		        </div>
		      </form>
		    </div>
		  </div>
		</div>
	</body>
</html>
