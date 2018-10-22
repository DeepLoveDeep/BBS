package com.bbs.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Post entity. @author MyEclipse Persistence Tools
 */

public class Post implements java.io.Serializable {

    // Fields
    private Integer id;
    private User user;
    private SubForum subForum;
    private String title;
    private String cardContent;
    private Timestamp sendDate;
    private Integer postType;
    private Integer replyNum;
    private Integer viewNum;
    private String photo_url;
    private int if_pass;
    private int if_delete;
    private Set bestPosts = new HashSet(0);
    private Set followcards = new HashSet(0);
    private Integer greatNum;
    // Constructors

    /**
     * default constructor
     */
    public Post() {
    }

    /**
     * minimal constructor
     */
    public Post(User user, SubForum subForum, String title, String cardContent,
                Timestamp sendDate) {
        this.user = user;
        this.subForum = subForum;
        this.title = title;
        this.cardContent = cardContent;
        this.sendDate = sendDate;
    }

    /**
     * full constructor
     */
    public Post(User user, SubForum subForum, String title, String cardContent,
                Timestamp sendDate, Integer postType, Integer replyNum,
                Integer viewNum, String photo_url, Integer if_pass,Integer if_delete, Set bestPosts, Set followcards,Integer greatNum) {
        this.user = user;
        this.subForum = subForum;
        this.title = title;
        this.cardContent = cardContent;
        this.sendDate = sendDate;
        this.postType = postType;
        this.replyNum = replyNum;
        this.viewNum = viewNum;
        this.photo_url = photo_url;
        this.if_pass = if_pass;
        this.if_delete = if_delete;
        this.bestPosts = bestPosts;
        this.followcards = followcards;
        this.greatNum = greatNum;
    }

    // Property accessors

    public Integer getGreatNum() {
        return greatNum;
    }

    public void setGreatNum(Integer greatNum) {
        this.greatNum = greatNum;
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

    public SubForum getSubForum() {
        return this.subForum;
    }

    public void setSubForum(SubForum subForum) {
        this.subForum = subForum;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCardContent() {
        return this.cardContent;
    }

    public void setCardContent(String cardContent) {
        this.cardContent = cardContent;
    }

    public Timestamp getSendDate() {
        return this.sendDate;
    }

    public void setSendDate(Timestamp sendDate) {
        this.sendDate = sendDate;
    }

    public Integer getPostType() {
        return this.postType;
    }

    public void setPostType(Integer postType) {
        this.postType = postType;
    }

    public Integer getReplyNum() {
        return this.replyNum;
    }

    public void setReplyNum(Integer replyNum) {
        this.replyNum = replyNum;
    }

    public Integer getViewNum() {
        return this.viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public String getPhoto_url() {
        return this.photo_url;
    }

    public void setPhoto_url(String photo_url) {
        this.photo_url = photo_url;
    }

    public Integer getIf_pass() {
        return this.if_pass;
    }

    public void setIf_pass(Integer if_pass) {
        this.if_pass = if_pass;
    }

    public Integer getIf_delete() {
        return this.if_delete;
    }

    public void setIf_delete(Integer if_delete) {
        this.if_delete = if_delete;
    }

    public Set getBestPosts() {
        return this.bestPosts;
    }

    public void setBestPosts(Set bestPosts) {
        this.bestPosts = bestPosts;
    }

    public Set getFollowcards() {
        return this.followcards;
    }

    public void setFollowcards(Set followcards) {
        this.followcards = followcards;
    }

    public String getTime() {
        String time = getSendDate().toString();
        int index = time.indexOf('.');
        if (index != -1)
            return time.substring(0, index);
        else return time;
    }

}