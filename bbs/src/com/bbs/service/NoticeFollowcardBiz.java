package com.bbs.service;

import com.bbs.model.Followcard;
import com.bbs.model.NoticeFollowcard;

import java.util.List;

public interface NoticeFollowcardBiz {

    public  void addFollow(NoticeFollowcard followcard);
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
    public List<NoticeFollowcard> findFollowcardBySendId(Integer noticeId);
}