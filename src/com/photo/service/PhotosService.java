package com.photo.service;


import com.photo.entity.Photos;

import java.util.List;
import java.util.Map;

public interface PhotosService {
    void addPhotos(Photos photos);

    List<Photos> selectPhotosList(Map<String, Object> maps);

    void deletePhotos(int id);

    Photos selectPhotosById(int id);

    void updatePhotos(Photos photos);

    List<Photos> selectAllPhotos();

}
