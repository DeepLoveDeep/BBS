package com.bbs.dao;

import java.util.List;

import com.bbs.model.Notice;

/**
 * @author Shen
 * @version 1.0
 *          2018年6月22日上午9:52:33
 */
public interface NoticeDao {
    //获取所有公告
    public List<Notice> getNotice(int pageIndex, int pageSize);

    //发布公告
    public void publish(Notice notice);

    //根据id查询公告
    public Notice getNoticeById(int noticeId);

    //更多公告
    public List<Notice> getNoticeByType(int type, int pageIndex, int pageSize);
    /**
     * 根据帖子id写入点赞数
     */
    public void greatNum(Integer id,Integer greatNum);
}