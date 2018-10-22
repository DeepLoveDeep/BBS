package com.bbs.action;

import java.sql.Timestamp;

import com.bbs.model.*;
import com.bbs.service.*;

public class ReplyAction extends BaseAction {
    private int postId;
    private int pageNum;
    private Integer followId;
    private String username;
    private Integer addOrMinus;
    private Integer great_num;
    private Integer user_receive;
    private Integer user_send;
   private Integer commentId;
    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }


    private String content;
    private FollowcardBiz followcardBiz;
    private CommentBiz commentBiz;
    private PostBiz postBiz;
    private GreatRecordBiz greatRecordBiz;
    private BlackListBiz blackListBiz;

    public void setCommentBiz(CommentBiz commentBiz) {
        this.commentBiz = commentBiz;
    }

    public void setGreatRecordBiz(GreatRecordBiz greatRecordBiz) {
        this.greatRecordBiz = greatRecordBiz;
    }

    public void setAddOrMinus(Integer addOrMinus) {
        this.addOrMinus = addOrMinus;
    }

    public void setUser_receive(Integer user_receive) {
        this.user_receive = user_receive;
    }

    public void setUser_send(Integer user_send) {
        this.user_send = user_send;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public void setGreat_num(Integer great_num) {
        this.great_num = great_num;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getFollowId() {
        return followId;
    }

    public void setFollowId(Integer followId) {
        this.followId = followId;
    }

    public void setBlackListBiz(BlackListBiz blackListBiz) {
        this.blackListBiz = blackListBiz;
    }

    public void setPostBiz(PostBiz postBiz) {
        this.postBiz = postBiz;
    }

    public int getPostId() {
        return postId;
    }

    public void setFollowcardBiz(FollowcardBiz followcardBiz) {
        this.followcardBiz = followcardBiz;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    //	public void setUserId(int userId) {
//		this.userId = userId;
//	}
    public void setContent(String content) {
        this.content = content;
    }


    @Override
    public String execute() throws Exception {
        if (content != null) {
            int userId = (Integer) getSession().get("userId");
            int level = blackListBiz.getLevel(userId);
            if (level == 4 || level == 2 || level == 1) {
                this.addFieldError("limit", "你已被管理员限制发表回复");
                return "post";
            }
            Followcard followcard = new Followcard();
            followcard.setFollowContent(content);
            Post post = new Post();
            post.setId(postId);
            followcard.setPost(post);
            followcard.setGreat_num(0);
            followcard.setFollowDate(new Timestamp(System.currentTimeMillis()));
            User user = new User();
            user.setId(userId);
            user.setUsername((String) getSession().get("username"));
            followcard.setUser(user);
            followcard.setIf_delete(1);
            followcard.setIf_read(0);
            followcardBiz.addReply(followcard);
            postBiz.autoIncreaseReply(postId);
            getRequest().put("postId", postId);
            getRequest().put("page", pageNum);
            return SUCCESS;
        }
        return ERROR;
    }

    /**
     * 删除评论
     */
    public String delete() throws Exception {
        if ((followId > 0 && getSession().get("username") != null)) {
            followcardBiz.delete(followId);
            postBiz.delIncreaseReply(postId);
            return SUCCESS;
        }
        return ERROR;
    }

    /**
     * 评论点赞
     */
    public String greatNum() {
        try {
            //根据帖子id将点赞数存入
            int userId = (Integer) getSession().get("userId");
            GreatRecord greadRecord=new GreatRecord();
            greadRecord.setUserId(userId);
            greadRecord.setFollowId(followId);
            followcardBiz.greatNum(followId, great_num);
            GreatRecord isGreat=greatRecordBiz.queryIsGreatByUserId(greadRecord);
            GreatRecord addGreadRecord=new GreatRecord();
            addGreadRecord.setFollowId(followId);
            addGreadRecord.setUserId(userId);
            if(isGreat==null&&addOrMinus==1){//点赞则增加点赞记录
                addGreadRecord.setStatus(1);
                addGreadRecord.setCreateTime(new Timestamp(System.currentTimeMillis()));
                addGreadRecord.setUpdateTime(new Timestamp(System.currentTimeMillis()));
                greatRecordBiz.save(addGreadRecord);
            }else {//取消点赞则删除点赞记录
                greatRecordBiz.delete(addGreadRecord);
            }
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    /**
     * 回复点赞
     */
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

    /**
     * 评论回复
     */
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
    }
}
