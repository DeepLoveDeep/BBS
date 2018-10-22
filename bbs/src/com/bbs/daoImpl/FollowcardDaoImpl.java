package com.bbs.daoImpl;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.bbs.dao.FollowcardDao;
import com.bbs.model.Followcard;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class FollowcardDaoImpl extends HibernateDaoSupport implements FollowcardDao {
    public static final String SEND_ID = "post.id";
    /* (non-Javadoc)
     * @see com.bbs.daoImpl.FollowcardDao#save(com.bbs.model.Followcard)
     */
    @Override
    public void save(Followcard followcard) {
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(followcard);
        transaction.commit();
        session.flush();
        session.close();
    }

    public Followcard findById(java.lang.Integer id) {
        try {
            Session session = getSessionFactory().openSession();
            Followcard instance = (Followcard) session.get("com.bbs.model.Followcard", id);
            session.flush();
            session.close();
            return instance;
        } catch (RuntimeException re) {
            throw re;
        }
    }
    /**
     * 删除评论
     */
    @Override
    public void delete(Integer followId) {
        Followcard followcard = findById(followId);
        followcard.setIf_delete(0);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(followcard);
        transaction.commit();
        session.flush();
        session.close();
    }
    /**
     * 点赞
     * */
    @Override
    public void greatNum(Integer id,Integer greatNum) {
        Followcard followcard = findById(id);
        followcard.setGreat_num(greatNum);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(followcard);
        transaction.commit();
        session.flush();
        session.close();
    }
    /**
     * 根据帖子id查询所有评论
     * */
    @Override
    public List<Followcard> findFollowcardBySendId(Integer send_id) {
        return findByProperty(SEND_ID, send_id);
    }
    /**
     * 全部已读
     * */
    @Override
    public void readAllBySendId(Integer send_id) {
        Session session = getSessionFactory().openSession();
        String sql = "update Followcard f set f.if_read=1 where f.post.id=? ";
        Query query = session.createQuery(sql);
        query.setInteger(0, send_id);
        int ret = query.executeUpdate();
        session.flush();
        session.close();
    }
    /**
     * 根据帖子id修改是否已读状态
     * */
    @Override
    public void readByPostId(Integer postid) {
        Session session = getSessionFactory().openSession();
        String sql = "update Followcard f set f.if_read=1 where f.post.id=? ";
        Query query = session.createQuery(sql);
        query.setInteger(0, postid);
        int ret = query.executeUpdate();
        session.flush();
        session.close();
    }

    /**
     * 根据分类查询所有评论
     * */
    public List findByProperty(String propertyName, Object value) {
        try {
            String queryString = "from Followcard as model where model."
                    + propertyName + "= ? and model.if_delete=1 order by model.followDate desc ";
            Session session = getSessionFactory().openSession();
            Query queryObject = session.createQuery(queryString);
            queryObject.setParameter(0, value);
            List list = queryObject.list();
            session.flush();
            session.close();
            return list;
        } catch (RuntimeException re) {
            throw re;
        }
    }
    /**
     * 查找评论消息总数量
     * */
    @Override
    public Long findAll( Integer postid) {
        Session session = getSessionFactory().openSession();
        String sql = "select count(*) from Followcard f where f.post.id=? and f.if_read=0 and f.if_delete= 1 ";
        Query query = session.createQuery(sql);
        query.setInteger(0, postid);
        Long num=(Long)query.uniqueResult();
        session.flush();
        session.close();
        return num;
    }

}
