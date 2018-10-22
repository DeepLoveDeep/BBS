package com.bbs.model;


/**
 * Created by Administrator on 2018/9/26 0026.系统消息实体
 */
public class SysUser implements java.io.Serializable {
    // Fields
    private Integer id;
    private Integer user_id;
    private Integer sys_id;
    private Integer if_delete;
    private Integer if_read;
    private User user;
    private SysMessage sysMessage;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getSys_id() {
        return sys_id;
    }

    public void setSys_id(Integer sys_id) {
        this.sys_id = sys_id;
    }

    public Integer getIf_delete() {
        return if_delete;
    }

    public void setIf_delete(Integer if_delete) {
        this.if_delete = if_delete;
    }

    public Integer getIf_read() {
        return if_read;
    }

    public void setIf_read(Integer if_read) {
        this.if_read = if_read;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public SysMessage getSysMessage() {
        return sysMessage;
    }

    public void setSysMessage(SysMessage sysMessage) {
        this.sysMessage = sysMessage;
    }

    public SysUser() {
    }

    public SysUser(Integer id, Integer user_id, Integer sys_id, Integer if_delete, Integer if_read, User user, SysMessage sysMessage) {
        this.id = id;
        this.user_id = user_id;
        this.sys_id = sys_id;
        this.if_delete = if_delete;
        this.if_read = if_read;
        this.user = user;
        this.sysMessage = sysMessage;
    }
}
