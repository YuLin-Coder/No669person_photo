<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script src="<%=path %>/resource/layui/layui.js"></script>

 <script>
	layui.use(['layer', 'form','jquery'], function(){
		var form = layui.form,
		 layer = layui.layer,
		 $= layui.jquery;
		 form.render();//这句一定要加，占坑
		 
		 $('#register').on("click",function(e){
		  	  layer.open({
		  	      //调整弹框的大小
		  		  area:['500px','800px'],
		  		  shadeClose:true,//点击旁边地方自动关闭
		  		  //动画
		  		  anim:2,
		  		  //弹出层的基本类型
		  		  type: 2, 
		  		/*  title: '注册用户',*/
		  		  //刚才定义的弹窗页面
		  		  content: 'toRegister', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
		  				
		  	  });
		    });

	});
</script>


<div class="layui-header header">
  <div class="main">
    <ul class="layui-nav layui-nav-left" lay-filter="filter">
      <a  href="toIndex" title="Fly" style="color:white;font-size:20px;">个人相册管理系统</a>
      <li class="layui-nav-item  
    <c:if test="${url == 'toIndex' }">layui-this </c:if> nav-left">
        <a href="toIndex">首页</a>
      </li>
      

      
    </ul>
    <ul class="layui-nav layui-layout-right layui-nav-right" lay-filter="filter">
    
    <c:if test="${user !=null }">
        
      <li class="layui-nav-item">
        <a href="toMyinfo">我的主页<span class="layui-badge-dot"></span></a>
      </li>
      <li class="layui-nav-item">
        <a href="javascript:;"><img src="${user.photo }" class="layui-nav-img">${user.nickname }</a>
        <dl class="layui-nav-child">
          	<dd><a href="toMyinfo">修改信息</a></dd>
            <dd><a href="toLoginOutAct">退了</a></dd>
        </dl>
      </li>
    </c:if>

  <c:if test="${user ==null }">
        
      <li class="layui-nav-item">
        <a href="toLoginOutAct">去登录<span class="layui-badge-dot"></span></a>
      </li>
      <li class="layui-nav-item">
          <a type ="button" id="register">立即注册<span class="layui-badge-dot"></span></a>
      </li>
    </c:if>

    </ul>
  </div>
</div>
