<%--
  Created by IntelliJ IDEA.
  User: hubai
  Date: 2017/6/22
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Comment Page</title>
    <link href="../css/common.css"
          rel="stylesheet" type="text/css" />
    <link href="../css/cart.css"
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
        <div class="step step3">
            <ul>
                <li class="current"></li>
                <li>评价商品</li>
            </ul>
        </div>
        <table>
            <tbody>
            <tr>
                <th colspan="5">订单编号:<c:out value="${order.orderId}" />&nbsp;&nbsp;&nbsp;&nbsp;
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
                    <td width="60"><img
                            src="${ pageContext.request.contextPath }/products/<c:out value="${ orderItem.product.itemId}.jpg"/>" />
                    </td>
                    <td><c:out value="${orderItem.product.itemName}" /></td>
                    <td><fmt:formatNumber type="number" minFractionDigits="1" value="${orderItem.product.prize }" maxFractionDigits="1"/></td>
                    <td class="quantity" width="60">
                        <c:out value="${orderItem.count}" /></td>
                    <td width="140"><span class="subtotal">￥
							<c:out	value="${orderItem.subtotal}" /></span></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <dl id="giftItems" class="hidden" style="display: none;">
        </dl>
        <div class="total">
            <em id="promotion"></em> 已经付款的商品金额 <strong id="effectivePrice">￥<c:out
                value="${order.total}" />元
        </strong>
        </div>
        <form id="orderForm"
              action="${ pageContext.request.contextPath }/comment"
              method="post">
            <input type="hidden" name="oid"
                   value="<c:out value="${order.orderId}"/>" />
            <div class="span16">
                <p>
                    商品评价：<input name="comment" id="comment" type="text"
                                style="width: 200px;height: 200px" /><br />
                    />
                </p>
               <button id="commentBtn" style="cursor:hand" onclick="subform()">评价订单</button>
            </div>
        </form>
    </div>

</div>
</body>
<script>
    function subform(){
        var orderform = document.getElementById('orderForm');
        var comment = orderform.comment.value;
        if (comment==null){
            alert('请填写评价');
            return false;
        }
        orderform.submit();
    }
</script>
</html>
