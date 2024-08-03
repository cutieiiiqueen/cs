<%@ page pageEncoding="UTF-8"%>
<%@page import="allPay.payment.integration.domain.AioCheckOutALL"%>
<%@page import="allPay.payment.integration.domain.AioCheckOutOneTime"%>
<%@page import="allPay.payment.integration.*"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="uuu.cs.entity.Customer"%>
<%@page import="uuu.cs.entity.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
    <%
        Order order = (Order) request.getAttribute("order");
        session.setAttribute("credit_card_order_id", String.valueOf(order.getId()));
        List<String> enErrors = new ArrayList<>();

        try {
            int endIndex = request.getRequestURL().indexOf("://");
            String protocol = "https";
            String ipAddress = java.net.InetAddress.getLocalHost().getHostAddress();
            String url = protocol + "://" + ipAddress + ":" + request.getLocalPort() + request.getContextPath()
                    + "/member/credit_card_back.do";

            AllInOne all = new AllInOne("");
            AioCheckOutALL obj = new AioCheckOutALL();
            obj.setChoosePayment("ALL");//必須是ALL
            obj.setClientBackURL(url);
            obj.setCreditInstallment("");
            obj.setItemName("胖松鼠信用卡-" + order.getId() + " $" + order.getTotalAmount() + "元"); //請將非常好書改成你的web site 中文/英文名稱
            obj.setMerchantID("2000132");//必須是2000132
            obj.setMerchantTradeDate(
            LocalDate.now().toString().replace('-', '/') + " " + LocalTime.now().toString().substring(0, 8));//必須是yyyy/MM/dd hh:mm:ss
            String orderIdStr = "CS" //請改成你的webapp名稱,產生一個allpay要求的訂單編號字串(必須<=20個英數字字元,且不得與之前的訂單重複)
                            + LocalDate.now().toString().replace("-", "") //會將今天的日期字串改成: 20230320(length:8)
                            + String.format("%09d", order.getId());//這裡的[07]是算出來的 4("NVGB"的length) + 8(日期字串的lenght) + 7 必須<=20

            obj.setMerchantTradeNo(orderIdStr);    
            obj.setReturnURL(url);     
            obj.setTotalAmount(String.valueOf(2)); //建議用2元來測試    
            obj.setTradeDesc("建立信用卡測試");     
            String form = all.aioCheckOut(obj, null);      
            System.out.println("form = " + form);
    %> 

<!DOCTYPE html>
<html>
   <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Credit</title>
   </head>
   <body>
    <!--這個畫面不會顯示 -->
    <%=form%>
   </body>
</html>
   <%
    } catch (Exception e) {
        // 例外錯誤處理
        e.printStackTrace();
        enErrors.add(e.getMessage());
    } finally {
        // 顯示錯誤訊息      
        if (enErrors.size() > 0) {         
            if (!enErrors.contains(null)) {        
                out.println("0|" + enErrors + "<br/>");        
            } else {           
                out.println("0|" + "交易失敗，請重新操作一次" + "<br/>");        
            }          
            out.println("<br/>");          
        }      
    }
   %>