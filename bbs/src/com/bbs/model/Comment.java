package com.bbs.model;


import java.sql.Timestamp;

/**
 * Created by Administrator on 2018/9/26 0026.
 */
public class Comment implements java.io.Serializable {
    // Fields
    private Integer id;
    private String content;
    private Timestamp date;
    private Integer if_delete;
    private User user;
    private Followcard followcard;
    private Integer great_num;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGreat_num() {
        return great_num;
    }

    public void setGreat_num(Integer great_num) {
        this.great_num = great_num;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Followcard getFollowcard() {
        return followcard;
    }

    public void setFollowcard(Followcard followcard) {
        this.followcard = followcard;
    }

    public Comment() {
    }

    public Comment( User user,Followcard followcard,Integer id, String content, Timestamp date, Integer if_delete,Integer great_num) {
        this.id = id;
        this.user = user;
        this.followcard = followcard;
        this.content = content;
        this.date = date;
        this.if_delete = if_delete;
    }
}
