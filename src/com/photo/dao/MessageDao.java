package com.photo.dao;

import com.photo.entity.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MessageDao {
    void updateMessage(@Param("Message") Message message);

    Message selectMessageById(@Param("id") int id);

    void deleteMessage(@Param("id") int id);

    List<Message> selectMessageList(@Param("map") Map<String, Object> maps);

    void addMessage(@Param("Message") Message message);

    List<Message> selectAllMessage();
}
