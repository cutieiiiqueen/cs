<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- 字體嵌入 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    
	    <!-- 網頁icon -->
		<link rel="icon" href="<%=request.getContextPath() %>/images/squirrel.png"/>
		
		<!-- jQuery -->
		<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
		crossorigin="anonymous"></script>
		
		<!-- bootstrap -->
		<script src="<%=request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
		<link href="<%=request.getContextPath() %>/styles/bootstrap.min.css" rel="stylesheet">	
		
		<!-- dataTables 連結 -->
		<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
		<link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css" />
		
		<!-- fontawesome -->
		<script src="https://kit.fontawesome.com/a1814338bf.js" crossorigin="anonymous"></script>
		
		<style>
			.fa{
				font-weight: 900;
			    font-size: 20px;
			    width: 60px;
			    height: 36px;
			    text-align: center;
			    display: flex;
			    justify-content: center;
			    align-items: center;
			}
			.main-menu:hover,nav.main-menu.expanded {
			width:250px;
			overflow:visible;
			}
			
			.main-menu {
			background:#212121;
			border-right:1px solid #e5e5e5;
			position:absolute;
			top:0;
			bottom:0;
			height:100%;
			left:0;
			width:60px;
			overflow:hidden;
			-webkit-transition:width .05s linear;
			transition:width .05s linear;
			-webkit-transform:translateZ(0) scale(1,1);
			z-index:1000;
			position: fixed;
			}
			
			.main-menu>ul {
			margin:7px 0;
			}
			
			.main-menu li {
			position:relative;
			display:block;
			width:250px;
			}
			
			.main-menu li>a {
			position:relative;
			display:table;
			border-collapse:collapse;
			border-spacing:0;
			color:#999;
			 font-family: arial;
			font-size: 14px;
			text-decoration:none;
			-webkit-transform:translateZ(0) scale(1,1);
			-webkit-transition:all .1s linear;
			transition:all .1s linear;
			  
			}
			
			.main-menu .nav-icon {
			position:relative;
			display:table-cell;
			width:60px;
			height:36px;
			text-align:center;
			vertical-align:middle;
			font-size:18px;
			}
			
			.main-menu .nav-text {
				position: relative;
			    display: table-cell;
			    vertical-align: middle;
			    width: 190px;
			    font-family: "Noto Sans TC", sans-serif, Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", "LiHei Pro", 
	 						"微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;
			    font-size: 16px;
			    font-weight: 600;
			}
			
			.main-menu>ul.logout {
			position:absolute;
			left:0;
			bottom:0;
			}
			
			.no-touch .scrollable.hover {
			overflow-y:hidden;
			}
			
			.no-touch .scrollable.hover:hover {
			overflow-y:auto;
			overflow:visible;
			}
			
			a:hover,a:focus {
			text-decoration:none;
			}
			
			nav {
			-webkit-user-select:none;
			-moz-user-select:none;
			-ms-user-select:none;
			-o-user-select:none;
			user-select:none;
			}
			
			nav ul,nav li {
			outline:0;
			margin:0;
			padding:0;
			}
			.main-menu li:hover>a,nav.main-menu li.active>a,.dropdown-menu>li>a:hover,.dropdown-menu>li>a:focus,.dropdown-menu>.active>a,.dropdown-menu>.active>a:hover,.dropdown-menu>.active>a:focus,.no-touch .dashboard-page nav.dashboard-menu ul li:hover a,.dashboard-page nav.dashboard-menu ul li.active a {
			color:#fff;
			background-color:#5fa2db;
			}
			.area {
			float: left;
			background: #e2e2e2;
			width: 100%;
			height: 100%;
			}
			@font-face {
			  font-family: 'Titillium Web';
			  font-style: normal;
			  font-weight: 300;
			}	
		</style>
	
	</head>
	<body>
		<nav class="main-menu">
			<ul>
                <li>
                    <a href="<%=request.getContextPath() %>/">
                        <i class="fa fa-solid fa-house"></i>
                        <span class="nav-text">回首頁</span>
                    </a>                  
                </li>
	            <li class="has-subnav">
                    <a href="<%=request.getContextPath() %>/dashboard.jsp">
                        <i class="fa fa-solid fa-gauge"></i>
                        <span class="nav-text">後台首頁</span>
                    </a>
	            </li>
	            <li class="has-subnav">
                    <a href="<%=request.getContextPath() %>/manage_customer.jsp">
                       <i class="fa fa-solid fa-user"></i>
                        <span class="nav-text">會員管理</span>
                    </a>
                </li>
                <li class="has-subnav">
                    <a href="<%=request.getContextPath() %>/manage_product.jsp">
                       <i class="fa fa-solid fa-bag-shopping"></i>
                        <span class="nav-text">產品管理</span>
                    </a>
                </li>
                <li class="has-subnav">
                    <a href="<%=request.getContextPath() %>/manage_order.jsp">
					<i class="fa fa-regular fa-clipboard"></i>
                        <span class="nav-text">訂單管理</span>
                    </a>
                </li>
			</ul>	
            <ul class="logout">
                <li>
                   <a href="<%=request.getContextPath() %>/manage_login.jsp">
                        <i class="fa fa-solid fa-power-off"></i>
                        <span class="nav-text">Logout</span>
                    </a>
                </li>  
            </ul>
		</nav>
	</body>
</html>