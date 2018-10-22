package com.bbs.service;

import com.bbs.model.Comment;

import java.util.List;

public interface CommentBiz {

    /**
     * 添加评论回复
     */
    public void addReply(Comment comment);
    /**
     * 删除评论
     * */
    public  void delete(Integer followId);
  /**
   * 根据评论id查找回复信息
   * */
    public List<Comment> findByFollowId(Integer followId);
    /**
     * 根据回复id写入点赞数
     */
    public void greatNum(Integer id, Integer greatNum);
}