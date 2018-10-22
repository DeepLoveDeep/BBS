package com.bbs.daoImpl;

import com.bbs.dao.SysUserDao;
import com.bbs.model.SysUser;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;



public class SysUserDaoImpl extends HibernateDaoSupport implements SysUserDao {

    /**
     * 查找所有系统消息
     * */
    /**
     * 根据用户id修改系统消息状态
     * */
    @Override
    public void readAll(Integer userid) {
        Session session = getSessionFactory().openSession();
        String sql = "update SysUser s set s.if_read=1 where s.user.id=? ";
        Query query = session.createQuery(sql);
        query.setInteger(0, userid);
        int ret = query.executeUpdate();
        session.flush();
        session.close();
    }
}
