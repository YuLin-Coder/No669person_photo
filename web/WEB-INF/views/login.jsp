<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人相册管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>


<form id="loginForm" name="loginForm">
    <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
        <div class="layadmin-user-login-main">
            <div class="layadmin-user-login-box layadmin-user-login-header">
                <h2>个人相册管理系统</h2>

            </div>
            <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-tabsName"></label>
                    <input type="text" name="username" lay-verify="username" id="username" placeholder="用户名"
                           class="layui-input">
                </div>

                <div class="layui-form-item">
                    <label class="layadmin-user-login-icon layui-icon layui-icon-password"></label>
                    <input type="password" name="password" lay-verify="password" id="password" placeholder="密码"
                           class="layui-input">
                </div>
                <div class="layui-form-item" style="align:center;">
                    &emsp;&emsp;&emsp;
                    <!-- <div class="layui-input-block"> -->
                    <input type="radio" name="type" value="1" title="管理员" checked>
                    <input type="radio" name="type" value="2" title="用户">
                    <!-- </div> -->
                </div>
                <div class="layui-form-item">

                    <button type="button" id="login" class="layui-btn layui-btn-fluid">登&emsp;&emsp;录</button>

                </div>
                <div class="layui-form-item">


                    <button type="button" onclick="location.href='toIndex'" class="layui-btn layui-btn-fluid layui-btn-normal">返回首页</button>
                </div>


            </div>
        </div>


    </div>
</form>


<script src="<%=path %>/resource/layui/layui.js"></script>
<script src="<%=path %>/resource/layui/jquery-1.9.1.min.js"></script>

<script>

    $("#login").click(function(){
        var username = $.trim($('#username').val());
        var password = $.trim($("#password").val());
        if (username == '') {
            layer.msg('用戶名不能为空', function () {
                time:2000
            });
            return false;
        }
        if (password == '') {
            layer.msg('密码不能为空', function () {
                time:2000
            });
            return false;
        }

        $.ajax({
            cache: true,
            type: "post",
            url: "login",
            data: $("#loginForm").serialize(),
            async: false,
            success: function (e) {
                if (e == 'ok') {
                    alert("登录成功！");
                    window.parent.location.href = "toMain";
                } else if (e == 'toIndex') {
                    alert("登录成功！");
                    window.parent.location.href = "toIndex";
                } else {
                    alert("登录失败，账号或者密码错误！");
                }
            }
        })

    });

</script>

<script>

    layui.use(['form', 'jquery', 'layer'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;
        form.render();//这句一定要加，占坑

    });
</script>
</body>
</html>