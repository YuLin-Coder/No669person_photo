package com.photo.service.impl;

import com.photo.dao.FriendDao;
import com.photo.entity.Friend;
import com.photo.service.FriendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class FriendServiceImpl implements FriendService {

    @Autowired
    FriendDao dao;

    @Override
    public void addFriend(Friend category) {
        dao.addFriend(category);
    }

    @Override
    public List<Friend> selectFriendList(Map<String, Object> maps) {
        return   dao.selectFriendList(maps);
    }

    @Override
    public void deleteFriend(int id) {
        dao.deleteFriend(id);
    }

    @Override
    public Friend selectFriendById(int id) {
        return  dao.selectFriendById(id);
    }

    @Override
    public void updateFriend(Friend category) {
        dao.updateFriend(category);
    }

    @Override
    public List<Friend> selectAllFriend() {
        return    dao.selectAllFriend();
    }

    @Override
    public Friend selectByMidAndUid(Integer id, Integer mid) {
        return dao.selectByMidAndUid(id,mid);
    }

    @Override
    public Friend selectByUidAndMid(Integer id, Integer mid) {
        return dao.selectByUidAndMid(id,mid);
    }

}
