<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
    <li class="layui-nav-item <c:if test="${line == 'toComments'}">layui-this</c:if> ">
      <a href="toComments">
        <i class="layui-icon">&#xe609;</i>
        我的评论
      </a>
    </li>
    <li class="layui-nav-item <c:if test="${line == 'toMyinfo'}">layui-this</c:if>  ">
      <a href="toMyinfo">
        <i class="layui-icon">&#xe612;</i>
        用户中心
      </a>
    </li>
    
    <li class="layui-nav-item <c:if test="${line == 'toAbulm'}">layui-this</c:if>  ">
      <a href="toAbulm">
        <i class="layui-icon">&#xe612;</i>
        我的相册
      </a>
    </li>
    
       <li class="layui-nav-item <c:if test="${line == 'toPhotos'}">layui-this</c:if>  ">
      <a href="toPhotos">
        <i class="layui-icon">&#xe612;</i>
        我的相片
      </a>
    </li>
    

    
        <li class="layui-nav-item <c:if test="${line == 'toFriend'}">layui-this</c:if> ">
      <a href="toFriend">
        <i class="layui-icon">&#xe620;</i>
       朋友管理
      </a>
    </li>

        <li class="layui-nav-item <c:if test="${line == 'toMessage'}">layui-this</c:if> ">
      <a href="toMessage">
        <i class="layui-icon">&#xe620;</i>
        我的消息
      </a>
    </li>
  </ul>