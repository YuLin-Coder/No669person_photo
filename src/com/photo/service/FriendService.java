package com.photo.service;


import com.photo.entity.Friend;

import java.util.List;
import java.util.Map;

public interface FriendService {
    void addFriend(Friend category);

    List<Friend> selectFriendList(Map<String, Object> maps);

    void deleteFriend(int id);

    Friend selectFriendById(int id);

    void updateFriend(Friend category);

    List<Friend> selectAllFriend();

    Friend selectByMidAndUid(Integer id, Integer id1);

    Friend selectByUidAndMid(Integer id, Integer id1);
}
