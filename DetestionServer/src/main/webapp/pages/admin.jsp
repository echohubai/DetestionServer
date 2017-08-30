
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../head.jsp" %>
<%@include file="../admin_ext.jsp" %>
<html>
<head>
    <title>admin title</title>
</head>
<body>
<h2>管理员主页</h2>
<a href="${ pageContext.request.contextPath }/"><button class="btn-info" >返回首页</button></a>


<!--添加模态框-->
<div class="modal fade bs-example-modal-lg" id="modal-add" tabindex="-1" role="dialog" aria-labelledby="detail-title"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="add-title">添加详情</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="add-userName" class="col-sm-3 control-label">员工姓名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="add-userName"
                                   placeholder="userName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add-pwd" class="col-sm-3 control-label">登录密码</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="add-pwd"
                                   placeholder="passWord">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add-role" class="col-sm-3 control-label">登录权限</label>
                        <div class="col-sm-7">
                            <select class="form-control no-border no-box-shadow" id="add-role">
                                <option value ="normal">普通用户</option>
                                <option value ="admin">管理员</option>
                                <option value="supplier">供应商</option>
                            </select>
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
                <button type="button" class="btn btn-success" onclick="add('<%=contextPath%>')">添加</button>
            </div>
        </div>
    </div>
</div>

<div class="panel panel-default text-center">
    <div class="panel-header">
        <h2>用户列表</h2>
    </div>
    <div class="panel-body">

        <table id="table" class="table table-condensed table-bordered table-hover">
            <tr>
                <th>UserID</th>
                <th>UserName</th>
                <th>PassWord</th>
                <th>Role</th>
                <th></th>
                <th></th>
            </tr>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.userName}</td>
                    <td>${user.pwd}</td>
                    <td>${user.loginType}</td>
                    <td>
                        <button id="btn-detail" class="btn btn-primary" onclick="showdetail('<%=contextPath%>','${user.userId}')">详情
                        </button>
                    </td>
                    <td>
                        <button id="btn-delete" class="btn btn-danger" onclick="showDeleteModal('${user.userId}')">删除
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
                        <label for="detail-userId" class="col-sm-3 control-label">用户编号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-userId"
                                   placeholder="userId" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-userName" class="col-sm-3 control-label">用户姓名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-userName"
                                   placeholder="userName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-pwd" class="col-sm-3 control-label">用户密码</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-pwd"
                                   placeholder="password" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="detail-role" class="col-sm-3 control-label">权限</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="detail-role"
                                   placeholder="Role">
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
                        <label for="detail-userId" class="col-sm-3 control-label">userId</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control no-border no-box-shadow" id="delete-userId"
                                   placeholder="AppId" readonly="readonly">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="deleteByUserId('<%=contextPath%>')">
                    删除
                </button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
