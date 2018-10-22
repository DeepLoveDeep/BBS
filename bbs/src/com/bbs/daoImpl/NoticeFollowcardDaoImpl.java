package com.bbs.daoImpl;

import com.bbs.dao.NoticeFollowcardDao;
import com.bbs.model.NoticeFollowcard;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class NoticeFollowcardDaoImpl extends HibernateDaoSupport implements NoticeFollowcardDao {
    public static final String NOTICE_ID = "notice.id";
    /* (non-Javadoc)
     * @see com.bbs.daoImpl.FollowcardDao#save(com.bbs.model.Followcard)
     */
    @Override
    public void save(NoticeFollowcard followcard) {
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(followcard);
        transaction.commit();
        session.flush();
        session.close();
    }

    public NoticeFollowcard findById(Integer id) {
        try {
            Session session = getSessionFactory().openSession();
            NoticeFollowcard instance = (NoticeFollowcard) session.get("com.bbs.model.NoticeFollowcard", id);
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
        NoticeFollowcard followcard = findById(followId);
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
        NoticeFollowcard followcard = findById(id);
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
    public List<NoticeFollowcard> findFollowcardBySendId(Integer noticeId) {
        return findByProperty(NOTICE_ID, noticeId);
    }
    /**
     * 根据分类查询所有评论
     * */
    public List findByProperty(String propertyName, Object value) {
        try {
            String queryString = "from NoticeFollowcard as model where model."
                    + propertyName + "= ? order by model.date desc ";
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

}
