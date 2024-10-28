package com.photo.service;


import com.photo.entity.Tips;

import java.util.List;
import java.util.Map;

public interface TipsService {
    void addTips(Tips tips);

    List<Tips> selectTipsList(Map<String, Object> maps);

    void deleteTips(int id);

    Tips selectTipsById(int id);

    void updateTips(Tips tips);

}
