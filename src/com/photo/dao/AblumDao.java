package com.photo.dao;

import com.photo.entity.Ablum;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AblumDao {
    void updateAblum(@Param("Ablum") Ablum ablum);

    Ablum selectAblumById(@Param("id") int id);

    void deleteAblum(@Param("id") int id);

    List<Ablum> selectAblumList(@Param("map") Map<String, Object> maps);

    void addAblum(@Param("Ablum") Ablum ablum);

}
