<%--
  Created by IntelliJ IDEA.
  User: Z674143
  Date: 2017/4/13
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../sup_ext.jsp" %>
<%@include file="../head.jsp" %>
<html>
<head>
    <title>supplier title</title>
</head>
<body>
<h2>供应商主页</h2>
<a href="${ pageContext.request.contextPath }/"><button class="btn-info" >返回首页</button></a>


<!--添加模态框-->
<div class="modal fade bs-example-modal-lg" id="modal-add" tabindex="-1" role="dialog" aria-labelledby="detail-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="add-title">添加商品详情</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="<%=contextPath%>/product/addProduct" method="post">
                    <div class="form-group">
                        <label for="add-groupId" class="col-sm-3 control-label">分类编号</label>
                        <div class="col-sm-7">
                            <select class="form-control no-border no-box-shadow" id="add-groupId">
                                <option value =1>数码电子</option>
                                <option value =2>鞋靴</option>
                                <option value=3>生活用品</option>
                                <option value=4>装饰品</option>
                                <option value=5>食品</option>
                                <option value=6>衣服</option>
                                <option value=7>运动极限</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add-itemName" class="col-sm-3 control-label">商品名称</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="add-itemName"
                                   placeholder="ItemName" name="itemName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add-price" class="col-sm-3 control-label">价格</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="add-price"
                                   placeholder="price" name="price">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add-count" class="col-sm-3 control-label">数量</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="add-count"
                                   placeholder="count" name="count">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add-desc" class="col-sm-3 control-label">商品描述</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="add-desc"
                                   placeholder="desc" name="desc">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-7">
                            <div id="loginError" style="font-size: 16px; color:red; padding-left: 2px;width: 80%"></div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" onclick="add('<%=contextPath%>',
                        '${sessionScope.storeUser.userId}','${sessionScope.storeUser.userName}')">添加</button>
            </div>
        </div>
    </div>
</div>



<%--主界面--%>
<div class="panel panel-default text-center">
    <div class="panel-header">
        <h2>商品列表</h2>
    </div>
    <div class="panel-body">
        供应商姓名：${userName}
        <table id="table" class="table table-condensed table-bordered table-hover">
            <tr>
                <th>商品编号</th>
                <th>商品名称</th>
                <th>供应商</th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
            <c:forEach var="product" items="${products}">
                <tr>
                    <td>${product.itemId}</td>
                    <td>${product.itemName}</td>
                    <td>${product.sellerName}</td>
                    <td>
                        <button id="btn-upload" class="btn btn-danger" onclick="uploadshow('<%=contextPath%>','${product.itemId}')">上传图片
                        </button>
                    </td>
                    <td>
                        <button id="btn-detail" class="btn btn-primary" onclick="detail('<%=contextPath%>','${product.itemId}')">详情
                        </button>
                    </td>
                    <td>
                        <button id="btn-delete" class="btn btn-danger" onclick="showDeleteModal('${product.itemId}')">删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<div>
    <button id="btn-add" class="btn btn-success" data-toggle="modal" data-target="#modal-add">添加</button>
</div>



<!--删除模态框-->
<div class="modal fade bs-example-modal-sm" id="modal-delete" tabindex="-1" role="dialog" aria-labelledby="delete-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="delete-title">删除</h4>
            </div>
            <div class="modal-body">
                确认删除？
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="detail-pid" class="col-sm-3 control-label">itemId</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="delete-itemId"
                                   placeholder="AppId" readonly="readonly">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="deleteByItemId('<%=contextPath%>')">
                    删除
                </button>
            </div>
        </div>
    </div>
</div>

<iframe id="id_iframe" name="id_iframe" style="display:none;"></iframe>

<!--添加图片-->
<div>
    <div class="modal fade bs-example-modal-lg" id="modal-upload" tabindex="-1" role="dialog" aria-labelledby="detail-title"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="upload-title">上传图片</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" action="<%=contextPath%>/product/addP"
                          target="id_iframe" method="post"  enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="up-pid" class="col-sm-3 control-label">商品编号</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control no-border no-box-shadow" id="up-pid"
                                       placeholder="pid" name="pid" readonly="readonly">
                            </div>
                        </div>
                        <input id="file-1" type="file" name="uploadfile" multiple class="file" data-overwrite-initial="false" data-min-file-count="5">
                        <%--<input type="button" class="btn-info" onclick="upPic('<%=contextPath%>')">确定</input>--%>
                    `   <input type="submit" class="btn btn-default">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<!--详情模态框-->
<div class="modal fade bs-example-modal-lg" id="modal-detail" tabindex="-1" role="dialog" aria-labelledby="detail-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="detail-title">查看详情</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="detail-pid" class="col-sm-3 control-label">商品编号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-pid"
                                   placeholder="userId" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-productName" class="col-sm-3 control-label">商品名称</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-productName"
                                   placeholder="userName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-price" class="col-sm-3 control-label">价格</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-price"
                                   placeholder="Role">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-count" class="col-sm-3 control-label">库存数量</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-count"
                                   placeholder="Role">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-desc" class="col-sm-3 control-label">详细描述</label>
                        <div class="col-sm-7">
                            <input type="textarea" class="form-control no-border no-box-shadow" id="detail-desc"
                                   placeholder="Role">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-pic" class="col-sm-3 control-label">缩略图</label>
                        <div class="col-sm-7">
                            <img style="display: block;" height="200" width="200" id="detail-pic">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="update('<%=contextPath%>')">修改</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
