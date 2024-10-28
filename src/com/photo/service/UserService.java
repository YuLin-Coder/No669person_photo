package com.photo.service;


import com.photo.entity.Admin;
import com.photo.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    void addUser(User student);

    Admin selectAdmin(String username, String password);

    User selectUser(String username, String password);

    List<User> selectUserList(Map<String, Object> maps);

    User selectUserByPhone(User student);

    void deleteUser(int id);

    User selectUserById(int id);

    void updateUser(User student);

    void updateAdmin(Admin admin);
}
