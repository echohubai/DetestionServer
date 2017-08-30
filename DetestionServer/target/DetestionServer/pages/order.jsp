
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../order_ext.jsp"%>
<html>
<head>
    <title>Order Page</title>
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
        <div class="step step2">
            <ul>
                <li class="current"></li>
                <li>生成订单成功</li>
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
            <em id="promotion"></em> 商品金额: <strong id="effectivePrice">￥<c:out
                value="${order.total}" />元
        </strong>
        </div>
        <form id="orderForm"
              action="${ pageContext.request.contextPath }/payOrder"
              method="post">
            <input type="hidden" name="oid"
                   value="<c:out value="${order.orderId}"/>" />
            <div class="span24">
                <p>
                    收货地址：<input name="address" id="address" type="text"
                                value="<c:out value="${order.address}"/>"
                                style="width: 350px" /><br />
                    收货人&nbsp;&nbsp;&nbsp;：<input
                        name="name" type="text" id="name"
                        value="<c:out value="${order.userName}"/>"
                        style="width: 150px" /> <br />
                    联系方式：<input name="phone" id="phone"
                                type="text" value="<c:out value="${order.phone}"/>"
                                style="width: 150px" />
                    <input name="total" type="hidden" value="${order.total}" />
                </p>
                <hr />

                <hr />
                <p style="text-align: right">
                    <a onclick="showConfirmPwd()">
                        <%--<a href="javascript:document.getElementById('orderForm').submit();">--%>
                        <img
                                src="../images/finalbutton.gif"
                                width="204" height="51" border="0" />
                    </a>
                </p>
            </div>
        </form>
    </div>

</div>
<%@include file="../head.jsp" %>
<!--修改模态框-->
<div class="modal fade bs-example-modal-sm" id="modal-delete" tabindex="-1" role="dialog" aria-labelledby="delete-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="delete-title">支付密码</h4>
            </div>
            <div class="modal-body">
                确认支付？
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="pwd" class="col-sm-3 control-label">输入支付密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control no-border no-box-shadow" id="pwd"
                                   placeholder="请输入支付密码" name="pwd" >
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div id="pwdError"  style="font-size: 16px; color:red; padding-left: 2px;width: 80%"></div>
                <br/>
                <button type="button" class="btn btn-default" data-dismiss="modal">退出</button>
                <button type="button" class="btn btn-danger" onclick="confirmPay('${me.userId}','<%=contextPath%>')">
                    确认支付
                </button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function subform(){
        var orderform = document.getElementById('orderForm');
        var phone = orderform.phone.value;
        var address = orderform.address.value;
        if(phone==null || phone.trim()==""){
            alert('请填写电话')
            return false;
        }
        if(address==null || address.trim()==""){
            alert('请填写地址')
            return false;
        }
        orderform.submit();
    }
</script>
</html>
