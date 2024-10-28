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
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/resource/layui/css/login.css">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card-header">个人信息</div>

            <div class="layui-card">
                <div class="layui-card-body">
                    <form id="saveForm" method="post">
                        <input type="hidden" name="id" id="id" value="${admin.id}"/>

                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" id="username" value="${admin.username}"
                                       lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="nickname" id="note" value="${admin.nickname}"
                                       lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>


                        <div class="layui-form-item">
                            <label class="layui-form-label">密码</label>
                            <div class="layui-input-inline">
                                <input type="password" name="pwd" id="pwd" value="${admin.pwd}"
                                       lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>

                        <br>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" type="button" id="save">提交</button>
                            </div>
                        </div>


                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
</div>

<script src="<%=path %>/resource/layui/layui.js"></script>
<script src="<%=path %>/resource/layui/jquery-1.9.1.min.js"></script>


<script>
    $("#save").click(function () {
        //执行添加的操作ajax
        $.ajax({
            cache: true,
            type: "post",
            url: "updateAdmin",
            data: $("#saveForm").serialize(),
            async: false,
            success: function (e) {
                if (e) {
                    alert("修改成功");
                    window.location.href = "toUpdateAdmin";
                } else {
                    alert("修改失败")
                }
            }
        })
    });

</script>

<script>

    layui.use(['form', 'jquery', 'layer', 'laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            $ = layui.jquery;
        form.render();//这句一定要加，占坑

    });


</script>
</body>
</html>