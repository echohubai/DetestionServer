<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../info_ext.jsp"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%String contextPath = request.getContextPath();%>
<html>
<head>
    <script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>
    <link href="${ pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet">
    <title>Set Info</title>

</head>
<body>
<a href="${ pageContext.request.contextPath }/">返回主页</a>
<div>
            <div>
                <h4 id="add-title">用户信息</h4>
            </div>
            <div class="panel-body">
                    <div class="form-group">
                        <label for="set-userName" class="col-sm-3 control-label">用户名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="set-userName"
                                   placeholder="请输入用户名" name="userName" value=${me.userName}>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="set-phone" class="col-sm-3 control-label">电话</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="set-phone"
                                   placeholder="请输入电话" name="phone" value=${me.phone}>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="set-address" class="col-sm-3 control-label">地址</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="set-address"
                                   placeholder="请输入常用地址" name="address" value=${me.address}>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="set-email" class="col-sm-3 control-label">邮箱</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="set-email"
                                   placeholder="请输入邮箱" name="email" value=${me.email}>
                        </div>
                    </div>
            </div>
            <div>
                <div id="loginError"  style="font-size: 16px; color:red; padding-left: 2px;width: 80%"></div>
                <br/>
                <button type="button" class="btn btn-success" onclick="setInfo('<%=contextPath%>','${sessionScope.storeUser.userId}')">修改信息</button>
                <button type="button" class="btn btn-default" onclick="showSetPwd()">修改密码</button>
            </div>
</div>


<!--修改模态框-->
<div class="modal fade bs-example-modal-sm" id="modal-delete" tabindex="-1" role="dialog" aria-labelledby="delete-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="delete-title">修改密码</h4>
            </div>
            <div class="modal-body">
                确认修改？
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="set-pwd" class="col-sm-3 control-label">输入新密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control no-border no-box-shadow" id="set-pwd"
                                   placeholder="请输入新密码" name="phone" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ensure-pwd" class="col-sm-3 control-label">确认密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control no-border no-box-shadow" id="ensure-pwd"
                                   placeholder="请再次输入密码" >
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div id="pwdError"  style="font-size: 16px; color:red; padding-left: 2px;width: 80%"></div>
                <br/>
                <button type="button" class="btn btn-default" data-dismiss="modal">退出</button>
                <button type="button" class="btn btn-danger" onclick="setPwd('${me.userId}','<%=contextPath%>')">
                    确认修改
                </button>
            </div>
        </div>
    </div>
</div>
</body>

</html>
