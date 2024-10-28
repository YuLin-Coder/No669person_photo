package com.photo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.*;
import com.photo.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class IndexController {

    @Autowired
    AblumService ablumService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    UserService userService;

    @Autowired
    TipsService tipsService;

    @Autowired
    CommentsService commentsService;

    @Autowired
    PhotosService photosService;

    @Autowired
    FriendService friendService;

    @Autowired
    MessageService messageService;

    /**
     * 主页面
     */
    @RequestMapping("/toIndex")
    public ModelAndView toIndex(@RequestParam(defaultValue="1") Integer currentPage,HttpServletRequest request){
        Map<String,Object> maps = new HashMap<>();
        List<Category> categoryList = categoryService.selectCategoryList(maps);
        request.getSession().setAttribute("categoryList",categoryList);
        
        List<Tips> tipsList = tipsService.selectTipsList(maps);
        request.getSession().setAttribute("tipsList",tipsList);
        
    
        String key = request.getParameter("key");
        String tid = request.getParameter("tid");
        List<Photos> list = new ArrayList<>();
        Map<String,Object> param = new HashMap<>();
        param.put("key", key);
        param.put("tid", tid);
        PageHelper.startPage(currentPage,8);
        list=photosService.selectPhotosList(param);
        for(Photos data :list) {
            data.setUser(userService.selectUserById(data.getUid()));
            data.setTips(tipsService.selectTipsById(data.getTid()));
            data.setAblum(ablumService.selectAblumById(data.getAid()));
        }
        PageInfo<Photos> pageInfo=new PageInfo<Photos>(list,8);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("key",key);

        request.getSession().setAttribute("url","toIndex");
        return new ModelAndView("views/index/index");
    }

    /**
     * 我的评论
     */
    @RequestMapping("/toComments")
    public ModelAndView toComments(@RequestParam(defaultValue="1") Integer currentPage,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        Map<String,Object> maps = new HashMap<>();
        List<Category> categoryList = categoryService.selectCategoryList(maps);
        request.getSession().setAttribute("categoryList",categoryList);

        String key = request.getParameter("key");
        List<Comments> list = new ArrayList<>();

        Map<String,Object> param = new HashMap<>();
        param.put("key", key);
        param.put("uid", user!=null?user.getId():null);
        PageHelper.startPage(currentPage,8);
        list=commentsService.selectCommentsList(param);
        for(Comments comments :list) {
            comments.setUser(userService.selectUserById(comments.getUid()));
            comments.setPhotos(photosService.selectPhotosById(comments.getPid()));
        }
        PageInfo<Comments> pageInfo=new PageInfo<Comments>(list,8);
        request.setAttribute("pageInfo",pageInfo);

        request.getSession().setAttribute("line","toComments");
        return new ModelAndView("views/index/comments");
    }

    /**
     *
     * 去个人中心页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toMyinfo")
    public ModelAndView toMyinfo(HttpServletRequest request, ModelAndView mv){
        User user = (User)request.getSession().getAttribute("user");
        if(user !=null) {
            User data = userService.selectUserById(user.getId());
            request.setAttribute("UserDate", data);
        }
        request.getSession().setAttribute("line","toMyinfo");
        mv.setViewName("views/index/myinfo");
        return mv;
    }


    /**
     *
     * 去相片详情页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toDetail")
    public ModelAndView toDetail(Integer id,HttpServletRequest request, ModelAndView mv){
        Photos data = photosService.selectPhotosById(id);
        data.setUser(userService.selectUserById(data.getUid()));
        data.setTips(tipsService.selectTipsById(data.getTid()));
        data.setAblum(ablumService.selectAblumById(data.getAid()));
        request.setAttribute("data", data);
        Map<String,Object> maps = new HashMap<>();
        maps.put("pid",id);
        List<Comments> commentsList = commentsService.selectCommentsList(maps);
        for(Comments comments:commentsList){
            comments.setUser(userService.selectUserById(comments.getUid()));
        }
        request.setAttribute("commentsList", commentsList);

        mv.setViewName("views/index/detail");
        return mv;
    }


    /**
     *
     * 去用户详情页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUserDetail")
    public ModelAndView toUserDetail(Integer id,HttpServletRequest request, ModelAndView mv){
        User user = (User)request.getSession().getAttribute("user");
        User data = userService.selectUserById(id);
        Friend friend = friendService.selectByMidAndUid(user.getId(),data.getId());
        Friend friend2 = friendService.selectByUidAndMid(user.getId(),data.getId());
        if(friend == null || friend2 == null ){
            request.setAttribute("add", 1);
        }
        request.setAttribute("data", data);
        mv.setViewName("views/index/user_detail");
        return mv;
    }


    /**
     * 相册列表
     */
    @RequestMapping("/toAbulm")
    public ModelAndView toAbulm(@RequestParam(defaultValue="1") Integer currentPage,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        Map<String,Object> maps = new HashMap<>();
        List<Category> categoryList = categoryService.selectCategoryList(maps);
        request.getSession().setAttribute("categoryList",categoryList);

        String key = request.getParameter("key");
        List<Ablum> list = new ArrayList<>();

        Map<String,Object> param = new HashMap<>();
        param.put("key", key);
        param.put("uid", user!=null?user.getId():null);
        PageHelper.startPage(currentPage,8);
        list=ablumService.selectAblumList(param);
        for(Ablum data :list){
            data.setUser(userService.selectUserById(data.getUid()));
            data.setCategory(categoryService.selectCategoryById(data.getCid()));
        }
        PageInfo<Ablum> pageInfo=new PageInfo<Ablum>(list,8);
        request.setAttribute("pageInfo",pageInfo);

        request.getSession().setAttribute("line","toAbulm");
        return new ModelAndView("views/index/ablum");
    }

    /**
     * 相片列表
     */
    @RequestMapping("/toPhotos")
    public ModelAndView toPhotos(@RequestParam(defaultValue="1") Integer currentPage,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        Map<String,Object> maps = new HashMap<>();
        List<Category> categoryList = categoryService.selectCategoryList(maps);
        request.getSession().setAttribute("categoryList",categoryList);

        String key = request.getParameter("key");
        List<Photos> list = new ArrayList<>();

        Map<String,Object> param = new HashMap<>();
        param.put("key", key);
        param.put("uid", user!=null?user.getId():null);
        PageHelper.startPage(currentPage,8);
        list=photosService.selectPhotosList(param);
        for(Photos data :list){
            data.setUser(userService.selectUserById(data.getUid()));
            data.setAblum(ablumService.selectAblumById(data.getAid()));
            data.setTips(tipsService.selectTipsById(data.getTid()));
        }
        PageInfo<Photos> pageInfo=new PageInfo<Photos>(list,8);
        request.setAttribute("pageInfo",pageInfo);
        request.getSession().setAttribute("line","toPhotos");
        return new ModelAndView("views/index/photos");
    }


    /**
     * 相片列表
     */
    @RequestMapping("/toFriend")
    public ModelAndView toFriend(@RequestParam(defaultValue="1") Integer currentPage,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        Map<String,Object> maps = new HashMap<>();
        List<Category> categoryList = categoryService.selectCategoryList(maps);
        request.getSession().setAttribute("categoryList",categoryList);

        String key = request.getParameter("key");
        List<Friend> list = new ArrayList<>();

        Map<String,Object> param = new HashMap<>();
        param.put("key", key);
        param.put("uid", user!=null?user.getId():null);
        PageHelper.startPage(currentPage,8);
        list=friendService.selectFriendList(param);
        for(Friend data :list){
            data.setUser(userService.selectUserById(data.getUid()));
            data.setMineUser(userService.selectUserById(data.getMid()));
        }
        PageInfo<Friend> pageInfo=new PageInfo<Friend>(list,8);
        request.setAttribute("pageInfo",pageInfo);
        request.getSession().setAttribute("line","toFriend");
        return new ModelAndView("views/index/friend");
    }

    /**
     * 消息列表
     */
    @RequestMapping("/toMessage")
    public ModelAndView toMessage(@RequestParam(defaultValue="1") Integer currentPage,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        Map<String,Object> maps = new HashMap<>();
        List<Category> categoryList = categoryService.selectCategoryList(maps);
        request.getSession().setAttribute("categoryList",categoryList);

        String key = request.getParameter("key");
        List<Message> list = new ArrayList<>();

        Map<String,Object> param = new HashMap<>();
        param.put("key", key);
        param.put("uid", user!=null?user.getId():null);
        PageHelper.startPage(currentPage,8);
        list=messageService.selectMessageList(param);
        for(Message data:list){
            data.setUser(userService.selectUserById(data.getUid()));
            data.setmUser(userService.selectUserById(data.getMid()));
        }
        PageInfo<Message> pageInfo=new PageInfo<Message>(list,8);
        request.setAttribute("pageInfo",pageInfo);
        request.getSession().setAttribute("line","toMessage");
        return new ModelAndView("views/index/message");
    }
}
