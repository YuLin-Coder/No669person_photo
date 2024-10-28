package com.photo.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.Admin;
import com.photo.entity.User;
import com.photo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;


@RestController
public class UserController {

    @Autowired
    UserService service;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");

    /**
     * 注册
     * @param student
     * @param mv
     * @return
     */
    @RequestMapping("/registerUser")
    public ModelAndView registerUser(User student, ModelAndView mv){
        student.setRegiste_time(simpleDateFormat.format(new Date()));
        service.addUser(student);
        mv.setViewName("view/login");
        return mv;
    }

    /**
     * 登录
     * @param username
     * @param request
     * @param password
     * @param session
     * @param response
     * @param mv
     * @return
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping("/login")
    @ResponseBody
    public  String login(@RequestParam("username")String username,
                         HttpServletRequest request, @RequestParam("password")String password,
                         HttpSession session, HttpServletResponse response, ModelAndView mv) throws ServletException, IOException {
        session.removeAttribute("admin");
        session.removeAttribute("student");
        String type=request.getParameter("type").toString();
        request.getSession().setAttribute("type", type);
        String message = "error";
        if(type != null && type.equals("1")){
            Admin admin1 = service.selectAdmin(username,password);
            if(admin1 != null){
                request.getSession().setAttribute("admin", admin1);
                message = "ok";
            }
        }else if(type != null && type.equals("2")){
            User te = service.selectUser(username,password);
            if(te != null){
                request.getSession().setAttribute("user", te);
                message = "toIndex";
            }
        }
        return message;

    }

    /**
     * 用户列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/UserList")
    public ModelAndView UserList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        String state = request.getParameter("state");
        List<User> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("state", state);
        PageHelper.startPage(currentPage,8);
        list=service.selectUserList(maps);
        PageInfo<User> pageInfo=new PageInfo<User>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/user/list");
    }

    /**
     * 去新增用户页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toAddUser")
    public ModelAndView toAddUser(HttpServletRequest request, ModelAndView mv){
        mv.setViewName("views/user/add");
        return mv;
    }

    /**
     * 新增用户
     * @param User
     * @return
     */
    @RequestMapping("/addUser")
    @ResponseBody
    public boolean addUser(User User){
        User.setRegiste_time(new  SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        boolean re = false;
        User student = service.selectUserByPhone(User);
        if(student ==null){
            service.addUser(User);
            re = true;
        }
        return re;
    }

    /**
     * 删除用户
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteUser")
    public boolean deleteUser(Integer id ,HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        service.deleteUser(id);
        re = true;
        return re;
    }


    /**
     * 去修改用户页面
     * @param id
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdateUser")
    public ModelAndView toUpdateUser(Integer id ,HttpServletRequest request, ModelAndView mv){
        User User = service.selectUserById(id);
        mv.addObject("data", User);
        mv.setViewName("views/user/update");
        return mv;
    }


    /**
     * 修改用户
     * @param User
     * @return
     */
    @RequestMapping("/updateUser")
    @ResponseBody
    public boolean updateUser(User User){
        boolean re = false;
        service.updateUser(User);
        re = true;
        return re;
    }


    /**
     * 去修改管理员页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdateAdmin")
    public ModelAndView toUpdateAdminPassword(HttpServletRequest request,ModelAndView mv){
        mv.setViewName("views/admin/update");
        return mv;
    }


    /**
     * 修改管理员密码
     * @param request
     * @return
     */
    @RequestMapping("/updateAdmin")
    @ResponseBody
    public boolean updateAdmin(Admin admin,HttpServletRequest request){
        boolean re = false;
        service.updateAdmin(admin);
        re = true;
        return re;
    }

}
