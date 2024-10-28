package com.photo.dao;

import com.photo.entity.Admin;
import com.photo.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserDao {
    void updateUser(@Param("User") User student);

    User selectUserById(@Param("id") int id);

    void deleteUser(@Param("id") int id);

    User selectUserByPhone(@Param("User") User student);

    List<User> selectUserList(@Param("map") Map<String, Object> maps);

    User selectUser(@Param("username") String username, @Param("password") String password);

    Admin selectAdmin(@Param("username") String username, @Param("password") String password);

    void addUser(@Param("User") User student);

    void updateAdmin(@Param("admin") Admin admin);
}
