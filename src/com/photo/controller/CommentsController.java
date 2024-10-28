package com.photo.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.Comments;
import com.photo.entity.User;
import com.photo.service.CommentsService;
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
public class CommentsController {

    @Autowired
    CommentsService service;
    @Autowired
    UserService studentService;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");


    /**
     * 评论列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/CommentsList")
    public ModelAndView CommentsList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        List<Comments> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        PageHelper.startPage(currentPage,8);
        list=service.selectCommentsList(maps);
        PageInfo<Comments> pageInfo=new PageInfo<Comments>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/comments/list");
    }

    /**
     *
     * 去新增评论页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toAddComments")
    public ModelAndView toAddComments(HttpServletRequest request, ModelAndView mv){
        mv.setViewName("views/comments/add");
        return mv;
    }

    /**
     * 新增评论
     * @param Comments
     * @return
     */
    @RequestMapping("/addComments")
    @ResponseBody
    public boolean addComments(HttpServletRequest request,Comments Comments){
        boolean re = false;
        User user = (User)request.getSession().getAttribute("user");
        if(user!=null){
            Comments.setCreate_time(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
            Comments.setUid(user.getId());
            service.addComments(Comments);
            re = true;
        }
        return re;
    }

    /**
     * 删除评论
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteComments")
    public boolean deleteComments(Integer id ,HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        service.deleteComments(id);
        re = true;
        return re;
    }

    /**
     * 去修改评论页面
     * @param id
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdateComments")
    public ModelAndView toUpdateComments(Integer id ,HttpServletRequest request, ModelAndView mv){
        Comments Comments = service.selectCommentsById(id);
        mv.addObject("data", Comments);
        mv.setViewName("views/comments/update");
        return mv;
    }


    /**
     * 修改评论
     * @param Comments
     * @return
     */
    @RequestMapping("/updateComments")
    @ResponseBody
    public boolean updateComments(Comments Comments){
        boolean re = false;
        service.updateComments(Comments);
        re = true;
        return re;
    }
}
