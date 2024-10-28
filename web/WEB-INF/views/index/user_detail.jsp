<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="<%=path %>/resource/index/static/layui/css/layui.css">
    <link rel="stylesheet" href="<%=path %>/resource/index/static/css/global.css">
</head>
<body style="margin-top: 65px;">



<jsp:include page="/WEB-INF/views/index/header.jsp"/>


<div class="fly-home fly-panel" >
    <img src="${data.photo}" alt="贤心">
    <i class="iconfont icon-renzheng" title="Fly社区认证"></i>
    <h1>
        ${data.nickname}
        <i class="iconfont icon-nan"></i>
        <!-- <i class="iconfont icon-nv"></i>  -->
        <!--
        <span style="color:#c00;">（管理员）</span>
        <span style="color:#5FB878;">（社区之光）</span>
        <span>（该号已被封）</span>
        -->
    </h1>

    <p style="padding: 10px 0; color: #5FB878;">手机号：${data.phone}</p>

    <p class="fly-home-info">
        <i class="iconfont icon-shijian"></i><span>${data.registe_time} 加入</span>
    </p>

    <div class="fly-sns" data-user="">
        <c:if test="${add == '1' && user != null && user.id != data.id}">
            <a type="button" class="layui-btn layui-btn-primary fly-imActive" onclick="add(${data.id})">加为好友</a>
        </c:if>

    </div>

</div>


<div class="layui-container">
   <div class="layui-row layui-col-space15">
       <%--  <div class="layui-col-md6 fly-home-jie">
            <div class="fly-panel">
                <h3 class="fly-panel-title">贤心 最近的提问</h3>
                <ul class="jie-row">
                    <li>
                        <span class="fly-jing">精</span>
                        <a href="" class="jie-title"> 基于 layui 的极简社区页面模版</a>
                        <i>刚刚</i>
                        <em class="layui-hide-xs">1136阅/27答</em>
                    </li>
                    <li>
                        <a href="" class="jie-title"> 基于 layui 的极简社区页面模版</a>
                        <i>1天前</i>
                        <em class="layui-hide-xs">1136阅/27答</em>
                    </li>
                    <li>
                        <a href="" class="jie-title"> 基于 layui 的极简社区页面模版</a>
                        <i>2017-10-30</i>
                        <em class="layui-hide-xs">1136阅/27答</em>
                    </li>
                    <li>
                        <a href="" class="jie-title"> 基于 layui 的极简社区页面模版</a>
                        <i>1天前</i>
                        <em class="layui-hide-xs">1136阅/27答</em>
                    </li>
                    <li>
                        <a href="" class="jie-title"> 基于 layui 的极简社区页面模版</a>
                        <i>1天前</i>
                        <em class="layui-hide-xs">1136阅/27答</em>
                    </li>
                    <li>
                        <a href="" class="jie-title"> 基于 layui 的极简社区页面模版</a>
                        <i>1天前</i>
                        <em class="layui-hide-xs">1136阅/27答</em>
                    </li>
                    <li>
                        <a href="" class="jie-title"> 基于 layui 的极简社区页面模版</a>
                        <i>1天前</i>
                        <em class="layui-hide-xs">1136阅/27答</em>
                    </li>
                    <!-- <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何求解</i></div> -->
                </ul>
            </div>
        </div>

        <div class="layui-col-md6 fly-home-da">
            <div class="fly-panel">
                <h3 class="fly-panel-title">贤心 最近的回答</h3>
                <ul class="home-jieda">
                    <li>
                        <p>
                            <span>1分钟前</span>
                            在<a href="" target="_blank">tips能同时渲染多个吗?</a>中回答：
                        </p>
                        <div class="home-dacontent">
                            尝试给layer.photos加上这个属性试试：
                            <pre>
full: true
</pre>
                            文档没有提及
                        </div>
                    </li>
                    <li>
                        <p>
                            <span>5分钟前</span>
                            在<a href="" target="_blank">在Fly社区用的是什么系统啊?</a>中回答：
                        </p>
                        <div class="home-dacontent">
                            Fly社区采用的是NodeJS。分享出来的只是前端模版
                        </div>
                    </li>

                    <!-- <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何问题</span></div> -->
                </ul>
            </div>
        </div>--%>
    </div>
</div>


<script src="<%=path %>/resource/index/static/layui/layui.js"></script>
<script>
    layui.use(['layer', 'form','jquery'], function(){
        var form = layui.form,
            layer = layui.layer,
            $= layui.jquery;
        form.render();//这句一定要加，占坑

        window.add =function (e) {
            layer.open({
                //调整弹框的大小
                area:['500px','800px'],
                shadeClose:true,//点击旁边地方自动关闭
                //动画
                anim:2,
                //弹出层的基本类型
                type: 2,
                title: '申请好友',
                //刚才定义的弹窗页面
                content: 'toAddFriend?uid='+e, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
            });
        }


    });
</script>

</body>
</html>