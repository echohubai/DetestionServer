
<%--
  Created by IntelliJ IDEA.
  User: hubai
  Date: 2017/6/21
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../head.jsp" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>搜索结果</title>
    <link href="../css/common.css"
          rel="stylesheet" type="text/css" />
    <link href="../css/cart.css"
          rel="stylesheet" type="text/css" />
    <link href="../css/product.css"
          rel="stylesheet" type="text/css" />
</head>
<body>

<div class="container header">
    <div class="span5">

    </div>
    <div class="span9">
        <div class="headerAd">

        </div>
    </div>
    <%@ include file="../menu.jsp"%>
</div>
<div class="container cart">
    <div class="span24">
        <br/>
        <div id="contain">
            <form action="/findOrderByUid/Search" method="get" id="search_box">
                <div class="wrapper">
                    <input type="text" id="search" name="search" placeholder="请输入订单ID">
                    <button type="submit" class="search_btn">搜索</button>
                </div>
            </form>
        </div>
        <br/>
        <div>
            <ul>
                <li class="current"></li>
                <li><b>搜索结果</b></li>
            </ul>
        </div>
        <table>
            <tbody>
            <c:choose>
                <c:when test="${!empty orders}">
            <c:forEach var="order" items="${orders}">
                <tr>
                    <th colspan="5">订单编号:<c:out value="${order.orderId}" />&nbsp;&nbsp;&nbsp;&nbsp;
                        订单金额:<font color="red"><c:out value="${order.total }" /></font>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <c:if test="${order.state == 1}">
                            <a href="${ pageContext.request.contextPath }/findByOid/<c:out value="${order.orderId}" />">
                                <font color="red">待付款</font>
                            </a>
                        </c:if>
                        <c:if test="${order.state == 2}">
                            已付款
                        </c:if>
                        <c:if test="${order.state == 3}">
                            <a href="${ pageContext.request.contextPath }/updateState/<c:out value="${order.orderId}" />">确认收货</a>
                        </c:if>
                        <c:if test="${order.state == 4}">
                            交易成功
                        </c:if>
                    </th>
                </tr>
                <tr>
                    <th>图片</th>
                    <th>商品</th>
                    <th>价格</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                <c:forEach var="orderItem" items="${order.orderItems}">
                    <tr>
                        <td width="60"><a href="${ pageContext.request.contextPath }/findByPid/<c:out value="${orderItem.product.itemId}"/>">
                            <img  src="${ pageContext.request.contextPath }/products/<c:out value="${orderItem.product.id}.jpg"/>" />
                        </a></td>
                        <td><c:out value="${ orderItem.product.itemName}" /></td>
                        <td><c:out value="${orderItem.product.prize}" /></td>
                        <td class="quantity" width="60"><c:out
                                value="${orderItem.count}" /></td>
                        <td width="140"><span class="subtotal">￥<c:out
                                value="${orderItem.subtotal}" />
								</span></td>
                    </tr>
                </c:forEach>
            </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>抱歉并未查找到您要找的订单，请检查后再输入查询</p>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
