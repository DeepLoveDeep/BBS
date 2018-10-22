package com.bbs.serviceImpl;

import com.bbs.dao.CommentDao;
import com.bbs.model.Comment;
import com.bbs.service.CommentBiz;

import java.util.List;

/**
 * @author Shen
 * @version 1.0
 *          2018年6月16日下午1:32:23
 */
public class CommentBizImpl implements CommentBiz {

    private CommentDao commentDao;

    public void setCommentDao(CommentDao commentDao) {
        this.commentDao = commentDao;
    }

    @Override
    public void delete(Integer followId) {

    }

    /**
     *根据评论id查找回复信息
     * */
    @Override
    public List<Comment> findByFollowId(Integer followId) {
        return commentDao.findByUser_receive(followId);
    }

    @Override
    public void addReply(Comment comment) {
        commentDao.save(comment);
    }

    /**
     * 根据评论id写入点赞数
     */
    @Override
    public void greatNum(Integer id,Integer greatNum) {
        commentDao.greatNum(id,greatNum);
    }
}
