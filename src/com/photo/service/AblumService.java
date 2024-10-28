package com.photo.service;


import com.photo.entity.Photos;
import com.photo.entity.Ablum;

import java.util.List;
import java.util.Map;

public interface AblumService {
    void addAblum(Ablum goods);

    List<Ablum> selectAblumList(Map<String, Object> maps);

    void deleteAblum(int id);

    Ablum selectAblumById(int id);

    void updateAblum(Ablum goods);



}
