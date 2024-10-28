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
<script src="<%=path %>/resource/index/static/js/index/article_details.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=path %>/resource/index/static/layui/css/layui.css" media="all"/>
<link rel="stylesheet" href="<%=path %>/resource/index/static/layui/css/modules/layer/default/layer.css"/>
<link rel="stylesheet" href="<%=path %>/resource/index/static/css/global.css"/>

</head>
<body>

<jsp:include page="/WEB-INF/views/index/header.jsp"/>



<div class="layui-container container">
  <div class="layui-row layui-col-space20">
    <div class="layui-col-md12">
      <div>
          <span class="layui-breadcrumb">
              <a href="toIndex">首页</a>
              <a href="">相片详情</a>
    	</span>
        <hr class="layui-bg-red">
        <div class="content" id="photos">
        	<h2 class="c_titile">${data.title }</h2>
            <p class="box_c"><span class="d_time">发布时间：${data.create_time }</span><span>标签：${data.tips.name }</span>
            </p>
        <div class="detail-body">
            <p>
                ${data.note}
            </p>

            图片下载<hr>
            <p>
            <a href="downLoad?url=${data.photo}" >点击下载</a><br>
            </p>
            封面<hr>
            <p>
                <img src="${data.photo}" alt="Fly社区">
            </p>
          
        </div>
        
        <fieldset class="layui-elem-field layui-field-title" style="margin: 0px 0px; text-align: center;">
          <legend>评论</legend>
        </fieldset>
        
	<div class="detail-box">
        <a name="comment"></a>
        <ul class="jieda" id="jieda">
        
        <c:forEach items="${commentsList}" var="data"  >
        
          <li data-id="13">
            <a name="item-121212121212"></a>
            <div class="detail-about detail-about-reply">
              <a class="jie-user" href="">
                <img src="${data.user.photo }" alt="">
                <cite>
                  <i>${data.user.nickname }</i>
                </cite>
              </a>
              <div class="detail-hits">
                <span>${data.create_time }</span>
              </div>
            </div>
            <div class="detail-body jieda-body">
              <p>${data.content }</p>
            </div>
          </li>
          
          </c:forEach>
          <!-- <li class="fly-none">没有任何回答</li> -->
        </ul>
        <!--分页-->
        
      	<div id="page_reply"></div>
      	 <c:if test="${user !=null  }">
        <div class="layui-form layui-form-pane">
           <form id="saveForm">
           <input type="hidden" value="${data.id }" name="pid"/>
            <div class="layui-form-item layui-form-text">
              <div class="layui-input-block">
                <textarea id="content" name="content"  class="layui-textarea"></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <input type="button" class="layui-btn"  id="save" value="提交评论"/>
            </div>
            </form>
        </div>
        </c:if>
        
        
      </div>
      </div>
      </div>
    </div>
  
  </div>
</div>
  <div class="footer">
    <hr class="layui-bg-red">
    <p>个人相册管理系统</p>
  </div>
     <script>
    //图片放大 预览显示
    layer.photos({
      photos: '#photos'
      ,anim: 0 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
    }); 
    </script>
    
     
  <script >
   
  
	$("#save").click(function() {
		$.ajax({
			cache:true,
			type : "post",
			url : "addComments",
			data : $("#saveForm").serialize(),
			async:false,
			success : function(e) {
				if (e) {
					alert("评论成功！");
					window.location.reload();
				}else{
					alert("评论失败");
				}
			}
		})
	});

  
  </script>
  
  
   
  <script>
		layui.use(['layer', 'form','jquery'], function(){
			var form = layui.form,
			 layer = layui.layer,
			 $= layui.jquery;
			 form.render();//这句一定要加，占坑
			 
			 $('#yuyue').on("click",function(e){
				 var rid = $("#rid").val();
			  	 layer.open({
		  	      //调整弹框的大小
		  		  area:['500px','800px'],
		  		  shadeClose:true,//点击旁边地方自动关闭
		  		  //动画
		  		  anim:2,
		  		  //弹出层的基本类型
		  		  type: 2, 
		  		  title: '预约服务',
		  		  //刚才定义的弹窗页面
		  		  content: 'toAddOrders?rid='+rid, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
		  	  });
		    });
		   
		});
</script>
  
</body>
</html>
