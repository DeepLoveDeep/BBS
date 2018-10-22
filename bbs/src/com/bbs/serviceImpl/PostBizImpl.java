package com.bbs.serviceImpl;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.bbs.dao.MainForumDao;
import com.bbs.dao.PostDao;
import com.bbs.model.Followcard;
import com.bbs.model.MainForum;
import com.bbs.model.Post;
import com.bbs.model.SubForum;
import com.bbs.service.PostBiz;


/**
 * @author Shen
 * @version 1.0
 *          2018年6月23日上午11:32:57
 */
public class PostBizImpl implements PostBiz {
    private PostDao postDao;

    /* (non-Javadoc)
     * @see com.bbs.bizImpl.PostBiz#setPostDao(com.bbs.dao.PostDao)
     */
    @Override
    public void setPostDao(PostDao postDao) {
        this.postDao = postDao;
    }

    /* (non-Javadoc)
     * @see com.bbs.bizImpl.PostBiz#pushlish(com.bbs.model.Post)
     */
    @Override
    public void pushlish(Post post)throws IOException {
        postDao.pushlish(post);
    }


    /* (non-Javadoc)
     * @see com.bbs.bizImpl.PostBiz#getBestPosts(int, int)
     */
    @Override
    public List<Post> getBestPosts(int pageIndex, int pageSize) {
        return postDao.getBestPosts(pageIndex, pageSize);
    }

    /* (non-Javadoc)
     * @see com.bbs.bizImpl.PostBiz#getLatestPosts(int, int)
     */
    @Override
    public List<Post> getLatestPosts(int pageIndex, int pageSize) {
        return postDao.getLatestPosts(pageIndex, pageSize);
    }

    /*
    * 获取异常帖
    * */
    @Override
    public List<Post> getLatestPosts2(int pageIndex, int pageSize) {
        return postDao.getLatestPosts2(pageIndex, pageSize);
    }

    public Post getPostById(int postId) {
        return postDao.getPostById(postId);
    }

    @Override
    public Post getUpPostById(int postId) {
        return postDao.getUpPostById(postId);
    }

    @Override
    public Post getNextPostById(int postId) {
        return postDao.getNextPostById(postId);
    }

    @Override
    public List<Followcard> getFollowCards(int postId, int pageIndex,
                                           int pageSize) {
        return postDao.getFollowCards(postId, pageIndex, pageSize);
    }

    public List<Post> searchPosts(String keyword) {
        return postDao.search(keyword);

    }

    public List<Post> getPostByType(int type, int pageIndex, int pageSize) {
        return postDao.getPostByType(type, pageIndex, pageSize);
    }

    @Override
    public List<Post> getPostByUserId(int userId, int pageIndex, int pageSize) {
        return postDao.getPostByUserId(userId, pageIndex, pageSize);
    }

    @Override
    public void autoIncreaseReply(int postId) {
        postDao.autoIncreaseReply(postId);

    }
    @Override
    public void delIncreaseReply(int postId) {
        postDao.delIncreaseReply(postId);

    }

    @Override
    public void delete(int postId) {
        postDao.delete(postId);

    }

    @Override
    public void updateType(Integer postId) {
        postDao.updateType(postId);

    }

    //审核帖子通过
    @Override
    public void updatePass(Integer postId) {
        postDao.updatePass(postId);
    }

    //帖子被驳回
    @Override
    public void updateNoPass(Integer postId) {
        postDao.updateNoPass(postId);
    }

    @Override
    public void updatePost(int postId, String title, String content,
                           int mainForum, int subForum) {

        Post post = postDao.getPostById(postId);
        post.setTitle(title);
        post.setCardContent(content);
        post.setSendDate(new Timestamp(System.currentTimeMillis()));
        MainForum mainForum2 = new MainForum();
        mainForum2.setId(mainForum);
        SubForum sub = new SubForum();
        sub.setMainForum(mainForum2);
        sub.setId(subForum);
        post.setSubForum(sub);
        postDao.updatePost(post);


    }

    @Override
    public void autoIncreaseViewNum(int postId) {
        postDao.autoIncreaseViewNum(postId);
    }

    @Override
    public List<Post> getHotPosts(int pageIndex, int pageSize) {
        return postDao.getHotPosts(pageIndex, pageSize);
    }

    /**
    * 根据用户名获取用户的消息总数
    * */
    @Override
    public Object getNumByUsername(int userid) {
        return postDao.getNumByUsername(userid);
    }
    /**
     * 根据帖子id写入点赞数
     */
    @Override
    public void greatNum(Integer id,Integer greatNum) {
        postDao.greatNum(id,greatNum);
    }
}
