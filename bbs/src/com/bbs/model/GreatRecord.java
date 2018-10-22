package com.bbs.model;

import java.sql.Timestamp;

/**点赞记录实体类
 * Created by ACER NO1 on 2018/10/18.
 */
public class GreatRecord implements java.io.Serializable{

    private Integer id;
    //点赞用户id
    private Integer userId;
    //评论id
    private Integer followId;
    //创建时间
    private Timestamp createTime;
    //修改时间
    private Timestamp updateTime;
    //点赞状态 1 已点赞 0未点赞
    private Integer status;

    public GreatRecord() {
    }

    public GreatRecord(Integer id, Integer userId, Integer followId, Timestamp createTime, Timestamp updateTime, Integer status) {
        this.id = id;
        this.userId = userId;
        this.followId = followId;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.status = status;
    }

    public GreatRecord(Integer userId, Integer followId) {
        this.userId = userId;
        this.followId = followId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getFollowId() {
        return followId;
    }

    public void setFollowId(Integer followId) {
        this.followId = followId;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
