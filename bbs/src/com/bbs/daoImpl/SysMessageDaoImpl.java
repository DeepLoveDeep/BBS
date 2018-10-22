package com.bbs.daoImpl;

import com.bbs.dao.SysMessageDao;
import com.bbs.model.SysMessage;
import com.bbs.model.SysUser;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;


public class SysMessageDaoImpl extends HibernateDaoSupport implements SysMessageDao {

    /**
     * 查找系统消息总数量
     * */
    @Override
    public Long findAll( Integer userid) {
        Session session = getSessionFactory().openSession();
        String sql = "select count(*) from SysUser s where s.user.id=? and s.if_read=0 and s.if_delete= 1 ";
        Query query = session.createQuery(sql);
        query.setInteger(0, userid);
        Long num=(Long)query.uniqueResult();
        session.flush();
        session.close();
        return num;
    }
    /**
     * 查找所有系统消息
     * */
    @Override
    public List<SysUser> findAllByUserId(Integer userId ) {
        Session session = getSessionFactory().openSession();
        String sql = "from  SysUser s where s.user.id=? and s.if_delete= 1  order by s.sysMessage.date desc";
        Query query = session.createQuery(sql);
        query.setInteger(0, userId);
        List list = query.list();
        session.flush();
        session.close();
        return list;
    }
}
