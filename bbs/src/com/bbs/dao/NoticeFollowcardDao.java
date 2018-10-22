package com.bbs.dao;

import com.bbs.model.Followcard;
import com.bbs.model.NoticeFollowcard;

import java.util.List;

public interface NoticeFollowcardDao {

    public  void save(NoticeFollowcard followcard);

    /**
     * 删除评论
     */
    public  void delete(Integer followId);

    /**
     * 根据帖子id写入点赞数
     */
    public void greatNum(Integer id, Integer greatNum);

    /**
     * 根据帖子id查询所有评论
     * */
    public List<NoticeFollowcard> findFollowcardBySendId(Integer noticeId);
}