package com.bbs.daoImpl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.bbs.dao.NoticeDao;
import com.bbs.hibernate.factory.BaseHibernateDAO;
import com.bbs.model.Notice;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class NoticeDaoImpl extends HibernateDaoSupport implements NoticeDao{
	
	/* (non-Javadoc)
	 * @see com.bbs.daoImpl.NoticeDao#getNotice(int, int)
	 */
	@Override
	public List<Notice> getNotice(int pageIndex,int pageSize){
		Session session = getSessionFactory().openSession();
		String sql = "from Notice notice order by notice.noticeDate desc ";
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
	@Override
	public void publish(Notice notice){
		Session session = getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		session.save(notice);
		transaction.commit();	
		session.flush();
		session.close();

	}

	@Override
	public Notice getNoticeById(int noticeId) {
		Session session = getSessionFactory().openSession();
		String sql = "from Notice notice where notice.id=?";
		Query query = session.createQuery(sql);
		query.setInteger(0, noticeId);
		List<Notice> list = query.list();
		session.flush();
		session.close();
		if (list.size()>0)
		return list.get(0);
		else return null;
	}

	@Override
	public List<Notice> getNoticeByType(int type, int pageIndex, int pageSize) {
		if (type > 0){
			Session session = getSessionFactory().openSession();
			String sql = "from Notice notice where notice.id=?";
			Query query = session.createQuery(sql);
			query.setInteger(0, type);
			int startIndex = (pageIndex -1) * pageSize;
			query.setFirstResult(startIndex);
			query.setMaxResults(pageSize);
			List list = query.list();
			session.flush();
			session.close();
			return list;
		}else if (type==-4){
			return getNotice(pageIndex, pageSize);
		}
		return null;

	}
	public Notice findById(java.lang.Integer id) {
		try {
			Session session = getSessionFactory().openSession();
			Notice instance = (Notice) session.get("com.bbs.model.Notice", id);
			session.flush();
			session.close();
			return instance;
		} catch (RuntimeException re) {
			throw re;
		}
	}
	/**
	 * 点赞
	 * */
	@Override
	public void greatNum(Integer id,Integer greatNum) {
		Notice notice = findById(id);
		notice.setGreatNum(greatNum);
		Session session = getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		session.update(notice);
		transaction.commit();
		session.flush();
		session.close();
	}

}
