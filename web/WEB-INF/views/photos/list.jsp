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

<div class="layui-col-md12">
    <div class="layui-card">
        <div class="layui-card-header">照片列表</div>
        <div class="layui-card-body">
            <form action="PhotosList" method="post">

                <div class="layui-form-item">
                    <div class="layui-inline">
                        <div class="layui-input-inline">
                            <input type="text" placeholder="根据照片名称" name="key" id="key" value="${key}"
                                   class="layui-input"/>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button type="submit" class="layui-btn layui-btn-sm layui-btn-normal">查询</button>
                    </div>
                </div>

            </form>
            <table class="layui-table">
                <thead>
                <tr style="background-color:#d0d0d0;">
                    <th>照片名称</th>
                    <th>标签</th>
                    <th>照片</th>
                    <th>相册</th>
                    <th>发布照片</th>
                    <th>照片描述</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="data">
                    <tr>
                        <td>${data.title }</td>
                        <td>${data.tips.name }</td>
                        <td><img src="${data.photo}" id="preview_img" style="width:50px; height:50px; "></td>
                        <td>${data.ablum.title }</td>
                        <td>${data.user.nickname }</td>
                        <td>${data.note }</td>
                        <td>${data.create_time }</td>
                        <td>
                            <a href="toUpdatePhotos?id=${data.id}"
                               class="layui-btn layui-btn-sm layui-btn-normal"><i
                                    class="layui-icon">修改</i></a>
                            <a type="button" onclick="del(${data.id})"
                               class="layui-btn layui-btn-sm layui-btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>


            <div class="footpage">
                <ul style="display:flex; flex-direction:row;">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm"
                           href="PhotosList?currentPage=1">首页</a></li>
                    <li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <a class="layui-btn layui-btn-normal layui-btn-sm"
                               href="PhotosList?currentPage=${pageInfo.pageNum-1}">
                                <span>上一页</span></a>
                        </c:if>
                    </li>

                    <c:forEach begin="${pageInfo.pageNum  }" end="${pageInfo.pages }" var="i">
                        <li><a class="layui-btn layui-btn-primary layui-btn-sm"
                               href="PhotosList?currentPage=${i }">${i }</a></li>
                    </c:forEach>

                    <li>
                        <c:if test="${pageInfo.hasNextPage }">
                            <a class="layui-btn layui-btn-normal layui-btn-sm "
                               href="PhotosList?currentPage=${pageInfo.pageNum+1}">
                                下一页</a>
                        </c:if>
                    </li>
                    <li>
                        <a class="layui-btn layui-btn-primary layui-btn-sm"
                           href="PhotosList?currentPage=${pageInfo.pages}">末页</a></li>
                    <li style="margin-left:10px;margin-top:6px;">共<i class="blue">${pageInfo.total }</i>条记录，当前显示第<i
                            class="blue">${pageInfo.pageNum }</i>页,&nbsp;
                        总<i class="blue">${pageInfo.pages }</i>页
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


<script src="<%=path %>/resource/layui/layui.js"></script>
<script src="<%=path %>/resource/layui/jquery-1.9.1.min.js"></script>
<script>
    function del(id) {
        if (confirm("确定要删除吗？")) {
            $.ajax({
                cache: true,
                type: "post",
                url: "deletePhotos",
                data: {"id": id},
                async: false,
                success: function (e) {
                    if (e) {
                        alert("删除成功！");
                        document.location.reload();//当前页面
                    } else {
                        alert("修改失败");
                    }
                }
            })
        }
    }
</script>
<script>

    layui.use(['layer', 'form', 'jquery'], function () {//调用layui组件
        var form = layui.form;
        var layer = layui.layer;
        $ = layui.jquery;
        form.render();

    });

</script>
</body>
</html>