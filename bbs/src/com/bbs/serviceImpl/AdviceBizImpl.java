package com.bbs.serviceImpl;

import com.bbs.dao.AdviceDao;
import com.bbs.dao.NoticeDao;
import com.bbs.model.Advice;
import com.bbs.model.Notice;
import com.bbs.service.AdviceBiz;
import com.bbs.service.NoticeBiz;

import java.util.List;

/**
 * 
 * @author Shen
 * @version 1.0
 * 2018年6月16日下午1:32:23
 */
public class AdviceBizImpl implements AdviceBiz {
	private AdviceDao adviceDao;
	private Integer postId;
	
	public void setAdviceDao(AdviceDao advcieDao) {
		this.adviceDao = advcieDao;
	}

	@Override
	public  List<Advice> getAdvice(int pageIndex, int pageSize){
		return adviceDao.getAdvice(pageIndex, pageSize);
	}

	@Override
	public  void publish(Advice advice){
		adviceDao.publish(advice);
		
	}
	public Advice getAdviceById(int adviceId){
		return adviceDao.getAdviceById(adviceId);
		
	}

	@Override
	public void delete(int adviceId) {
		adviceDao.delete(adviceId);

	}

}
