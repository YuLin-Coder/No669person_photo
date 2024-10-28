package com.photo.service.impl;

import com.photo.dao.PhotosDao;
import com.photo.entity.Photos;
import com.photo.service.PhotosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PhotosServiceImpl implements PhotosService {

    @Autowired
    PhotosDao dao;

    @Override
    public void addPhotos(Photos photos) {
        dao.addPhotos(photos);
    }

    @Override
    public List<Photos> selectPhotosList(Map<String, Object> maps) {
        return   dao.selectPhotosList(maps);
    }

    @Override
    public void deletePhotos(int id) {
        dao.deletePhotos(id);
    }

    @Override
    public Photos selectPhotosById(int id) {
        return  dao.selectPhotosById(id);
    }

    @Override
    public void updatePhotos(Photos photos) {
        dao.updatePhotos(photos);
    }

    @Override
    public List<Photos> selectAllPhotos() {
        return    dao.selectAllPhotos();
    }

}
