package com.photo.service.impl;

import com.photo.dao.UserDao;
import com.photo.entity.Admin;
import com.photo.entity.User;
import com.photo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao dao;

    @Override
    public void addUser(User student) {
        dao.addUser(student);
    }

    @Override
    public Admin selectAdmin(String username, String password) {
        return   dao.selectAdmin(username,password);
    }

    @Override
    public User selectUser(String username, String password) {
        return   dao.selectUser(username,password);
    }

    @Override
    public List<User> selectUserList(Map<String, Object> maps) {
        return   dao.selectUserList(maps);
    }

    @Override
    public User selectUserByPhone(User student) {
        return   dao.selectUserByPhone(student);
    }

    @Override
    public void deleteUser(int id) {
        dao.deleteUser(id);
    }

    @Override
    public User selectUserById(int id) {
        return  dao.selectUserById(id);
    }

    @Override
    public void updateUser(User student) {
        dao.updateUser(student);
    }

    @Override
    public void updateAdmin(Admin admin) {
        dao.updateAdmin(admin);
    }


}
