<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <link href="../css/search.css" rel="stylesheet" type="text/css"/>
    <script src="../js/jquery.min.js"></script>
    <link href="../css/slider.css" rel="stylesheet" type="text/css"/>
    <link href="../css/common.css" rel="stylesheet" type="text/css"/>
    <link href="../css/index.css" rel="stylesheet" type="text/css"/>
    <title>Search</title>
</head>
<body>
<div class="container header">
    <div class="span5">

    </div>
    <div class="span9">
        <div class="headerAd">

        </div>
    </div>
    <jsp:include page="../menu.jsp" flush="true"/>

</div>


<div class="container index">
    <br/>
    <div id="contain">
        <form action="${ pageContext.request.contextPath }/Search" method="get" id="search_box" accept-charset="UTF-8">
            <div class="wrapper">
                <input type="text" id="search" name="search" placeholder="Search for Product">
                <button type="submit" class="search_btn"><img src="../img/search_icon.png" title="Search" /></button>
            </div>
        </form>
    </div>
    <br/>
    <div class="span24">
        <div id="hotProduct" class="hotProduct clearfix">

            <div class="title">
                <c:choose>
                    <c:when test="${!empty cname}">
                        <strong>${cname}类产品</strong>
                    </c:when>
                    <c:otherwise>
                        <strong>搜索结果</strong>
                    </c:otherwise>
                </c:choose>

            </div>
            <ul class="tab">
                <li class="current"><a href="#" target="_blank"></a></li>
                <li><a target="_blank"></a></li>
                <li><a target="_blank"></a></li>
            </ul>
                <c:choose>
                    <c:when test="${!empty sList}">
                        <ul class="tabContent" style="display: block;">
                            <c:forEach var="p" items="${sList}">
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
                    </c:when>
                    <c:otherwise>
                        <p>抱歉并未查找到您需要的商品</p>
                    </c:otherwise>
                </c:choose>

        </div>
    </div>
</div>
</body>
</html>
