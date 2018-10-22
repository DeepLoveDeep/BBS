package com.bbs.serviceImpl;

import com.bbs.dao.FollowcardDao;
import com.bbs.hibernate.factory.BaseHibernateDAO;
import com.bbs.model.Followcard;
import com.bbs.service.FollowcardBiz;

import java.util.List;

/**
 * @author Shen
 * @version 1.0
 *          2018年6月16日下午1:32:23
 */
public class FollowcardBizImpl implements FollowcardBiz {

    private FollowcardDao followcardDao;

    public void setFollowcardDao(FollowcardDao followcardDao) {
        this.followcardDao = followcardDao;
    }

    /* *(non-Javadoc)
     * @see com.bbs.bizImpl.FollowcardBiz#addReply(com.bbs.model.Followcard)
     */
    @Override
    public void addReply(Followcard followcard) {
        followcardDao.save(followcard);
    }

    /**
     * 删除评论
     */
    @Override
    public void delete(Integer followId) {
        followcardDao.delete(followId);
    }
    /**
     * 根据评论id写入点赞数
     */
    @Override
    public void greatNum(Integer id,Integer greatNum) {
        followcardDao.greatNum(id,greatNum);
    }
    /**
     * 根据帖子id查询所有评论
     * */
    @Override
    public List<Followcard> findFollowcardBySendId(Integer send_id) {
        return followcardDao.findFollowcardBySendId(send_id);
    }
    /**
     * 全部已读
     * */
    @Override
    public void readAllBySendId(Integer send_id) {
         followcardDao.readAllBySendId(send_id);
    }
    /**
     * 根据帖子id修改是否已读状态
     * */
    public  void readByPostId( Integer postid){
        followcardDao.readByPostId(postid);
    }
    /**
     * 查找评论消息总数量
     * */
    @Override
    public Long findAll(Integer userid) {
        return followcardDao.findAll(userid);
    }
}
