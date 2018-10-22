package com.bbs.service;

import com.bbs.model.Advice;
import java.util.List;

public interface AdviceBiz {

	public abstract List<Advice> getAdvice(int pageIndex, int pageSize);

	public abstract void publish(Advice advice);
	public Advice getAdviceById(int adviceId);
	public void delete(int adviceId);
}