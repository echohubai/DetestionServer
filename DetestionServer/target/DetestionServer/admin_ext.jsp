<script>

    function add(url) {
        var modal = $('#modal-add');

        var userName = $('#add-userName').val();
        var pwd = $('#add-pwd').val();
        var role = $('#add-role').val();
        var error = $("#loginError");

        if(userName==null || userName.trim()==""){
            error.text("User name cannot be empty.");
            return false;
        }

        if(pwd==null || pwd.trim()==""){
            error.text("password cannot be empty.");
            return false;
        }

        $.ajax({
            type: "POST",
            url: url + "/administrator/add",
            data: {

                userName: userName,
                pwd: pwd,
                loginType: role,
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

    function showdetail(url, userId) {
        var modal = $('#modal-detail');
        $.ajax({
            type: "POST",
            url: url + "/administrator/" + userId + "/detail",
            success: function (result) {
                /* var str1=result.toString();
                 var obj = str.parseJSON(str1);
                 //alert(result.message)
                 s = obj.message;*/
                var data = JSON.parse(result);
                  var userName = data.data.userName;
                  var pwd = data.data.pwd;
                  var loginType=data.data.loginType;
                    $('#detail-userId').val(userId);
                    $('#detail-userName').val(userName);
                    $('#detail-pwd').val(pwd);
                    $('#detail-role').val(loginType);
                    modal.modal('show');

            },
            error: function (e) {
                alert(e);
            }
        });
    }

    function showDeleteModal(userId) {
        var modal = $('#modal-delete');
        $('#delete-userId').val(userId);
        modal.modal('show');
    }

    function deleteByUserId(url) {
        var modal = $('#modal-delete');
        var userId = $('#delete-userId').val();
        $.ajax({
            type: "POST",
            url: url + "/administrator/" + userId + "/delete",
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

    function update(url) {
        var modal = $('#modal-detail');

        var userId = $('#detail-userId').val();
        var userName = $('#detail-userName').val();
        var pwd = $('#detail-pwd').val();
        var loginType = $('#detail-role').val();
        $.ajax({
            type: "POST",
            url: url + "/administrator/" + userId + "/update",
            data: {
                userId: userId,
                userName: userName,
                pwd: pwd,
                loginType: loginType,
            },
            success: function (result) {
                   var data = JSON.parse(result);
                    modal.modal('hide');
                    location.reload();
                    alert(data.message);
                },

            error: function (e) {
                alert(e);
            }
        });
    }
</script>
