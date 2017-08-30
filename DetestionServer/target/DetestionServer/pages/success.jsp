<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>支付结果</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
        *{
            margin:0;
            padding: 0;
        }
        h2{
          text-align: center;
          margin-top: 150px;
        }
        p{
            text-align: center;
        }
        #logo{
            position: absolute;
            top:30px;
            left:50%;
            margin-left:-89px;
        }
        #right{
            width:20px;

        }
        span{
            display: block;
            text-align: center;
        }
        a{
            display: block;
            text-align: center;
            text-decoration: none;
        }
    </style>
    <script>
       window.onload=function(){
           timer=setTimeout(calc,1000);
       }
       var timer=null;
       function calc(){
           var span=document.querySelector("span");
           var n=parseInt(span.innerHTML)-1;
           span.innerHTML=n+span.innerHTML.slice(1);
           if(n>0){
               timer=setTimeout(calc,1000);
           }else{
               window.location="<%=basePath%>/";
           }
       }
       function stop(){
           clearTimeout(timer);
           timer=null;
       }
     </script>
  </head>
  
  <body>
<h2><img src="../images/success.png" alt="" id="right">
    您已经成功完成支付!</h2>
<p>订单已被支付,请勿重复支付</p>
<span>3秒钟后自动返回首页</span>

</body>
</html>
