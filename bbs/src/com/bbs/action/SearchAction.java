package com.bbs.action;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import com.bbs.model.Post;
import com.bbs.service.PostBiz;

public class SearchAction extends BaseAction{
	private String keywords;
	private PostBiz postBiz;
	

	public void setPostBiz(PostBiz postBiz) {
		this.postBiz = postBiz;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	@Override
	public String execute() throws Exception {
		String encode = "iso8859-1";
		if(keywords.equals(new String(keywords.getBytes(encode), encode))){
			keywords = new String(keywords.getBytes(encode),"utf-8");
		}
		List<Post> posts = postBiz.searchPosts(keywords);
		getRequest().put("posts", posts);
		return SUCCESS;
	}

}
