package com.bbs.action;

import com.bbs.model.Advice;
import com.bbs.model.User;
import com.bbs.service.AdviceBiz;

import java.sql.Timestamp;

public class AdviceAction extends BaseAction{
	private Integer adviceId;
	private String title;
	private String content;
	private AdviceBiz adviceBiz;

	public void setTitle(String title) {
		this.title = title;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setAdviceBiz(AdviceBiz adviceBiz) {
		this.adviceBiz = adviceBiz;
	}

	public Integer getAdviceId() {return adviceId;}

	public void setAdviceId(Integer adviceId) {this.adviceId = adviceId;}

	@Override
	public String execute() throws Exception {
		if (title != null && content != null){
			Advice advice = new Advice();
			advice.setTitle(title);
			advice.setContent(content);
			advice.setAdviceDate(new Timestamp(System.currentTimeMillis()));
			User user = new User();
			user.setId((Integer)getSession().get("userId"));
			advice.setUser(user);
			adviceBiz.publish(advice);
			return SUCCESS;
		}
		return ERROR;
	}
	//删除反馈
	public String delete(){
		if (adviceId >0 && getSession().get("adminname") !=null){
			adviceBiz.delete(adviceId);
			return SUCCESS;
		}
		return ERROR;
	}

}
