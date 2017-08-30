<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String contextPath = request.getContextPath();
//    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/";
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/slider.css" rel="stylesheet" type="text/css"/>
<link href="css/common.css" rel="stylesheet" type="text/css"/>
<link href="css/index.css" rel="stylesheet" type="text/css"/>

<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" />--%>
<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />--%>
<%--<!-- 下面是easyui的环境 -->--%>
<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-easyui-1.3.5/themes/icon.css" type="text/css"></link>--%>
<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-easyui-1.3.5/themes/default/easyui.css" type="text/css"></link>--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.5/jquery.min.js"></script>--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script>--%>