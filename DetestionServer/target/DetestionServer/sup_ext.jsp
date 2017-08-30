<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/fileinput.min.css" rel="stylesheet">
<script>
    function uploadshow(url, pid) {
        var modal = $('#modal-upload');
        $('#up-pid').val(pid);
        modal.modal('show');
    }

    function showDeleteModal(itemId) {
        var modal = $('#modal-delete');
        $('#delete-itemId').val(itemId);
        modal.modal('show');
    }

    function add(url,userId,userName) {
        var modal = $('#modal-add');
        var groupId = $('#add-groupId').val();
        var itemName = $('#add-itemName').val();
        var price = $('#add-price').val();
        var count = $('#add-count').val();
        var desc = $('#add-desc').val();
        var error = $("#loginError");

        if(itemName==null || itemName.trim()==""){
            error.text("item Name cannot be empty.");
            return false;
        }

        if(price==null || price.trim()==""){
            error.text("price cannot be empty.");
            return false;
        }
        if(count==null || count.trim()==""){
            error.text("count cannot be empty.");
            return false;
        }

        $.ajax({
            type: "POST",
            url: url + "/product/add",
            data: {
                groupId: groupId,
                itemName: itemName,
                sellerName:userName,
                sellerId:userId,
                prize:price,
                description:desc,
                count:count,
            },
            success: function (result) {
                     alert(result.toString());
                    modal.modal('hide');
                    location.reload();

            },
            error: function (e) {
                alert(e);
            }
        });
    }

    function update(url) {
        var modal = $('#modal-detail');

        var pid = $('#detail-pid').val();
        var itemName = $('#detail-productName').val();
        var sellerName = $('#detail-seller').val();
        var price = $('#detail-price').val();
        var desc = $('#detail-desc').val();
        var count = $('#detail-count').val();
        $.ajax({
            type: "POST",
            url: url + "/product/" + pid + "/update",
            data: {
                itemId: pid,
                itemName: itemName,
                sellerName: sellerName,
                prize: price,
                description: desc,
                count: count,
            },
            success: function (result) {
                var mresult = JSON.parse(result);
                var data = mresult.data;
                if (mresult.flag) {
                    modal.modal('hide');
                    location.reload();
                } else {
                    alert(data);
                }
            },
            error: function (e) {
                alert(e);
            }
        });
    }


    function detail(url, itemId) {
        var modal = $('#modal-detail');
        $.ajax({
            type: "GET",
            url: url + "/product/" + itemId + "/detail",
            success: function (result) {
                var mresult = JSON.parse(result)
                var data = mresult.data;
                if (mresult.flag) {
                    $('#detail-pid').val(data.itemId);
                    $('#detail-productName').val(data.itemName);
                    $('#detail-seller').val(data.sellerName);
                    $('#detail-price').val(data.prize);
                    $('#detail-count').val(data.count);
                    $('#detail-desc').val(data.description);
                    $("#detail-pic").attr("src","products/"+data.itemId+".jpg");
                    //$('#detail-pic').val(data.imgSrc);
                    modal.modal('show');
                } else {
                    alert(mresult.flag);

                }
            },
            error: function (e) {
                alert(e);
            }
        });
    }

    function deleteByItemId(url) {
        var modal = $('#modal-delete');
        var itemId = $('#delete-itemId').val();
        $.ajax({
            type: "POST",
            url: url + "/product/" + itemId + "/delete",
            dataType: "text",
            success: function (result) {

                    modal.modal('hide');
                    location.reload();

            },
            error: function (e) {
                alert(e);
            }
        });
    }
</script>
