package com.bbs.dao;

import com.bbs.model.Followcard;

import java.util.List;

public interface FollowcardDao {

    public abstract void save(Followcard followcard);

    /**
     * 删除评论
     */
    public abstract void delete(Integer followId);

    /**
     * 根据帖子id写入点赞数
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