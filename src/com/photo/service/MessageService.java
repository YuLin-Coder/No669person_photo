package com.photo.service;


import com.photo.entity.Message;

import java.util.List;
import java.util.Map;

public interface MessageService {
    void addMessage(Message message);

    List<Message> selectMessageList(Map<String, Object> maps);

    void deleteMessage(int id);

    Message selectMessageById(int id);

    void updateMessage(Message message);

    List<Message> selectAllMessage();

}
