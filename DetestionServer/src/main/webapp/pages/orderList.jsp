
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../head.jsp" %>
<html>
<head>
    <title>订单列表</title>
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
<c:if test="${paymentSuccess != null }">
    <script>alert('付款成功！');</script>
</c:if>
<c:if test="${paymentFalse != null }">
    <script>alert('余额不足,或未开通账户，付款失败！');</script>
</c:if>
<div class="container cart">
    <div class="span24">
        <br/>
        <div id="contain">
            <form action="Search" method="get" id="search_box">
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
                <li><b>我的订单</b></li>
            </ul>
        </div>
        <table>
            <tbody>
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
                            <font color="green">订单已经完成</font>
                        </c:if>
                        <c:if test="${order.state==5}">
                            <font color="red">订单已经被取消</font>
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
            <tr>
                <th colspan="5">
                    <div class="pagination">
								<span>第 <c:out value="${page}" />/<c:out
                                        value="${count}" />页
								</span>
                        <!-- 首页 -->
								<span><a class="firstPage"
                                         href="${pageContext.request.contextPath}/findOrderByUid/1"></a></span>
                        <c:if test="${page != 1}">
									<span><a class="previousPage"
                                             href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${page-1}"/>"></a></span>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${count }">
									<span> <!-- 如果是当前页则不能够点击 --> <c:if test="${i == page }">
                                        <span class="currentPage">${page }</span>
                                    </c:if> <c:if test="${i != page }">
											<a href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${i}"/>">
												<c:out value="${i}" />
											</a>
                                    </c:if>
									</span>
                        </c:forEach>
                        <!-- 下一页 -->
                        <c:if test="${page !=count }">
									<span><a class="nextPage"
                                             href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${page+1}"/>"></a></span>
                        </c:if>
                        <!-- 尾页 -->
                        <a class="lastPage"
                           href="${pageContext.request.contextPath}/findOrderByUid/<c:out value="${count}"/>"></a>
                    </div>
                </th>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
