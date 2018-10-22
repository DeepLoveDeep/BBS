package com.bbs.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Followcard entity. @author MyEclipse Persistence Tools
 */

public class NoticeFollowcard implements java.io.Serializable {

	// Fields

	private Integer id;
	private User user;
	private Notice notice;
	private String content;
	private Timestamp date;
	private Integer if_delete;
    private Integer great_num;

	/** default constructor */
	public NoticeFollowcard() {
	}

	/** minimal constructor */
	public NoticeFollowcard(User user, Notice notice, Timestamp date) {
		this.user = user;
		this.notice = notice;
		this.date = date;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Notice getNotice() {
		return notice;
	}

	public void setNotice(Notice notice) {
		this.notice = notice;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public Integer getIf_delete() {
		return if_delete;
	}

	public void setIf_delete(Integer if_delete) {
		this.if_delete = if_delete;
	}

	public Integer getGreat_num() {
		return great_num;
	}

	public void setGreat_num(Integer great_num) {
		this.great_num = great_num;
	}

	public String getTime(){
		String time = getDate().toString();
		int index = time.lastIndexOf('.');
		if (index != -1)
		return time.substring(0,index);
		else 
			return time.toString();
	}

}