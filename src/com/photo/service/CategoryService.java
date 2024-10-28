package com.photo.service;


import com.photo.entity.Category;

import java.util.List;
import java.util.Map;

public interface CategoryService {
    void addCategory(Category category);

    List<Category> selectCategoryList(Map<String, Object> maps);

    void deleteCategory(int id);

    Category selectCategoryById(int id);

    void updateCategory(Category category);

    List<Category> selectAllCategory();

}
