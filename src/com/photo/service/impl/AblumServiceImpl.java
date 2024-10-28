package com.photo.service.impl;

import com.photo.dao.AblumDao;
import com.photo.entity.Photos;
import com.photo.entity.Ablum;
import com.photo.service.AblumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AblumServiceImpl implements AblumService {

    @Autowired
    AblumDao dao;

    @Override
    public void addAblum(Ablum ablum) {
        dao.addAblum(ablum);
    }

    @Override
    public List<Ablum> selectAblumList(Map<String, Object> maps) {
        return   dao.selectAblumList(maps);
    }

    @Override
    public void deleteAblum(int id) {
        dao.deleteAblum(id);
    }

    @Override
    public Ablum selectAblumById(int id) {
        return  dao.selectAblumById(id);
    }

    @Override
    public void updateAblum(Ablum ablum) {
        dao.updateAblum(ablum);
    }







}
