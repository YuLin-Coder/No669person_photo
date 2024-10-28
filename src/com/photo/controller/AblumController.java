package com.photo.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.Category;
import com.photo.entity.Ablum;
import com.photo.entity.User;
import com.photo.service.CategoryService;
import com.photo.service.AblumService;
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
public class AblumController {

    @Autowired
    AblumService service;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");

    @Autowired
    CategoryService categoryService;

    @Autowired
    UserService userService;

    /**
     * 相册列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/AblumList")
    public ModelAndView AblumList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        List<Ablum> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        PageHelper.startPage(currentPage,8);
        list=service.selectAblumList(maps);
        for(Ablum data :list){
            data.setUser(userService.selectUserById(data.getUid()));
            data.setCategory(categoryService.selectCategoryById(data.getCid()));
        }
        PageInfo<Ablum> pageInfo=new PageInfo<Ablum>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/ablum/list");
    }

    /**
     *
     * 去新增相册页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toAddAblum")
    public ModelAndView toAddAblum(HttpServletRequest request, ModelAndView mv){
        List<Category> categoryList = categoryService.selectAllCategory();
        mv.addObject("categoryList", categoryList);
        mv.setViewName("views/ablum/add");
        return mv;
    }

    /**
     * 新增相册
     * @param Ablum
     * @return
     */
    @RequestMapping("/addAblum")
    @ResponseBody
    public boolean addAblum(Ablum Ablum,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        Ablum.setCreate_date(new  SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        boolean re = false;
        if(user != null){
            Ablum.setUid(user.getId());
            service.addAblum(Ablum);
            re = true;
        }
        return re;
    }

    /**
     * 删除相册
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteAblum")
    public boolean deleteAblum(Integer id ,HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        service.deleteAblum(id);
        re = true;
        return re;
    }

    /**
     * 去修改相册页面
     * @param id
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdateAblum")
    public ModelAndView toUpdateAblum(Integer id ,HttpServletRequest request, ModelAndView mv){
        Ablum Ablum = service.selectAblumById(id);
        mv.addObject("data", Ablum);
        List<Category> categoryList = categoryService.selectAllCategory();
        mv.addObject("categoryList", categoryList);
        mv.setViewName("views/ablum/update");
        return mv;
    }


    /**
     * 修改相册
     * @param Ablum
     * @return
     */
    @RequestMapping("/updateAblum")
    @ResponseBody
    public boolean updateAblum(Ablum Ablum){
        boolean re = false;
        service.updateAblum(Ablum);
        re = true;
        return re;
    }
}
