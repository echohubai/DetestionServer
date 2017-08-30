<%--
  Created by IntelliJ IDEA.
  User: hubai
  Date: 2017/6/22
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<script>

    function showSendModal(orderId) {
        var modal = $('#modal-send');
        $('#send-OrderId').val(orderId);
        modal.modal('show');
    }

    function sendByOrderId(url) {
        var modal = $('#modal-send');
        var orderId = $('#send-OrderId').val();
        $.ajax({
            type: "POST",
            url: url + "/dealOrder/" + orderId + "/send",
            success: function (result) {
                var data = result.data;

                modal.modal('hide');
                location.reload();

                alert(data.message);

            },
            error: function (e) {
                alert(e);
            }
        });
    }
  function cancelOrderModal(orderId) {
      var modal = $('#modal-cancel');
      $('#cancel-OrderId').val(orderId);
         modal.modal('show');
  }
    function cancelByOrderId(url) {
        var modal = $('#modal-cancel');
        var orderId = $('#cancel-OrderId').val();
        $.ajax({
            type: "POST",
            url: url + "/dealOrder/" + orderId + "/cancel",
            success: function (result) {
                var data = result.data;

                modal.modal('hide');
                location.reload();

                alert(data.message);

            },
            error: function (e) {
                alert(e);
            }
        });
    }
    function showConfirmPwd() {
        var modal = $('#modal-delete');
        modal.modal('show');
    }
    function confirmPay(userId,url) {

        var pwd = $('#pwd').val();
        $.ajax({
            type: "POST",
            url: url + "/Order/"+userId+"/confirmPay",
            data: {
               pwd:pwd,
            },
            success: function (result) {
                var data = JSON.parse(result);
                var flag = data.flag;
                var msg = data.message;
                if (flag) {
                    subform();
                }
                else{
                    alert(msg);
                }

            },
            error: function (e) {
                alert(e);
            }
        });
    }
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