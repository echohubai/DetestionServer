<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="span10 last">
    <div class="topNav clearfix">
        <ul>
            <!-- 若用户未登录 -->
            <c:if test="${sessionScope.storeUser == null}">
                <li id="headerLogin" class="headerLogin" style="display: list-item;">
                    <a href="${ pageContext.request.contextPath }/userLogin">登录</a>
                </li>
            </c:if>

            <!-- 若用户已登录 -->
            <c:if test="${sessionScope.storeUser != null}">
                <li id="headerLogin" class="headerLogin" style="display: list-item;">
                    <c:out value="${sessionScope.storeUser.userName }"/>
                </li>
                <li id="headerLogin" class="headerLogin" style="display: list-item;">
                    |<a href="${ pageContext.request.contextPath }/findOrderByUid/1">我的订单</a>

                </li>
                <c:choose>
                    <c:when test="${sessionScope.storeUser.loginType eq 'admin'}">
                        <li id="headerLogin" class="headerLogin" style="display: list-item;">
                            |<a href="/admin">用户管理</a>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.storeUser.loginType eq 'supplier'}">
                        <li id="headerLogin" class="headerLogin" style="display: list-item;">
                            |<a href="/supplier?userId=${sessionScope.storeUser.userId}">商品管理</a>
                        </li>
                        <li id="headerLogin" class="headerLogin" style="display: list-item;">
                            |<a href="/dealOrder?userId=${sessionScope.storeUser.userId}">订单处理</a>
                        </li>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
                <li id="headerLogin" class="headerLogin" style="display: list-item;">
                    |<a href="/user/${sessionScope.storeUser.userId}/settings">设置个人信息</a>
                </li>
                <li id="headerRegister" class="headerRegister" style="display: list-item;">
                    |<a href="${ pageContext.request.contextPath }/quit">注销</a>|
                </li>
                <li><a href="${pageContext.request.contextPath}/myCart" class="cart">购物车</a></li>
            </c:if>

            <%--<li id="headerLogin" class="headerLogin" style="display: list-item;">--%>
                <%--<a href="/">主页</a>--%>
            <%--</li>--%>

        </ul>
    </div>

</div>

<div class="span24">
    <ul class="mainNav">
        <li><a href="${ pageContext.request.contextPath }/">首页</a>|</li>
        <c:forEach items="${cList}" var="c">
            <li><a href="${ pageContext.request.contextPath }/findByCid/<c:out value="${c.cid}"/>">
                <c:out value="${c.cname}"></c:out>
            </a>
            </li>
        </c:forEach>
    </ul>
</div>