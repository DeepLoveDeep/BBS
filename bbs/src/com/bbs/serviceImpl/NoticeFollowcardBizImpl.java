package com.bbs.serviceImpl;

import com.bbs.dao.FollowcardDao;
import com.bbs.dao.NoticeFollowcardDao;
import com.bbs.model.Followcard;
import com.bbs.model.NoticeFollowcard;
import com.bbs.service.FollowcardBiz;
import com.bbs.service.NoticeFollowcardBiz;

import java.util.List;

/**
 * @author Shen
 * @version 1.0
 *          2018年6月16日下午1:32:23
 */
public class NoticeFollowcardBizImpl implements NoticeFollowcardBiz {

    private NoticeFollowcardDao noticefollowcardDao;

    public void setNoticefollowcardDao(NoticeFollowcardDao noticefollowcardDao) {
        this.noticefollowcardDao = noticefollowcardDao;
    }
/* *(non-Javadoc)
     * @see com.bbs.bizImpl.FollowcardBiz#addReply(com.bbs.model.Followcard)
     */

    @Override
    public void addFollow(NoticeFollowcard followcard) {
        noticefollowcardDao.save(followcard);

    }

    /**
     * 删除评论
     */
    @Override
    public void delete(Integer followId) {
        noticefollowcardDao.delete(followId);
    }
    /**
     * 根据评论id写入点赞数
     */
    @Override
    public void greatNum(Integer id,Integer greatNum) {
        noticefollowcardDao.greatNum(id,greatNum);
    }
    /**
     * 根据公告id查询所有评论
     * */
    @Override
    public List<NoticeFollowcard> findFollowcardBySendId(Integer noticeId) {
        return noticefollowcardDao.findFollowcardBySendId(noticeId);
    }
}
