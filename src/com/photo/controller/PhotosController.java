package com.photo.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.Ablum;
import com.photo.entity.Photos;
import com.photo.entity.Tips;
import com.photo.entity.User;
import com.photo.service.AblumService;
import com.photo.service.PhotosService;
import com.photo.service.TipsService;
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
public class PhotosController {

    @Autowired
    PhotosService service;

    @Autowired
    AblumService ablumService;
    @Autowired
    TipsService tipsService;
    @Autowired
    UserService userService;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");


    /**
     * 相片列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/PhotosList")
    public ModelAndView PhotosList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        List<Photos> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        PageHelper.startPage(currentPage,8);
        list=service.selectPhotosList(maps);
        for(Photos data:list){
            data.setTips(tipsService.selectTipsById(data.getTid()));
            data.setUser(userService.selectUserById(data.getUid()));
            data.setAblum(ablumService.selectAblumById(data.getAid()));
        }
        PageInfo<Photos> pageInfo=new PageInfo<Photos>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/photos/list");
    }

    /**
     *
     * 去新增相片页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toAddPhotos")
    public ModelAndView toAddPhotos(HttpServletRequest request, ModelAndView mv){
        List<Tips> tips =tipsService.selectTipsList(new HashMap<>());
        User user = (User)request.getSession().getAttribute("user");
        Map<String,Object> maps = new HashMap<>();
        maps.put("uid", user!=null?user.getId():null);
        List<Ablum> ablums = ablumService.selectAblumList(maps);
        request.setAttribute("tips",tips);
        request.setAttribute("ablums",ablums);
        mv.setViewName("views/photos/add");
        return mv;
    }

    /**
     * 新增相片
     * @param Photos
     * @return
     */
    @RequestMapping("/addPhotos")
    @ResponseBody
    public boolean addPhotos(HttpServletRequest request,Photos Photos){
        boolean re = false;
        User user = (User)request.getSession().getAttribute("user");
        if(user != null){
            Photos.setUid(user.getId());
            Photos.setCreate_time(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
            service.addPhotos(Photos);
            re = true;
        }
        return re;
    }

    /**
     * 删除相片
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deletePhotos")
    public boolean deletePhotos(Integer id ,HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        service.deletePhotos(id);
        re = true;
        return re;
    }

    /**
     * 去修改相片页面
     * @param id
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdatePhotos")
    public ModelAndView toUpdatePhotos(Integer id ,HttpServletRequest request, ModelAndView mv){
        User user = (User)request.getSession().getAttribute("user");
        Photos Photos = service.selectPhotosById(id);
        mv.addObject("data", Photos);
        List<Tips> tips =tipsService.selectTipsList(new HashMap<>());
        Map<String,Object> maps = new HashMap<>();
        maps.put("uid", user!=null?user.getId():null);
        List<Ablum> ablums = ablumService.selectAblumList(maps);
        request.setAttribute("tips",tips);
        request.setAttribute("ablums",ablums);
        mv.setViewName("views/photos/update");
        return mv;
    }


    /**
     * 修改相片
     * @param Photos
     * @return
     */
    @RequestMapping("/updatePhotos")
    @ResponseBody
    public boolean updatePhotos(Photos Photos){
        boolean re = false;
        service.updatePhotos(Photos);
        re = true;
        return re;
    }
}
