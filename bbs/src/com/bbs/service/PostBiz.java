package com.bbs.service;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import com.bbs.dao.PostDao;
import com.bbs.model.Followcard;
import com.bbs.model.Post;

public interface PostBiz {

    public abstract void setPostDao(PostDao postDao);

    /**
     * 向帖子表中增加一条记录
     *
     * @param post 帖子
     */
    public abstract void pushlish(Post post) throws IOException;

    /**
     * 获取指定帖子的回复贴
     *
     * @param postId 帖子id
     * @return 回复贴列表
     */
    public abstract List<Followcard> getFollowCards(int postId, int pageIndex, int pageSize);

    /**
     * 获取论坛精华帖
     *
     * @return
     */
    public abstract List<Post> getBestPosts(int pageIndex, int pageSize);

    /**
     * 分页查找最新发表的帖子
     *
     * @param pageIndex 页码，从1开始
     * @param pageSize  页面大小
     * @return
     */
    public abstract List<Post> getLatestPosts(int pageIndex, int pageSize);

    /**
     * 分页查找最新发表的异常帖子
     *
     * @param pageIndex 页码，从1开始
     * @param pageSize  页面大小
     * @return
     */
    public abstract List<Post> getLatestPosts2(int pageIndex, int pageSize);

    public Post getPostById(int postId);

    /**
     * 获取上一篇
     */
    public Post getUpPostById(int postId);

    /**
     * 获取下一篇
     */
    public Post getNextPostById(int postId);

    public List<Post> searchPosts(String keyword);

    public List<Post> getPostByType(int type, int pageIndex, int pageSize);

    public List<Post> getPostByUserId(int userId, int pageIndex, int pageSize);

    public void autoIncreaseReply(int postId);

    public void delIncreaseReply(int postId);

    public void delete(int postId);

    public abstract void updateType(Integer postId);

    //审核帖子通过
    public abstract void updatePass(Integer postId);

    //驳回帖子o
    public abstract void updateNoPass(Integer postId);

    public abstract void updatePost(int postId, String title, String content,
                                    int mainForum, int subForum);

    void autoIncreaseViewNum(int postId);

    List<Post> getHotPosts(int pageIndex, int pageSize);

    /**
     * 根据用户名获取用户的消息总数
     */
    public Object getNumByUsername(int username);

    /**
     * 根据帖子id写入点赞数
     */
    public void greatNum(Integer id, Integer greatNum);
}