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
            <div class="layui-card-header">注册用户</div>

            <div class="layui-card">
                <div class="layui-card-body">
                    <form id="saveForm" class="layui-form">

                        <div class="layui-form-item">
                            <label class="layui-form-label">昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="nickname" id="nickname" lay-verify="required" lay-verType="tips"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">性别:</label>
                            <div class="layui-input-inline">
                                <select   id="sex" name="sex" >
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" id="phone" lay-verify="required" lay-verType="tips"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">密码</label>
                            <div class="layui-input-inline">
                                <input type="password" name="pwd" id="pwd" lay-verify="required" lay-verType="tips"
                                       class="layui-input">
                            </div>
                        </div>



                        <input type="hidden" name="photo" class="photo">
                        <div class="layui-form-item">
                            <label class="layui-form-label">头像:</label>
                            <div class="layui-upload">
                                <div class="layui-upload-list">
                                    <img class="layui-upload-img" style="width:200px;height:100px;" id="demo1">
                                    <button type="button" class="btn btn-primary" id="test1">+</button>
                                    <p id="demoText"></p>
                                </div>

                            </div>
                        </div>


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
            url: "addUser",
            data: $("#saveForm").serialize(),
            async: false,
            success: function (e) {
                if (e) {
                    alert("新增成功");
                    window.parent.location.href = "toLoginOutAct";
                } else {
                    alert("新增失败")
                }
            }
        })
    });

</script>


<script>

    layui.use(['form', 'jquery', 'layer', 'laydate' ,'upload'], function () {
        var form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            $ = layui.jquery;
        form.render();//这句一定要加，占坑

        var uploadInst = upload.render({
            elem: '#test1'
            ,url: 'upload'
            ,accept:'images'
            ,size:50000
            ,before: function(obj){
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result);
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                layer.msg('上传成功');

                var fileupload = $(".photo");
                fileupload.attr("value",res.data.src);
                console.log(fileupload.attr("value"));
            }
            ,error: function(){
                layer.msg('上传失败');
            }
        });


    });

</script>
</body>
</html>