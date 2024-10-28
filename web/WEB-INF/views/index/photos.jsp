<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>个人相册管理系统</title>
<meta name="keywords" content="前端模板">
<meta name="description" content="前端模板">

<script src="<%=path %>/resource/index/static/js/jquery/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="<%=path %>/resource/index/static/layui/layui.js" type="text/javascript"></script>
<script src="<%=path %>/resource/index/static/js/index/index.js" type="text/javascript"></script>
<script src="<%=path %>/resource/index/static/js/index/freezeheader.js" type="text/javascript"></script>
<script src="<%=path %>/resource/index/static/layui/lay/modules/layer.js" type="text/javascript"></script>
<script src="<%=path %>/resource/index/static/js/index/sliders.js" type="text/javascript"></script>
<script src="<%=path %>/resource/index/static/js/index/html5.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=path %>/resource/index/static/layui/css/layui.css" media="all"/>
<link rel="stylesheet" href="<%=path %>/resource/index/static/layui/css/modules/layer/default/layer.css"/>
<link rel="stylesheet" href="<%=path %>/resource/index/static/css/global.css"/>
</head>
<body>


<jsp:include page="/WEB-INF/views/index/header.jsp"/>

    <div class="layui-container container" style="padding-top:70px;">
   
    	<div class="main fly-user-main layui-clear" style="margin-left: -208px;">
<jsp:include page="/WEB-INF/views/index/line.jsp"/>

  
  <div class="fly-panel fly-panel-user">
    	<!--
    <div class="fly-msg" style="margin-top: 15px;">
      您的邮箱尚未验证，这比较影响您的帐号安全，<a href="activate.html">立即去激活？</a>
    </div>
    -->
    <div class="layui-tab layui-tab-brief" lay-filter="user" style="width:1200px;">
      <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">我的相片</li>
          <button type="button" onclick="add()" class="layui-btn-normal layui-btn" >新建相片</button>
      </ul>


      <table class="layui-table">
              <thead>
               <tr style="background-color:#d0d0d0;">

                   <th>照片名称</th>
                   <th>标签</th>
                   <th>照片</th>
                   <th>相册</th>
                   <th>发布用户</th>
                   <th>照片描述</th>
                   <th>创建时间</th>
								<th>操作</th>
    			</tr>
              </thead>
              <tbody>
                <c:forEach items="${pageInfo.list}" var="data"  >
			    <tr>
                    <td>${data.title }</td>
                    <td>${data.tips.name }</td>
                    <td><img src="${data.photo}" id="preview_img" style="width:50px; height:50px; "></td>
                    <td>${data.ablum.title }</td>
                    <td>${data.user.nickname }</td>
                    <td>${data.note }</td>
                    <td>${data.create_time }</td>
                    <td>
                        <a class="layui-btn layui-btn-sm layui-btn-normal" type="button" onclick="updatePhotos(${data.id})"><i
                                class="layui-icon">修改</i></a>
                    <a type="button" onclick="del(${data.id})" class="layui-btn layui-btn-sm layui-btn-danger" >删除</a>
   		          </td>
		    </tr>
		   </c:forEach>
              </tbody>
            </table>


    </div>

  </div>
</div>
    </div>
    <div class="footer">
        <hr class="layui-bg-red">
      <p>个人相册管理系统</p>
    </div>
    </body>


<script>
    layui.use(['layer', 'form','jquery'], function(){
        var form = layui.form,
            layer = layui.layer,
            $= layui.jquery;
        form.render();//这句一定要加，占坑

            window.updatePhotos = function(e){
                layer.open({
                    //调整弹框的大小
                    area:['500px','800px'],
                    shadeClose:true,//点击旁边地方自动关闭
                    //动画
                    anim:2,
                    //弹出层的基本类型
                    type: 2,
                    title: '修改相片',
                    //刚才定义的弹窗页面
                    content: 'toUpdatePhotos?id='+e, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                });
            }

            window.add =function () {
                layer.open({
                    //调整弹框的大小
                    area:['500px','800px'],
                    shadeClose:true,//点击旁边地方自动关闭
                    //动画
                    anim:2,
                    //弹出层的基本类型
                    type: 2,
                    title: '新建相片',
                    //刚才定义的弹窗页面
                    content: 'toAddPhotos', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                });
            }


    });
</script>


<script>


function del(id){
	if(confirm("确定要删除吗？")){
		$.ajax({
			cache:true,
			type : "post",
			url : "deletePhotos",
			 data :{"id":id},
			async:false,
			success : function(e) {
				if (e) {
					alert("删除成功！");
			    	document.location.reload();//当前页面
				} else{
					alert("删除失败");
				}
			}
		})
   	}
}
</script>
</html>