package com.photo.service.impl;

import com.photo.dao.MessageDao;
import com.photo.entity.Message;
import com.photo.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    MessageDao dao;

    @Override
    public void addMessage(Message message) {
        dao.addMessage(message);
    }

    @Override
    public List<Message> selectMessageList(Map<String, Object> maps) {
        return   dao.selectMessageList(maps);
    }

    @Override
    public void deleteMessage(int id) {
        dao.deleteMessage(id);
    }

    @Override
    public Message selectMessageById(int id) {
        return  dao.selectMessageById(id);
    }

    @Override
    public void updateMessage(Message message) {
        dao.updateMessage(message);
    }

    @Override
    public List<Message> selectAllMessage() {
        return    dao.selectAllMessage();
    }

}
