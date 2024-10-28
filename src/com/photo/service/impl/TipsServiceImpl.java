package com.photo.service.impl;

import com.photo.dao.TipsDao;
import com.photo.entity.Tips;
import com.photo.service.TipsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TipsServiceImpl implements TipsService {

    @Autowired
    TipsDao dao;

    @Override
    public void addTips(Tips tips) {
        dao.addTips(tips);
    }

    @Override
    public List<Tips> selectTipsList(Map<String, Object> maps) {
        return   dao.selectTipsList(maps);
    }

    @Override
    public void deleteTips(int id) {
        dao.deleteTips(id);
    }

    @Override
    public Tips selectTipsById(int id) {
        return  dao.selectTipsById(id);
    }

    @Override
    public void updateTips(Tips tips) {
        dao.updateTips(tips);
    }

}
