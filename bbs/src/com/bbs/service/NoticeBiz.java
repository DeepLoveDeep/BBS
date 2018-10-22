package com.bbs.service;

import java.util.List;

import com.bbs.model.Notice;

public interface NoticeBiz {
    //获取所有公告
    public abstract List<Notice> getNotice(int pageIndex, int pageSize);

    //发布公告
    public abstract void publish(Notice notice);

    //根据id查询公告
    public Notice getNoticeById(int noticeId);

    //更多公告
    public List<Notice> getNoticeByType(int type, int pageIndex, int pageSize);
    /**
     * 根据公告id写入点赞数
     */
    public void greatNum(Integer id,Integer greatNum);
}