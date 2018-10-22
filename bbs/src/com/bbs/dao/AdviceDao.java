package com.bbs.dao;

import com.bbs.model.Advice;
import com.bbs.model.Notice;

import java.util.List;

/**
 *
 * @author Shen
 * @version 1.0
 * 2018年6月16日下午1:32:23
 */
public interface AdviceDao {

	public  List<Advice> getAdvice(int pageIndex, int pageSize);

	public  void publish(Advice advice);

	public Advice getAdviceById(int adviceId);

	public void delete(int adviceId);
}