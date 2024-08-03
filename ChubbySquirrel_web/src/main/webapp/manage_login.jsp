<!-- <%@ page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
	<head>
		<title>胖松鼠-後台管理系統-登入</title>
		
		<!-- icon -->
		<link rel="icon" href="<%=request.getContextPath() %>/images/squirrel.png"/>
		
		<!-- bootstrap -->
		<link href="<%=request.getContextPath() %>/styles/bootstrap.min.css" rel="stylesheet">
		<script src="<%=request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
		
	</head>
	<body>
		<div class="container">
		    <div class="row justify-content-center">
		        <div class="col-md-4">
		            <h2 class="text-center mt-5">後台管理系統</h2>
		            <form action="manage_login" method="post">
		                <div class="form-group mb-3">
		                    <label for="username">帳號</label>
		                    <input type="text" class="form-control" id="username" name="username" required>
		                </div>
		                <div class="form-group mb-3">
		                    <label for="password">密碼</label>
		                    <input type="password" class="form-control" id="password" name="password" required>
		                </div>
		                <button type="submit" class="btn btn-primary w-100">登入</button>
		                <%
		                    String errorMessage = (String) request.getAttribute("errorMessage");
		                    if (errorMessage != null) {
		                        out.println("<div class='alert alert-danger mt-3'>" + errorMessage + "</div>");
		                    }
		                %>
		            </form>
		        </div>
		    </div>
		</div>
	</body>
</html>