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

<div class="layui-container container">
  <div class="layui-row layui-col-space20">
    <div class="layui-col-md8">

        <div class="article-main">
        <h2>
          最新相片
        </h2>

       <c:forEach items="${pageInfo.list}" var="data"  >
        <div class="article-list">
          <figure><img src="${data.photo }"  width="200px;" height="100px;"></figure>
          <ul>
            <h3>
              <a href="toDetail?id=${data.id }">${data.title }</a>
            </h3>
            <p>${data.note }</p>
            <p class="autor">
              <span class="lm f_l"><a href="toUserDetail?id=${data.user.id}">${data.user.nickname }</a></span>
              <span class="dtime f_l">${data.create_time }</span>
              <span class="viewnum f_r">标签：（<a href="#">${data.tips.name }</a>）</span>
<!--               <span class="pingl f_r">评论（<a href="#">30</a>）</span></p>
 -->          </ul>
        </div>
        </c:forEach>
     
      </div>
      <!--分页-->
      <!-- <div id="page"></div>
       -->
      
        <div class="footpage">
            <ul style="display:flex; flex-direction:row;">
                <li><a class="layui-btn layui-btn-primary layui-btn-sm"
                       href="${url}?currentPage=1">首页</a></li>
                <li>
                    <c:if test="${pageInfo.hasPreviousPage }">
                        <a class="layui-btn layui-btn-normal layui-btn-sm"
                           href="${url}?currentPage=${pageInfo.pageNum-1}">
                            <span>上一页</span></a>
                    </c:if>
                </li>

                <c:forEach begin="${pageInfo.pageNum  }" end="${pageInfo.pages }" var="i">
                    <li><a class="layui-btn layui-btn-primary layui-btn-sm"
                           href="${url}?currentPage=${i }">${i }</a></li>
                </c:forEach>

                <li>
                    <c:if test="${pageInfo.hasNextPage }">
                        <a class="layui-btn layui-btn-normal layui-btn-sm "
                           href="${url}?currentPage=${pageInfo.pageNum+1}">
                            下一页</a>
                    </c:if>
                </li>
                <li>
                    <a class="layui-btn layui-btn-primary layui-btn-sm"
                       href="${url}?currentPage=${pageInfo.pages}">末页</a></li>

            </ul>
        </div>
      
    </div>


      <div class="layui-col-md4">
          <div class="fly-panel ">
        <form class="layui-form" method="post" action="toIndex">
            <div class="layui-form-item">
              <div class="layui-input-inline" style="width:76%;"> 
                <input type="text" name="key" value="${key }"  placeholder="请输入相片标题" class="layui-input">
              </div>
              <button class="layui-btn" lay-filter="*" lay-submit>搜索</button>
            </div>
         </form>
          </div>


          <div class="fly-panel fly-link">
              <h3 class="fly-panel-title">标签</h3>
              <dl class="fly-panel-main">
               <c:forEach items="${tipsList}" var="data"  >
                      <dd><a class="layui-badge fly-badge-vip" href="toIndex?tid=${data.id}" >${data.name}</a><dd>
                   <br>
                   </c:forEach>
              </dl>
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
	/*
		 $('#register').on("click",function(e){
		  	  layer.open({
		  	      //调整弹框的大小
		  		  area:['500px','800px'],
		  		  shadeClose:true,//点击旁边地方自动关闭
		  		  //动画
		  		  anim:2,
		  		  //弹出层的基本类型
		  		  type: 2, 
		  		  title: '注册用户',
		  		  //刚才定义的弹窗页面
		  		  content: 'LoginServlet?action=toRegister', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
		  				
		  	  });
		    });*/

	});
</script>
</html>
