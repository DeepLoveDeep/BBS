package com.bbs.service;

import com.bbs.model.Followcard;

import java.util.List;

public interface FollowcardBiz {

    public abstract void addReply(Followcard followcard);
    /**
     * 删除评论
     * */
    public abstract void delete(Integer followId);
    /**
     * 根据评论id写入点赞数
     */
    public void greatNum(Integer id, Integer greatNum);

    /**
     * 根据帖子id查询所有评论
     * */
    public List<Followcard> findFollowcardBySendId(Integer send_id);
    /**
     * 全部已读
     * */
    public void readAllBySendId(Integer send_id);
    /**
     * 根据帖子id修改是否已读状态
     * */
    public  void readByPostId( Integer postid );

    /**
     * 查找评论消息总数量
     * */
    public Long findAll( Integer userid);
}