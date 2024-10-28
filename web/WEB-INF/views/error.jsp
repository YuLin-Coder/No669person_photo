<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();//获得当前的项目根目录路径赋值给path
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>404 页面不存在</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
   <link rel="stylesheet" type="text/css" href="layui/css/layui.css" media="all">
  <link rel="stylesheet" href="layui/css/admin.css" media="all"> 
</head>
<body>


<div class="layui-fluid">
  <div class="layadmin-tips">
    <i class="layui-icon" face>&#xe664;</i>
    <div class="layui-text">
      <h1>
        <span class="layui-anim layui-anim-loop layui-anim-">4</span> 
        <span class="layui-anim layui-anim-loop layui-anim-rotate">0</span> 
        <span class="layui-anim layui-anim-loop layui-anim-">4</span>
       
      </h1>
      页面请求路径出错，或者资源不存在，这是一个错误的页面！
    </div>
  </div>
</div>
</body>
<script src="layui/layui.js"></script>
<script>

layui.use('element', function(){
  var element = layui.element;
  
});
</script>

</html>
