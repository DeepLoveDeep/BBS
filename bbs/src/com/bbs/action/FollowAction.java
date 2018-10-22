package com.bbs.action;

import com.bbs.model.*;
import com.bbs.service.BlackListBiz;
import com.bbs.service.FollowcardBiz;
import com.bbs.service.NoticeFollowcardBiz;

import java.sql.Timestamp;

public class FollowAction extends BaseAction {
    private int noticeId;
    private Integer great_num;
    private String content;
    private Integer postid;
    private  String ids;
    private BlackListBiz blackListBiz;
    private FollowcardBiz followcardBiz;
    private NoticeFollowcardBiz noticeFollowcardBiz;

    public void setNoticeFollowcardBiz(NoticeFollowcardBiz noticeFollowcardBiz) {
        this.noticeFollowcardBiz = noticeFollowcardBiz;
    }

    public void setGreat_num(Integer great_num) {
        this.great_num = great_num;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
    }

    public void setBlackListBiz(BlackListBiz blackListBiz) {
        this.blackListBiz = blackListBiz;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public void setPostid(Integer postid) {
        this.postid = postid;
    }

    public void setFollowcardBiz(FollowcardBiz followcardBiz) {
        this.followcardBiz = followcardBiz;
    }

    @Override
    public String execute() throws Exception {
        if (content != null) {
            int userId = (Integer) getSession().get("userId");
            int level = blackListBiz.getLevel(userId);
            if (level == 4 || level == 2 || level == 1) {
                this.addFieldError("limit", "你已被管理员限制发表回复");
                return "notice";
            }
            NoticeFollowcard followcard = new NoticeFollowcard();
            followcard.setContent(content);
            Notice notice = new Notice();
            notice.setId(noticeId);
            followcard.setNotice(notice);
            followcard.setGreat_num(0);
            followcard.setDate(new Timestamp(System.currentTimeMillis()));
            User user = new User();
            user.setId(userId);
            user.setUsername((String) getSession().get("username"));
            followcard.setUser(user);
            followcard.setIf_delete(1);
            noticeFollowcardBiz.addFollow(followcard);
            getRequest().put("noticeId", noticeId);
            return SUCCESS;
        }
        return ERROR;
    }

    /**
     * 删除评论
     */
/*    public String delete() throws Exception {
        if ((followId > 0 && getSession().get("username") != null)) {
            followcardBiz.delete(followId);
            postBiz.delIncreaseReply(postId);
            return SUCCESS;
        }
        return ERROR;
    }*/

    /**
     * 评论点赞
     */
    public String greatNum() {
        try {
            //根据帖子id将点赞数存入
            noticeFollowcardBiz.greatNum(noticeId, great_num);
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
 /*   *//**
     * 回复点赞
     *//*
    public String greatNum2() {
        try {
            //根据帖子id将点赞数存入
            commentBiz.greatNum(commentId, great_num);
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    *//**
     * 评论回复
     *//*
    public String reply2() {
        if (content != null) {
            int userId = (Integer) getSession().get("userId");
            int level = blackListBiz.getLevel(userId);
            if (level == 4 || level == 2 || level == 1) {
                this.addFieldError("limit", "你已被管理员限制发表回复");
                return "post";
            }
            Comment comment = new Comment();
            comment.setContent(content);
            comment.setGreat_num(0);
            comment.setDate(new Timestamp(System.currentTimeMillis()));
            Followcard followcard =new Followcard();
            followcard.setId(user_receive);
            comment.setFollowcard(followcard);
            User user = new User();
            user.setId(user_send);
            user.setUsername((String) getSession().get("username"));
            comment.setUser(user);
            comment.setIf_delete(1);
            commentBiz.addReply(comment);
            getRequest().put("postId", postId);
            getRequest().put("user_receive", user_receive);
            getRequest().put("page", pageNum);
            return SUCCESS;
        }
        return ERROR;
    }*/
    /**
     * 全部已读
     * */
    public String readAllBySendId() {
        try {
            //分割字符串
            String[] splits = ids.split(",");
            //遍历字符数组
            for(String id:splits){
                //强转成int类型
                int send_id = Integer.parseInt(id);
                //修改评论是否已读状态
                followcardBiz.readAllBySendId(send_id);
            }
            return SUCCESS;
        }catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    /**
     * 根据帖子id修改是否已读状态
     * */
    public  String readByPostId( ) {
        try {
            followcardBiz.readByPostId(postid);
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

}
