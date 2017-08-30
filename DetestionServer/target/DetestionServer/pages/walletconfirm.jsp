<%--
  Created by IntelliJ IDEA.
  User: hubai
  Date: 2017/6/22
  Time: 19:55
  To change this template use File | Settings | File Templates.
--%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="../head.jsp" %>


<html>
<head>
    <script type="text/javascript" charset="utf-8" src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/supersized.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/html5.js"></script>
    <title>Pay Page</title>
</head>
<body>
<div class="page-container">
    <h1>登录</h1>
    <form>
        <input type="text" name="userName" class="username" id="userName" placeholder="请输入您的用户名！">
        <br/>
        <input type="password" name="passWord" class="password" id="passWord" placeholder="请输入您的支付密码！">
        <br/>
        <div id="loginError"  style="font-size: 16px; color:red; padding-left: 2px;width: 80%"></div>
        <br/>
        <button type="button" id="loginBtn" class="submit_button">确认支付</button>
        <br/>
        <%--<button type="button" id="resetBtn" class="submit_button">重置</button>--%>
    </form>
</div>

<script src="js/supersized.3.2.7.min.js" ></script>
<script src="js/supersized-init.js" ></script>
<script src="js/scripts.js" ></script>
</body>
<script type="text/javascript">
    $(function(){
        var data = "";
        var username = $("#userName");
        var password = $("#passWord");
        var error = $("#loginError");
        $("#loginBtn").click(function(){

            if(username.val()==null || username.val().trim()==""){
                error.text("User name cannot be empty.");
                return false;
            }

            if(password.val()==null || password.val().trim()==""){
                error.text("Password cannot be empty.");
                return false;
            }

            error.text("");

            $.ajax({
                type: "GET",
                url:  "user/login",
                dataType: "text",
                async:false,
                data: {
                    username: username.val(),
                    password: password.val(),
                },
                success: function (result) {

                    //var str1=result.toString();
                    //alert(result.message)
                    //var data = JSON.parse(result);
                    window.location = "<%=basePath%>/";
                    //alert(result.toString());
                    data = eval("("+result.userName+")");
                    // alert(data.userName);



                },
                error: function (e) {
                    alert("cannot to sever");
                }
            });

        });
    });

</script>
</html>