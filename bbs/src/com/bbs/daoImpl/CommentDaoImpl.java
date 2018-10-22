package com.bbs.daoImpl;

import com.bbs.dao.CommentDao;
import com.bbs.model.Comment;
import com.bbs.model.Followcard;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;


public class CommentDaoImpl extends HibernateDaoSupport implements CommentDao {
    /**
     * 添加评论回复
     */
    @Override
    public void save(Comment comment){
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(comment);
        transaction.commit();
        session.flush();
        session.close();
    }

    /**
     * 根据评论id查找回复信息
     * */
    @Override
    public List<Comment> findByUser_receive(Integer followId) {
        try {
            String queryString = "from Comment as c where c.followcard.id=? and c.if_delete=1 order by c.date desc ";
            Session session = getSessionFactory().openSession();
            Query queryObject = session.createQuery(queryString);
            queryObject.setParameter(0, followId);
            List list = queryObject.list();
            session.flush();
            session.close();
            return list;
        } catch (RuntimeException re) {
            throw re;
        }
    }

    public Comment findById(Integer id) {
        try {
            Session session = getSessionFactory().openSession();
            Comment instance = (Comment) session.get("com.bbs.model.Comment", id);
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
    public void delete(Integer commentId) {
        Comment comment = findById(commentId);
        comment.setIf_delete(0);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(comment);
        transaction.commit();
        session.flush();
        session.close();
    }
    /**
     * 点赞
     * */
    @Override
    public void greatNum(Integer id,Integer greatNum) {
        Comment comment = findById(id);
        comment.setGreat_num(greatNum);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(comment);
        transaction.commit();
        session.flush();
        session.close();
    }

}
