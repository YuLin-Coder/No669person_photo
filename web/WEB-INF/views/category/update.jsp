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
            <div class="layui-card-header">修改分类</div>

            <div class="layui-card">
                <div class="layui-card-body">
                    <form id="saveForm" method="post">
                        <input type="hidden" name="id" id="id" value="${data.id}"/>

                        <div class="layui-form-item">
                            <label class="layui-form-label">分类名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" id="name" value="${data.name}"
                                       lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">描述</label>
                            <div class="layui-input-inline">
                                <input type="text" name="note" id="note" value="${data.note}"
                                       lay-verify="required" lay-verType="tips" class="layui-input">
                            </div>
                        </div>

                        <br>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" type="button" id="save">提交</button>
                                <a href="CategoryList" class="layui-btn" type="button">返回</a>
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
            url: "updateCategory",
            data: $("#saveForm").serialize(),
            async: false,
            success: function (e) {
                if (e) {
                    alert("修改成功");
                    window.location.href = "CategoryList";
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