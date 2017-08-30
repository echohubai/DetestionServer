
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <script type="text/javascript" charset="utf-8" src="js/jquery.min.js"></script>
    <link href="css/search.css" rel="stylesheet" type="text/css"/>
    <link href="css/slider.css" rel="stylesheet" type="text/css"/>
    <link href="css/common.css" rel="stylesheet" type="text/css"/>
    <link href="css/index.css" rel="stylesheet" type="text/css"/>
    <title>CMB Store</title>
</head>
<body >
<div class="container header">
    <div class="span5">

    </div>
    <div class="span9">
        <div class="headerAd">
            <h2>健康生活掌上商城</h2>
        </div>
    </div>
    <jsp:include page="menu.jsp" flush="true"/>
</div>

<div class="container index">
    <br/>
    <div id="contain">
        <form action="Search" method="get" id="search_box">
            <div class="wrapper">
                <input type="text" id="search" name="search" placeholder="Search for Product">
                <button type="submit" class="search_btn"><img src="img/search_icon.png" title="Search" /></button>
            </div>
        </form>
    </div>
    <br/>
    <div class="span24">
        <div id="hotProduct" class="hotProduct clearfix">

            <div class="title">
                <strong>热门商品</strong>
                <!-- <a  target="_blank"></a> -->
            </div>

            <ul class="tabContent" style="display: block;">
                <c:forEach var="p" items="${hList}">
                    <li><a
                            href="${pageContext.request.contextPath }/findByPid/<c:out value="${p.itemId}"/>"
                            target="_blank">
                        <img
                            src="${pageContext.request.contextPath }/products/<c:out value="${p.itemId }.jpg"/>"
                            style="display: block;"
                            height="200" width="200"/>
                        <p><c:out value="${p.itemName}  价格：${p.prize}元"/></p>
                    </a></li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="span24">
        <div id="newProduct" class="newProduct clearfix">
            <div class="title">
                <strong>最新商品</strong> <a target="_blank"></a>
            </div>

            <ul class="tabContent" style="display: block;">
                <c:forEach items="${nList }" var="p">
                    <li><a
                            href="${pageContext.request.contextPath }/findByPid/<c:out value="${p.itemId}"/>"
                            target="_blank">
                        <img
                            src="${pageContext.request.contextPath}/products/<c:out value="${p.itemId}.jpg" />"
                            style="display: block;" height="200" width="200" />
                        <p><c:out value="${p.itemName}  价格：${p.prize}元"/></p>
                    </a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>



</body>
</html>
