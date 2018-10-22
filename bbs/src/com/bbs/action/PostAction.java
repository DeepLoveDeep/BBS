package com.bbs.action;

import com.bbs.model.BestPost;
import com.bbs.model.Post;
import com.bbs.model.User;
import com.bbs.service.BestPostBiz;
import com.bbs.service.PostBiz;
import com.bbs.service.UserBiz;
import com.opensymphony.xwork2.ActionContext;
import org.apache.commons.lang.StringUtils;

import java.util.Map;

public class PostAction extends BaseAction {
	private Integer postId;
	private int state;
	private int if_pass;
	private int if_delete;
	private String username;
	private PostBiz postBiz;
	private BestPostBiz bestPostBiz;
	private UserBiz userBiz;
	private String count;
	private Integer greatNum;

	public Integer getGreatNum() {
		return greatNum;
	}
	public void setGreatNum(Integer greatNum) {
		this.greatNum = greatNum;
	}

	public String getCount() {
		return count;
	}

	public UserBiz getUserBiz() {
		return userBiz;
	}

	public void setUserBiz(UserBiz userBiz) {
		this.userBiz = userBiz;
	}

	public Integer getIf_pass() {
		return if_pass;
	}

	public void setIf_pass(Integer if_pass) {
		this.if_pass = if_pass;
	}

	public void setState(int state) {
		this.state = state;
	}


	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return username;
	}

	public void setBestPostBiz(BestPostBiz bestPostBiz) {
		this.bestPostBiz = bestPostBiz;
	}


	public Integer getPostId() {
		return postId;
	}


	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public void setPostBiz(PostBiz postBiz) {
		this.postBiz = postBiz;
	}


	@Override
	public String execute() throws Exception {
		if (postId != null && if_pass == 1 && if_delete == 1) {
			System.out.println("id" + postId);
			Post post = postBiz.getPostById(postId);
			if (post == null)
				return ERROR;
			getRequest().put("post", post);
			return SUCCESS;
		}
		return ERROR;
	}
	/**
	 * 管理员审核帖子通过
	 */

	public String auditPost() {
		if (postId > 0 && getSession().get("adminname") != null) {
			postBiz.updatePass(postId);
			return SUCCESS;
		}
		return ERROR;
	}

	/**
	 * 管理员审核帖子驳回
	 */

	public String auditNoPost() {
		if (postId > 0 && getSession().get("adminname") != null) {
			postBiz.updateNoPass(postId);
			return SUCCESS;
		}
		return ERROR;
	}

	/**
	 * 申请精华帖
	 *
	 * @return
	 */
	public String applyBestPost() {
		if (postId > 0 && getSession().get("username") != null) {
			BestPost bestPost = new BestPost();
			Post post = new Post();
			post.setId(postId);
			bestPost.setPost(post);
			User user = new User();
			user.setId((Integer) getSession().get("userId"));
			bestPost.setUser(user);
			bestPost.setState(1);//1表示请求正在等待处理
			bestPostBiz.insert(bestPost);

		}
		return SUCCESS;
	}


	/**
	 * 管理员回复精华帖
	 */

	public String replyapply() {
		if (postId > 0 && getSession().get("adminname") != null) {

			bestPostBiz.updateState(postId, state);
			if (state == 2)//同意
				postBiz.updateType(postId);
			return SUCCESS;
		}
		return ERROR;

	}


	/**
	 * 删除帖子
	 */
	public String delete() {
		if ((postId > 0 && getSession().get("adminname") != null) || (postId > 0 && getSession().get("username") != null)) {
			postBiz.delete(postId);
			return SUCCESS;
		}
		return ERROR;
	}
	/**
	 * 编辑申请
	 */

	public String editPost() {
		if (postId > 0) {
			Post post = postBiz.getPostById(postId);
			getRequest().put("post", post);
			return SUCCESS;
		}
		return ERROR;
	}

	/**
	 * 获取我的消息的数量
	 */
	public String getNum() {
		if (getSession().get("username") != null) {
			//根据用户名获取用户id
			int userid = userBiz.getUserIdByUsername(username);
			//根据用户id获取消息总数
			String num = postBiz.getNumByUsername(userid).toString();
			ActionContext.getContext().put("num", num);
			return SUCCESS;
		}
		return ERROR;
	}

	/**
	 * 点赞功能实现
	 */
	public String greatNum() {
		try {
			//根据帖子id将点赞数存入
			postBiz.greatNum(postId,greatNum);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
}
