<%--
  Created by IntelliJ IDEA.
  User: hubai
  Date: 2017/6/21
  Time: 19:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../head.jsp" %>
<%@include file="../order_ext.jsp"%>

<html>
<head>
    <title>订单列表</title>
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
<div class="panel panel-default text-center">
    <div class="panel-header">
        <h2>订单列表</h2>
    </div>
    <div class="panel-body">

        <table id="table" class="table table-condensed table-bordered table-hover">
            <tr>
                <th>订单ID</th>
                <th>用户名</th>
                <th>用户地址</th>
                <th>用户电话</th>
                <th></th>
                <th></th>
            </tr>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.orderId}</td>
                    <td>${order.userName}</td>
                    <td>${order.address}</td>
                    <td>${order.phone}</td>
                    <td>
                        <c:if test="${order.state!=4}">
                        <button id="btn-detail" class="btn btn-primary"  onclick="cancelOrderModal('${order.orderId}')">取消订单
                        </button>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${order.state==1}">
                            <button id="upay" style="cursor:hand"  disabled="true">未付款</button>
                        </c:if>
                        <c:if test="${order.state==2}">
                            <button id="btn-send"  style="cursor: hand" onclick="showSendModal('${order.orderId}')" > 发货</button>
                        </c:if>

                            <c:if test="${order.state==3}">
                                <button id="sended" style="cursor:hand" value="已发货" disabled="true">已发货</button>
                            </c:if>
                        <c:if test="${order.state==4}">
                            <font color="green">买家已确认收货</font>
                        </c:if>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<!--发货模态框-->
<div class="modal fade bs-example-modal-sm" id="modal-send" tabindex="-1" role="dialog" aria-labelledby="send-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="send-title">发货</h4>
            </div>
            <div class="modal-body">
                确认发货？
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="send-OrderId" class="col-sm-3 control-label">确认信息</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="send-OrderId"
                                   placeholder="AppId" readonly="readonly">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="sendByOrderId('<%=contextPath%>')">
                    发货
                </button>
            </div>
        </div>
    </div>
</div>
<!--取消订单模态框-->
<div class="modal fade bs-example-modal-sm" id="modal-cancel" tabindex="-1" role="dialog" aria-labelledby="cancel-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="cancel-title">取消订单</h4>
            </div>
            <div class="modal-body">
                取消订单？
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="send-OrderId" class="col-sm-3 control-label">确认信息</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="cancel-OrderId"
                                   placeholder="AppId" readonly="readonly">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消该操作</button>
                <button type="button" class="btn btn-danger" onclick="cancelByOrderId('<%=contextPath%>')">
                    取消订单
                </button>
            </div>
        </div>
    </div>
</div>
<th colspan="5">
    <div class="pagination">
								<span>第 <c:out value="${page}" />/<c:out
                                        value="${count}" />页
								</span>
</body>
</html>
