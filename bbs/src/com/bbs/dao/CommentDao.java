package com.bbs.dao;

import com.bbs.model.Comment;

import java.util.List;

public interface CommentDao {

    /**
     * 删除评论
     */
    public abstract void delete(Integer followId);

    /**
     * 添加评论回复
     */
    public  void save(Comment comment);
    /**
     * 根据评论id查找回复信息
     * */
    public List<Comment> findByUser_receive(Integer followId);

    /**
     * 根据回复id写入点赞数
     */
    public void greatNum(Integer id, Integer greatNum);
}