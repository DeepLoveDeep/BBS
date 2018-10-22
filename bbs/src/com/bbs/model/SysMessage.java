package com.bbs.model;


import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Administrator on 2018/9/26 0026.
 */
public class SysMessage implements java.io.Serializable {
    // Fields
    //主键
    private Integer id;
    //内容
    private String content;
    //日期
    private Timestamp date;
    //是否删除
    private Integer if_delete;
    //系统信息
    private Set sysUsers = new HashSet(0);
    public SysMessage() {
    }

    public SysMessage(Integer id, String content, Timestamp date, Integer if_delete,Set sysUsers) {
        this.id = id;
        this.content = content;
        this.date = date;
        this.if_delete = if_delete;
        this.sysUsers = sysUsers;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Set getSysUsers() {
        return sysUsers;
    }

    public void setSysUsers(Set sysUsers) {
        this.sysUsers = sysUsers;
    }
}
