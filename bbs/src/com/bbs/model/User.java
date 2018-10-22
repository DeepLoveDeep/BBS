package com.bbs.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable {

    // Fields

    private Integer id;
    //用户名
    private String username;
    //密码
    private String password;
    //性别
    private String sex;
    //头像
    private String photoUrl;
    //邮箱
    private String email;
    //类型
    private Integer type;
    //注册时间
    private Timestamp registerDate;
    private String signature;
    //级别
    private Integer level;
    //激活码
    private String activeCode;
    //是否激活
    private Integer hasActive;
    //手机号
    private String phone;
    //精华帖
    private Set bestPosts = new HashSet(0);
    //论帖
    private Set posts = new HashSet(0);
    private Set blackLists = new HashSet(0);
    //评论
    private Set followcards = new HashSet(0);
    //评论回复
    private Set comments = new  HashSet(0);
    //系统消息
    private Set sysUsers = new  HashSet(0);
    // Constructors

    /**
     * default constructor
     */
    public User() {
    }

    /**
     * minimal constructor
     */
    public User(String username, String password, String email, Integer type,
                Timestamp registerDate, Integer level, String phone) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.type = type;
        this.registerDate = registerDate;
        this.level = level;
        this.phone = phone;
    }

    /**
     * full constructor
     */
    public User(String username, String password, String sex, String photoUrl,
                String email, Integer type, Timestamp registerDate,
                String signature, Integer level, String phone, String activeCode,
                Integer hasActive, Set bestPosts, Set posts, Set blackLists,Set sysUsers,
                Set followcards,Set comments) {
        this.username = username;
        this.password = password;
        this.sex = sex;
        this.photoUrl = photoUrl;
        this.email = email;
        this.type = type;
        this.registerDate = registerDate;
        this.signature = signature;
        this.level = level;
        this.phone = phone;
        this.activeCode = activeCode;
        this.hasActive = hasActive;
        this.bestPosts = bestPosts;
        this.posts = posts;
        this.blackLists = blackLists;
        this.followcards = followcards;
        this.comments = comments;
        this.sysUsers = sysUsers;
    }

    // Property accessors

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return this.sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhotoUrl() {
        return this.photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getType() {
        return this.type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Timestamp getRegisterDate() {
        return this.registerDate;
    }

    public void setRegisterDate(Timestamp registerDate) {
        this.registerDate = registerDate;
    }

    public String getSignature() {
        return this.signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public Integer getLevel() {
        return this.level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getPhone() { return this.phone;}

    public void setPhone(String phone) {this.phone = phone;}

    public String getActiveCode() {
        return this.activeCode;
    }

    public void setActiveCode(String activeCode) {
        this.activeCode = activeCode;
    }

    public Integer getHasActive() {
        return this.hasActive;
    }

    public void setHasActive(Integer hasActive) {
        this.hasActive = hasActive;
    }

    public Set getBestPosts() {
        return this.bestPosts;
    }

    public void setBestPosts(Set bestPosts) {
        this.bestPosts = bestPosts;
    }

    public Set getPosts() {
        return this.posts;
    }

    public void setPosts(Set posts) {
        this.posts = posts;
    }

    public Set getBlackLists() {
        return this.blackLists;
    }

    public void setBlackLists(Set blackLists) {
        this.blackLists = blackLists;
    }

    public Set getFollowcards() {
        return this.followcards;
    }

    public void setFollowcards(Set followcards) {
        this.followcards = followcards;
    }

    public Set getComments() {
        return comments;
    }

    public void setComments(Set comments) {
        this.comments = comments;
    }

    public Set getSysUsers() {
        return sysUsers;
    }

    public void setSysUsers(Set sysUsers) {
        this.sysUsers = sysUsers;
    }
}