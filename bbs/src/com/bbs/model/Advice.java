package com.bbs.model;

import java.sql.Timestamp;

/**
 * Notice entity. @author MyEclipse Persistence Tools
 */

public class Advice implements java.io.Serializable {

	// Fields

	private Integer id;
	private User user;
	private String content;
	private Timestamp adviceDate;
	private String title;

	// Constructors

	/** default constructor */
	public Advice() {
	}

	/** minimal constructor */
	public Advice(User user, Timestamp adviceDate) {
		this.user = user;
		this.adviceDate = adviceDate;
	}

	/** full constructor */
	public Advice(User user, Timestamp adviceDate, String content,
				  String title) {
		this.user = user;
		this.content = content;
		this.adviceDate = adviceDate;
		this.title = title;
	}

	// Property accessors

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

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getAdviceDate() {
		return this.adviceDate;
	}

	public void setAdviceDate(Timestamp adviceDate) {
		this.adviceDate = adviceDate;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}