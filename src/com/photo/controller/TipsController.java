package com.photo.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.photo.entity.Tips;
import com.photo.service.TipsService;
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
public class TipsController {

    @Autowired
    TipsService service;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");


    /**
     * 标签列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("TipsList")
    public ModelAndView TipsList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        String state = request.getParameter("state");
        List<Tips> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("state", state);
        PageHelper.startPage(currentPage,8);
        list=service.selectTipsList(maps);
        PageInfo<Tips> pageInfo=new PageInfo<Tips>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/tips/list");
    }

    /**
     *
     * 去新增标签页面
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toAddTips")
    public ModelAndView toAddTips(HttpServletRequest request, ModelAndView mv){
        mv.setViewName("views/tips/add");
        return mv;
    }

    /**
     * 新增标签
     * @param Tips
     * @return
     */
    @RequestMapping("/addTips")
    @ResponseBody
    public boolean addTips(Tips Tips){
        boolean re = false;
        service.addTips(Tips);
        re = true;
        return re;
    }

    /**
     * 删除标签
     * @param id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteTips")
    public boolean deleteTips(Integer id ,HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        service.deleteTips(id);
        re = true;
        return re;
    }

    /**
     * 去修改标签页面
     * @param id
     * @param request
     * @param mv
     * @return
     */
    @RequestMapping("/toUpdateTips")
    public ModelAndView toUpdateTips(Integer id ,HttpServletRequest request, ModelAndView mv){
        Tips Tips = service.selectTipsById(id);
        mv.addObject("data", Tips);
        mv.setViewName("views/tips/update");
        return mv;
    }


    /**
     * 修改标签
     * @param Tips
     * @return
     */
    @RequestMapping("/updateTips")
    @ResponseBody
    public boolean updateTips(Tips Tips){
        boolean re = false;
        service.updateTips(Tips);
        re = true;
        return re;
    }
}
