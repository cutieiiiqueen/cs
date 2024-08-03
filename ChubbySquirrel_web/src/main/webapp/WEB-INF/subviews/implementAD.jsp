<%@ page pageEncoding="UTF-8"%>
<style>
#aniBanner{
	width:163px;
	height:230px;
	border:1px solid #aaaaaa;
	padding:20px 20px 20px 7px;
	background:white;
	position:fixed;
	right:-170px;
	top:250px;
	cursor:pointer;
}
#aniBanner .left-side{
	width:13px;
	float:left;
	position:relative;
}
#aniBanner .right-side{
	width:150px;
	float:left;
	font-family:Arial, Helvetica, sans-serif;
}

#aniBanner img{
	margin-left:5px;
	width:145px;
	height:145px;

}

#aniBanner h1{
	margin:5px 20px 0px 35px;
	padding:0;
	color:#309aad;
	font-size:14px;	
}

#aniBanner p{
	padding:0;
	margin:5px 20px 0px 35px;
	color:#7a7a7a;
	font-size:12px;
	
}

#aniBanner .left-side a{
	display:block;
	overflow:hidden;
	width:10px;
	height:0;
	padding-top:19px;
	background:url(../images/arrow_in.png) no-repeat;
	
}

#aniBanner .left-side .showout-button{
	position:absolute;
	top:210px;
	left:0;
	background:url(../images/arrow_out.png) no-repeat;
}
</style>
<script type="text/javascript" src="../jquery.js"></script>
<script type="text/javascript">
	//互動廣告
	$(document).ready(init);
	function init()	{
		$("#aniBanner").click(toggleHandler);//點選#aniBanner區塊執行toggleHandler
	}
	var flag = true;
	function toggleHandler(){
		if(flag){
			$("#aniBanner").animate({right:"0px"},300);
		}else{
			$("#aniBanner").animate({right:"-170px"},300);
		}
		flag = !flag;
	}
</script> 

<div id="aniBanner">
  	<div class="left-side"> 
	  <a class="showin-button">banner in</a> 
	  <a class="showout-button">banner out</a>
  	</div>
  	<div class="rigth-side">
		<img src="..\images\products\1.jpeg">
	    <h1>招牌綜合堅果</h1>
	    <p>核桃、杏仁、腰果、南瓜子、蔓越莓</p><p>歡迎選購~</p>
  	</div>
</div>