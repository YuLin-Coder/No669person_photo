package com.photo.dao;

import com.photo.entity.Photos;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PhotosDao {
    void updatePhotos(@Param("Photos") Photos photos);

    Photos selectPhotosById(@Param("id") int id);

    void deletePhotos(@Param("id") int id);

    List<Photos> selectPhotosList(@Param("map") Map<String, Object> maps);

    void addPhotos(@Param("Photos") Photos photos);

    List<Photos> selectAllPhotos();
}
