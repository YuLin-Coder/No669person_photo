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
  
    <div class="layui-tab layui-tab-brief" lay-filter="user" style="width:1200px;">
      <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">我的评论</li>
      </ul>
   
   
      <table class="layui-table">
              <thead>
               <tr style="background-color:#d0d0d0;">
			      	
						    <th>评论内容</th>
						    <th>评论时间</th>
								<th>操作</th>
    			</tr> 
              </thead>
              <tbody>
                <c:forEach items="${pageInfo.list}" var="data"  >
			    <tr>
							    <td>${data.content }</td>
							    <td>${data.create_time }</td>
                    <td>
                    <a type="button" onclick="del(${data.id})" class="layui-btn layui-btn-sm layui-btn-danger" >删除</a>
   		          </td> 
		    </tr>
		   </c:forEach>
              </tbody>
            </table>

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
                       href="UserList?currentPage=${pageInfo.pages}">末页</a></li>

            </ul>
        </div>




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


function del(id){
	if(confirm("确定要删除吗？")){
		$.ajax({
			cache:true,
			type : "post",
			url : "deleteComments",
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