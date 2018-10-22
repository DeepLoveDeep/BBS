/**
 *
 */
package com.bbs.dao;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import com.bbs.model.Followcard;
import com.bbs.model.Post;

/**
 * 帖子的数据库访问接口
 *
 * @author Shen
 * @version 1.0
 *          2018年6月16日下午1:32:23
 */
public interface PostDao {

    /**
     * 向帖子表中增加一条记录
     *
     * @param post 帖子
     */
    public void pushlish(Post post) throws IOException;

    /**
     * 获取指定帖子的回复贴
     * @param postId 帖子id
     * @return 回复贴列表
     */
//	public Set<Followcard> getFollowCards(int postId);

    /**
     * 获取论坛精华帖
     *
     * @return
     */
    public List<Post> getBestPosts(int pageIndex, int pageSize);

    /**
     * 分页查找最新发表的帖子
     *
     * @param pageIndex 页码，从1开始
     * @param pageSize  页面大小
     * @return
     */
    public List<Post> getLatestPosts(int pageIndex, int pageSize);

    /**
     * 获取异常帖
     */
    public List<Post> getLatestPosts2(int pageIndex, int pageSize);

    public Post getPostById(int postId);

    /**
     * 获取上一篇
     */
    public Post getUpPostById(int postId);

    /**
     * 获取下一篇
     */
    public Post getNextPostById(int postId);

    /**
     * 获取指定帖子的回复贴
     *
     * @param postId 帖子id,页数，页面大小
     * @return 回复贴列表
     */
    List<Followcard> getFollowCards(int postId, int pageIndex, int pageSize);

    public List<Post> search(String keyword);

    public List<Post> getPostByType(int type, int pageIndex, int pageSize);

    public List<Post> getPostByUserId(int userId, int pageIndex, int pageSize);

    public void autoIncreaseReply(int postId);

    public void delIncreaseReply(int postId);

    public void delete(int postId);

    public void updateType(Integer postId);

    //帖子审核通过
    public void updatePass(Integer postId);

    //帖子被驳回
    public void updateNoPass(Integer postId);

    public void updatePost(Post post);

    public void autoIncreaseViewNum(int postId);

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
