package com.photo.dao;

import com.photo.entity.Tips;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TipsDao {
    void updateTips(@Param("Tips") Tips tips);

    Tips selectTipsById(@Param("id") int id);

    void deleteTips(@Param("id") int id);

    List<Tips> selectTipsList(@Param("map") Map<String, Object> maps);

    void addTips(@Param("Tips") Tips tips);

}
