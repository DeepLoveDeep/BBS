package com.bbs.action;

import java.sql.Timestamp;

import com.bbs.model.Admin;
import com.bbs.model.Notice;
import com.bbs.service.NoticeBiz;

public class NoticeAction extends BaseAction{
	private Integer noticeId;
	private String title;
	private String content;
	private Integer greatNum;
	private Integer replayNum;
	private String photoUrl;
	private NoticeBiz noticeBiz;

	public void setTitle(String title) {
		this.title = title;
	}

	public void setGreatNum(Integer greatNum) {
		this.greatNum = greatNum;
	}
	public void setReplayNum(Integer replayNum) {
		this.replayNum = replayNum;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public void setNoticeId(Integer noticeId) {
		this.noticeId = noticeId;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setNoticeBiz(NoticeBiz noticeBiz) {
		this.noticeBiz = noticeBiz;
	}
	
	@Override
	public String execute() throws Exception {
		if (title != null && content != null){
			Notice notice = new Notice();
			notice.setTitle(title);
			notice.setContent(content);
			notice.setGreatNum(0);
			notice.setReplayNum(0);
			notice.setNoticeDate(new Timestamp(System.currentTimeMillis()));
			Admin admin = new Admin();
			admin.setId((Integer)getSession().get("adminid"));
			notice.setAdmin(admin);
			noticeBiz.publish(notice);
			this.addFieldError("notice_result","发表成功");
			return SUCCESS;
		}
		return ERROR;
	}
	/**
	 * 点赞功能实现
	 */
	public String greatNum() {
		try {
			//根据帖子id将点赞数存入
			noticeBiz.greatNum(noticeId,greatNum);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
