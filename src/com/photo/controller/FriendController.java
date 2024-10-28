package com.photo.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.Friend;
import com.photo.entity.User;
import com.photo.service.FriendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;


@RestController
public class FriendController {

    @Autowired
    FriendService service;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");


    /**
     * 朋友列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/FriendList")
    public ModelAndView FriendList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        User user = (User)request.getSession().getAttribute("user");
        String key = request.getParameter("key");
        List<Friend> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("uid", user.getId());
        PageHelper.startPage(currentPage,8);
        list=service.selectFriendList(maps);
        PageInfo<Friend> pageInfo=new PageInfo<Friend>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/friend/list");
    }

    /**
     *
     * 去新增朋友页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toAddFriend")
    public ModelAndView toAddFriend(HttpServletRequest request, ModelAndView mv){
        String uid =request.getParameter("uid");
        request.setAttribute("uid",uid);
        mv.setViewName("views/friend/add");
        return mv;
    }

    /**
     * 新增朋友
     * @param Friend
     * @return
     */
    @RequestMapping("/addFriend")
    @ResponseBody
    public boolean addFriend(HttpServletRequest request,Friend Friend){
        boolean re = false;
        User user = (User)request.getSession().getAttribute("user");
        if(user !=null){
            Friend.setMid(user.getId());
            Friend.setCreate_time(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
            service.addFriend(Friend);
            re = true;
        }
        return re;
    }

    /**
     * 删除朋友
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteFriend")
    public boolean deleteFriend(Integer id ,HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        service.deleteFriend(id);
        re = true;
        return re;
    }

    /**
     * 去修改朋友页面
     * @param id
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdateFriend")
    public ModelAndView toUpdateFriend(Integer id ,HttpServletRequest request, ModelAndView mv){
        Friend Friend = service.selectFriendById(id);
        mv.addObject("data", Friend);
        mv.setViewName("views/friend/update");
        return mv;
    }


    /**
     * 修改朋友
     * @param Friend
     * @return
     */
    @RequestMapping("/updateFriend")
    @ResponseBody
    public boolean updateFriend(Friend Friend){
        boolean re = false;
        service.updateFriend(Friend);
        re = true;
        return re;
    }
}
