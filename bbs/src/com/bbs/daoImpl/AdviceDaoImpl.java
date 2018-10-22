package com.bbs.daoImpl;

import com.bbs.dao.AdviceDao;
import com.bbs.hibernate.factory.BaseHibernateDAO;
import com.bbs.model.Advice;
import com.bbs.model.Notice;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

import static com.bbs.hibernate.factory.HibernateSessionFactory.getSession;

public class AdviceDaoImpl extends HibernateDaoSupport implements AdviceDao {
	
	/* (non-Javadoc)
	 * @see com.bbs.daoImpl.NoticeDao#getNotice(int, int)
	 */
	//获取所有反馈信息
	public List<Advice> getAdvice(int pageIndex,int pageSize){
		Session session = getSessionFactory().openSession();
		String sql = "from Advice advice order by advice.adviceDate desc ";
		Query query = session.createQuery(sql);
		int startIndex = (pageIndex -1) * pageSize;
		query.setFirstResult(startIndex);
		query.setMaxResults(pageSize);
		List list = query.list();
		session.flush();
		session.close();
		return list;
	}
	
	/* (non-Javadoc)
	 * @see com.bbs.daoImpl.NoticeDao#publish(com.bbs.model.Notice)
	 */
	//添加反馈信息
	@Override
	public void publish(Advice advice){
		Session session = getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		session.save(advice);
		transaction.commit();	
		session.flush();
		session.close();

	}
	//根据id查询反馈信息
	@Override
	public Advice getAdviceById(int noticeId) {
		Session session = getSessionFactory().openSession();
		String sql = "from Advice advice where advice.id=?";
		Query query = session.createQuery(sql);
		query.setInteger(0, noticeId);
		List<Advice> list = query.list();
		session.flush();
		session.close();
		if (list.size()>0)
		return list.get(0);
		else return null;
	}
	//根据id删除反馈信息
	@Override
	public void delete(int adviceId){
		Advice advice = getAdviceById(adviceId);
		Session session = getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		session.delete(advice);
		transaction.commit();
		session.flush();
		session.close();
	}

}
