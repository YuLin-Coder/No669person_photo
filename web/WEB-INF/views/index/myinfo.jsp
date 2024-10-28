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
<script src="<%=path %>/resource/index/static/js/index/set.js" type="text/javascript"></script>
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
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li class="layui-this" lay-id="info">我的资料</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
          <form class="layui-form"   id="saveForm"  enctype="multipart/form-data"  >
                 <input type="hidden" name="id" id="id" value="${UserDate.id }"   class="layui-input">
          
            <div class="layui-form-item">
              <label  class="layui-form-label">昵称</label>
              <div class="layui-input-inline">
                <input type="text" name="nickname"  value="${UserDate.nickname }" autocomplete="off" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <label  class="layui-form-label">手机号</label>
              <div class="layui-input-inline">
                <input type="text" id="phone" name="phone"  value="${UserDate.phone }" lay-verify="required" autocomplete="off" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">密码</label>
              <div class="layui-input-inline">
                <input type="password" id="pwd" name="pwd"  value="${UserDate.pwd }" lay-verify="required" autocomplete="off" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <label  class="layui-form-label">性别</label>
              <div class="layui-input-inline">
                 <select  class="form-control" id="sex" name="sex" >
						<option value="男" <c:if test="${UserDate.sex == '男'}">selected</c:if> >男</option>
						<option value="女" <c:if test="${UserDate.sex == '女'}">selected</c:if> >女</option>
                     </select>
              </div>
            </div>
            <input type="hidden" name="photo" class="photo"  value="${UserDate.photo }" >
              <div class="layui-form-item">
                  <label class="layui-form-label">头像:</label>
                  <div class="layui-upload">
                      <div class="layui-upload-list">
                          <img class="layui-upload-img" src="${UserDate.photo}" style="width:200px;height:100px;" id="demo1">
                          <button type="button" class="btn btn-primary" id="test1">+</button>
                          <p id="demoText"></p>
                      </div>

                  </div>
              </div>
            
            <div class="layui-form-item">
              <button class="layui-btn" type="button" id="save">确认修改</button>
            </div>
            </form>
          </div>
          
          
       
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
    </body>
    
    
<script>



$("#save").click(function(){
	//执行添加的操作ajax
	$.ajax({
		cache:true,
		type:"post",
	 	url : "updateUser",
        data: $("#saveForm").serialize(),
		 success:function(e){
			if(e){
				 alert("修改成功");
                window.parent.location.href = "toLoginOutAct";
			}else{
				 alert("修改失败");
			}
		}
	})
});
   

$("#imgUrl").change(function () {
    var img_src = URL.createObjectURL($(this)[0].files[0]);
    document.getElementById("preview_img").src=img_src;
});


</script>
<script>

    layui.use(['form', 'jquery', 'layer', 'laydate' ,'upload'], function () {
        var form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            $ = layui.jquery;
        upload = layui.upload,

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
</html>