<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>	
		<meta charset="UTF-8">
	    <title>後臺首頁</title>   

	    <!-- 子網頁sidebar -->
	    <jsp:include page="WEB-INF/subviews/sidebar.jsp" />
	    
	    <!-- 引入 Chart.js 庫 -->
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	    
	    <style>
	    	h1, canvas{
	    		margin: 25px;
	    	}
	    </style>
	</head>
	<body>		
	    <div class="container text-center">
	        <h1> 後臺首頁 </h1>
	        <h3 id="salesStatsTitle">本月銷售統計圖</h3> 
	        <!-- 選擇月份的下拉選單 -->
	        <select id="monthSelect" class="form-control col-sm-2"></select>
	        <button id="barBtn" class="btn btn-outline-danger">切換成長條圖</button>
	        <button id="chartBtn" class="btn btn-outline-info">切換成圓餅圖</button>
	        <br/>
	        <!-- canvas 建立畫布 -->
	        <canvas id="pieChart" width="400" height="200"></canvas> 
	        <canvas id="barChart" width="400" height="200"></canvas>   
	    </div>
	
	    <script>
	    $(init);
	    
	    var pieChart; // 圓餅圖實例
	    var barChart; // 長條圖實例
	    
	    function init() {
	        // 初始化月份下拉選單
	        initMonthSelect();

	        // 事件監聽器
	        $("#monthSelect").change(onMonthSelectChange);
	        $("#barBtn").click(showBarChart);
	        $("#chartBtn").click(showPieChart);
	    }
	    
        // 初始化月份下拉選單
        function initMonthSelect() {
	    	// 獲取當前日期信息
	        var currentMonth = new Date().getMonth() + 1;
	        var currentYear = new Date().getFullYear();
	        
            for (let i = 1; i <= currentMonth; i++) {
                const option = $("<option></option>").val(i).text(currentYear+"/"+i);
                if (i === currentMonth) {
                    option.attr("selected", "selected");
                }
                $("#monthSelect").append(option);
            }
            
	        // 初始加載當前月份的圖表
	        loadStats(currentMonth);
        }

        // 月份選擇變更處理
        function onMonthSelectChange() {
            const selectedMonth = $(this).val();
            $("#salesStatsTitle").text(selectedMonth+"月 銷售統計圖");
            loadStats(selectedMonth);
        }

        // 加載圖表數據函數
        function loadStats(month) {
            $.ajax({
                url: '/cs/productStats.do',
                contentType: 'application/json',
                dataType: 'json',
                method: 'GET',
                data: { month: month },
                success: handleStatsSuccess,
                error: handleStatsError
            });
        }

        // 處理統計數據成功響應
        function handleStatsSuccess(result) {
        	//const { productNames, quantities } = result;
        	var productNames = result.productNames;
        	var quantities = result.quantities;

            // 銷毀現有圖表
            if (pieChart) pieChart.destroy();
            if (barChart) barChart.destroy();

            // 創建圓餅圖
            var ctxPie = $("#pieChart");
            pieChart = new Chart(ctxPie, {
                type: "pie",
                data: {
	                    labels: productNames,
	                    datasets: [{
	                        data: quantities,
	                        backgroundColor: getColorArray(quantities.length),
	                        borderWidth: 1
	                    }]
	                }
            });	

            // 創建長條圖
            var ctxBar = $("#barChart");
            barChart = new Chart(ctxBar, {
                type: "bar",
                data: {
	                    labels: productNames,
	                    datasets: [{
	                        label: '本月銷量',
	                        data: quantities,
	                        backgroundColor: getColorArray(quantities.length),
	                        borderWidth: 1
	                    }]
                }
            });

            // 初始化顯示狀態，顯示圓餅圖，隱藏長條圖，調整按鈕顯示狀態
            showPieChart();
        }

        // 處理統計數據錯誤響應
        function handleStatsError(err) {
            console.log(err);
        }

        // 顯示圓餅圖
        function showPieChart() {
            $('#pieChart').show();
            $('#barChart').hide();
            $('#chartBtn').hide();
            $('#barBtn').show();
        }

        // 顯示長條圖
        function showBarChart() {
            $('#pieChart').hide();
            $('#barChart').show();
            $('#chartBtn').show();
            $('#barBtn').hide();
        }

        // 獲取色彩數組函數
        function getColorArray(length) {
            const colors = [
                '#FFB3BA', '#FFDFBA', '#FFFFBA', '#BAFFC9', '#BAE1FF',
                '#F4BBFF', '#FFC3A0', '#D0F0C0', '#C4E4FF', '#F0E68C',
                '#FFD1DC', '#E6E6FA', '#FFA07A', '#98FB98', '#87CEFA',
                '#DDA0DD', '#F0FFF0', '#E0FFFF', '#FFDAB9', '#D8BFD8',
                '#FFFACD', '#F0E68C', '#B0E0E6', '#FFE4E1', '#F5DEB3',
                '#FAFAD2', '#D3D3D3', '#FFF0F5', '#E6E6FA', '#F0FFFF',
                '#F5F5DC', '#FDF5E6', '#F0F8FF', '#F8F8FF', '#FFF5EE',
                '#F5FFFA', '#FFFAF0', '#F0FFF0', '#FFFAFA', '#F5F5F5'
            ];
            return colors.slice(0, length); //會從color數組中截取一部分, 如getColorArray(5)，它會返回前5種顏色
        }
	    </script>
	</body>
</html>
