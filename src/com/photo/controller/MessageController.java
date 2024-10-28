package com.photo.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.Message;
import com.photo.entity.User;
import com.photo.service.MessageService;
import com.photo.service.UserService;
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
public class MessageController {

    @Autowired
    MessageService service;

    @Autowired
    UserService userService;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");


    /**
     * 消息列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/MessageList")
    public ModelAndView MessageList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        String state = request.getParameter("state");
        List<Message> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("state", state);
        PageHelper.startPage(currentPage,8);
        list=service.selectMessageList(maps);
        for(Message data:list){
            data.setUser(userService.selectUserById(data.getUid()));
            data.setmUser(userService.selectUserById(data.getMid()));
        }
        PageInfo<Message> pageInfo=new PageInfo<Message>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/message/list");
    }

    /**
     *
     * 去新增消息页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toAddMessage")
    public ModelAndView toAddMessage(HttpServletRequest request, ModelAndView mv){
        String mid = request.getParameter("mid");
        request.setAttribute("mid",mid);
        mv.setViewName("views/message/add");
        return mv;
    }

    /**
     * 新增消息
     * @param Message
     * @return
     */
    @RequestMapping("/addMessage")
    @ResponseBody
    public boolean addMessage(HttpServletRequest request,Message Message){
        User user =  (User)request.getSession().getAttribute("user");
        boolean re = false;
        if(user !=null){
            Message.setUid(user.getId());
            Message.setCreate_time(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
            service.addMessage(Message);
            re = true;
        }
        return re;
    }

    /**
     * 删除消息
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteMessage")
    public boolean deleteMessage(Integer id ,HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        service.deleteMessage(id);
        re = true;
        return re;
    }

    /**
     * 去修改消息页面
     * @param id
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdateMessage")
    public ModelAndView toUpdateMessage(Integer id ,HttpServletRequest request, ModelAndView mv){
        Message Message = service.selectMessageById(id);
        mv.addObject("data", Message);
        mv.setViewName("views/message/update");
        return mv;
    }


    /**
     * 修改消息
     * @param Message
     * @return
     */
    @RequestMapping("/updateMessage")
    @ResponseBody
    public boolean updateMessage(Message Message){
        boolean re = false;
        Message.setFlag("2");
        Message.setRetime(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        service.updateMessage(Message);
        re = true;
        return re;
    }
}
