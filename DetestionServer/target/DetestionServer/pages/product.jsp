<%--
  Created by IntelliJ IDEA.
  User: Z674143
  Date: 2017/4/16
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<html>
<head>
    <link href="../css/product.css" rel="stylesheet" type="text/css"/>
    <link href="../css/common.css" rel="stylesheet" type="text/css"/>
    <script src="../js/jquery.min.js"></script>
    <title>Product Page</title>
<script>
    function saveCart() {
        //验证购买数量是否非法
        var count=$("#count").val();
        var inventory=$("#inventory").val();
        if(eval(count)>eval(inventory)){
            alert("库存量不足");
            return fasle;
        }
        //保存商品到购物车
        document.getElementById("cartForm").submit();
    }
</script>
</head>
<body>
<c:if test="${cartFail != null }">
    <script>alert('该物品库存不足！');</script>
</c:if>
<div class="container header">
    <div class="span5">

    </div>
    <div class="span9">
        <div class="headerAd">

        </div>
    </div>
    <%@ include file="../menu.jsp"%>
</div>

<div class="productContent container">
    <div class="span18 last">
        <div class="productImage">
            <a title="" style="outline-style: none; text-decoration: none;"
               id="zoom" rel="gallery">
                <div class="zoomPad">
                    <img style="opacity: 1;" title="商品图片" class="medium"
                         src="${ pageContext.request.contextPath }/products/<c:out value="${product.itemId}.jpg"/>"
                         />
                    <div style="display: block; top: 0px; left: 162px; width: 0px; height: 0px; position: absolute; border-width: 1px;"
                            class="zoomPup"></div>
                    <div style="position: absolute; z-index: 5001; left: 312px; top: 0px; display: block;"
                            class="zoomWindow">
                        <div style="width: 368px;" class="zoomWrapper">
                            <div style="width: 100%; position: absolute; display: none;"
                                 class="zoomWrapperTitle"></div>
                            <div style="width: 0%; height: 0px;" class="zoomWrapperImage">
                                <img src=""
                                        style="position: absolute; border: 0px none; display: block; left: -432px; top: 0px;" />
                            </div>
                        </div>
                    </div>

                    <div style="visibility: hidden; top: 129.5px; left: 106px; position: absolute;"
                            class="zoomPreload">Loading zoom</div>
                </div>
            </a>
        </div>

        <!-- 商品的具体信息 -->
        <div class="name">
             商品名称：
            <c:out value="${product.itemName}" />
        </div>
        <div class="sellername">
             卖家：
            <c:out value="${product.sellerName}" />
        </div>
        <div class="sn">
            <div>
                商品编号：
                <c:out value="${product.itemId }" />
            </div>
        </div>
        <div class="info">
            <dl>
                <dt>商品售价:</dt>
                <strong>￥<fmt:formatNumber type="number" minFractionDigits="1" value="${product.prize }" maxFractionDigits="1" />
                </strong>
            </dl>

        </div>
        <form id="cartForm" action="${ pageContext.request.contextPath }/addCart" method="post">

            <input type="hidden" name="pid"
                   value="<c:out value="${product.itemId }"/>" />

            <div class="action">
                <dl class="quantity">
                    <dt>购买数量:</dt>
                    <dd>
                        <input id="count" name="count" value="1" maxlength="5" type="number" min="1"
                               onpaste="return false;"/>
                    </dd>
                    <dd>件</dd>
                    <dd><input id="inventory" type="hidden" value="${product.count}"/></dd>
                    <dd>&nbsp&nbsp库存<c:out value="${product.count}" />件</dd>
                </dl>

                <div class="buy">
                    <input id="addCart" class="addCart" value="加入购物车" type="button"
                           onclick="saveCart()" />
                </div>
            </div>
        </form>

        <div id="bar" class="bar">
            <ul>
                <li id="introductionTab"><a href="#introduction">商品介绍</a></li>
            </ul>
        </div>
        <div id="introduction" name="introduction" class="introduction">
            <div class="title">
                <!-- 商品的描述 -->
                <strong><c:out value="${product.description }" /></strong>
            </div>
        </div>
    </div>
</div>
</div>

</body>
</html>
