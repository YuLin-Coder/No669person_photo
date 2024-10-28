package com.photo.dao;

import com.photo.entity.Friend;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface FriendDao {
    void updateFriend(@Param("Friend") Friend category);

    Friend selectFriendById(@Param("id") int id);

    void deleteFriend(@Param("id") int id);

    List<Friend> selectFriendList(@Param("map") Map<String, Object> maps);

    void addFriend(@Param("Friend") Friend category);

    List<Friend> selectAllFriend();

    Friend selectByMidAndUid(@Param("id") Integer id, @Param("mid") Integer mid);

    Friend selectByUidAndMid(@Param("id") Integer id, @Param("mid") Integer mid);
}
