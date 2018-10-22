package com.bbs.daoImpl;

import com.bbs.dao.GreatRecordDao;
import com.bbs.model.GreatRecord;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ACER NO1 on 2018/10/18.
 */
public class GreatRecordDaoImpl extends HibernateDaoSupport implements GreatRecordDao {

    private static final Logger log = LoggerFactory.getLogger(GreatRecordDao.class);

    @Override
    public GreatRecord queryIsGreatByUserId(GreatRecord greadRecord) {
        Session session = getSessionFactory().openSession();
        String sql = "from GreatRecord great where great.userId=? and great.followId=?";
        List<GreatRecord> list=new ArrayList<GreatRecord>();
       try {
           Query query = session.createQuery(sql);
           query.setInteger(0, greadRecord.getUserId());
           query.setInteger(1, greadRecord.getFollowId());
           list = query.list();
           session.flush();
           if (list.size()>0)
               return list.get(0);
           else
               return null;
       }catch(Exception e) {
           log.info("quailed failed", e);
       }finally {
           session.close();
       }
        return null;
    }

    @Override
    public void save(GreatRecord greadRecord) {
        log.debug("saving SubForum instance");
        Session session = getSessionFactory().openSession();
        try {
            session.save(greadRecord);
            log.info("save successful");
        } catch (RuntimeException re) {
            log.info("save failed", re);

        }finally {
            session.close();
        }
    }

    @Override
    public void update(GreatRecord greadRecord) {
        Session session = getSessionFactory().openSession();
       try{
           session.update(greadRecord);
           session.flush();
       }catch (RuntimeException e){
           log.info("save failed", e);
       }finally {
           session.close();
       }

    }

    @Override
    public void delete(GreatRecord greadRecord) {
        Session session = getSessionFactory().openSession();
        greadRecord=this.queryIsGreatByUserId(greadRecord);
        try {
            session.delete(greadRecord);
            session.flush();
            log.debug("delete successful");
        } catch (RuntimeException re) {
            log.error("delete failed", re);
            throw re;
        }finally{
            session.close();
        }
    }
}
