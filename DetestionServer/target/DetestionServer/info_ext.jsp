<script>
    function setInfo(url,userId) {
        var userName = $('#set-userName').val();
        var phone = $('#set-phone').val();
        var address = $('#set-address').val();
        var email = $('#set-email').val();
        $.ajax({
            type: "POST",
            url: url + "/user/"+userId+"/setInfo",
            data: {
                userName: userName,
                phone: phone,
                address:address,
                email:email,
            },
            success: function (result) {

                    $('#loginError').text("success");
                    alert("success");
                    location.reload();

            },
            error: function (e) {
                alert(e);
            }
        });
    }

    function showSetPwd() {
        var modal = $('#modal-delete');
        modal.modal('show');
    }

    function setPwd(userId,url) {
        var pwd = $('#set-pwd').val();
        var ensure = $('#ensure-pwd').val();
        if(pwd!=ensure){
            $('#pwdError').text("passwords are different");
            return false;
        }
        $.ajax({
            type: "POST",
            url: url + "/user/"+userId+"/setPwd",
            data: {
                pwd: pwd,
            },
            success: function (result) {

                    $('#pwdError').text("success");
                    alert("修改成功");
                    location.reload();

            },
            error: function (e) {
                alert(e);
            }
        });
    }
</script>
