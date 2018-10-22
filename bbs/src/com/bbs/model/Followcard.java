package com.bbs.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Followcard entity. @author MyEclipse Persistence Tools
 */

public class Followcard implements java.io.Serializable {

	// Fields
    //主键id
	private Integer id;
	//评论用户信息
	private User user;
	//对应的帖子信息
	private Post post;
	//评论内容
	private String followContent;
	private Timestamp followDate;
	//是否删除
	private Integer if_delete;
    private Integer great_num;
    //是否已读
    private Integer if_read;
    //评论回复信息
	private Set comments = new HashSet(0);
	// Constructors

	/** default constructor */
	public Followcard() {
	}

	/** minimal constructor */
	public Followcard(User user, Post post, Timestamp followDate) {
		this.user = user;
		this.post = post;
		this.followDate = followDate;
	}

	/** full constructor */
	public Followcard(User user, Post post, String followContent,
			Timestamp followDate,Integer if_delete,Integer great_num,Integer if_read,Set comments) {
		this.user = user;
		this.post = post;
		this.followContent = followContent;
		this.followDate = followDate;
		this.great_num = great_num;
		this.if_delete = if_delete;
		this.if_read = if_read;
		this.comments = comments;
	}

	// Property accessors

	public Integer getIf_read() {
		return if_read;
	}

	public void setIf_read(Integer if_read) {
		this.if_read = if_read;
	}

	public Set getComments() {
		return comments;
	}

	public void setComments(Set comments) {
		this.comments = comments;
	}

	public Integer getGreat_num() {
		return great_num;
	}

	public void setGreat_num(Integer great_num) {
		this.great_num = great_num;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Post getPost() {
		return this.post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public String getFollowContent() {
		return this.followContent;
	}

	public void setFollowContent(String followContent) {
		this.followContent = followContent;
	}

	public Timestamp getFollowDate() {
		return this.followDate;
	}

	public Integer getIf_delete() {return if_delete;}

	public void setIf_delete(Integer if_delete) {this.if_delete = if_delete;}

	public void setFollowDate(Timestamp followDate) {
		this.followDate = followDate;
	}
	public String getTime(){
		String time = getFollowDate().toString();
		int index = time.lastIndexOf('.');
		if (index != -1)
		return time.substring(0,index);
		else 
			return time.toString();
	}

}