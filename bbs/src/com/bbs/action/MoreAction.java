package com.bbs.action;

import java.util.List;

import com.bbs.daoImpl.BestPostDaoImpl;
import com.bbs.model.Notice;
import com.bbs.model.Post;
import com.bbs.service.MainForumBiz;
import com.bbs.service.NoticeBiz;
import com.bbs.service.PostBiz;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MoreAction extends BaseAction {
	private static final Logger log = LoggerFactory
			.getLogger(MoreAction.class);

	private int type = 1;//1,2,3.4.5.6.7.
	private int page;
	private PostBiz postBiz;
	private NoticeBiz noticeBiz;
	private MainForumBiz mainForumBiz;


	
	
	

	public void setMainForumBiz(MainForumBiz mainForumBiz) {
		this.mainForumBiz = mainForumBiz;
	}

	public MainForumBiz getMainForumBiz() {
		return mainForumBiz;
	}

	public void setType(int type) {
		this.type = type;
	}

	public void setPage(int page) {
		this.page = page;
	}


	public void setPostBiz(PostBiz postBiz) {
		this.postBiz = postBiz;
	}

	public void setNoticeBiz(NoticeBiz noticeBiz) {
		this.noticeBiz = noticeBiz;
	}
	@Override
	public String execute() throws Exception {
		String typename = null;
		switch (type) {
		case -1:
			typename = "论坛新帖";
			break;
		case -2:
			typename = "精华帖";
			break;
		case -3:
			typename = "论坛热帖";
			break;
		case -4:
			typename = "论坛公告";
			break;
		default:
			if(mainForumBiz!=null && mainForumBiz.getMainForumById(type)!=null){
				typename = mainForumBiz.getMainForumById(type).getTitle();
			}
			break;
		}
		if (type>-4&&type<1&&page>0){
			List<Post>posts = postBiz.getPostByType(type, page, 1000);
//			for (Post post:posts){
//				SysMessage.out.println("差找到"+post.getTitle());
//			}
			getRequest().put("posts", posts);
			getRequest().put("page", page);
			getRequest().put("type", type);
			getRequest().put("typename", typename);
			return "success3";
		}
		if (type>0&&page>0){
			List<Post>posts = postBiz.getPostByType(type, page, 10);
			getRequest().put("posts", posts);
			getRequest().put("page", page);
			getRequest().put("type", type);
			getRequest().put("typename", typename);
			return "success2";
		}
		if (type==-4&&page>0){
			List<Notice>notices = noticeBiz.getNoticeByType(type, page, 1000);
			getRequest().put("notices", notices);
			getRequest().put("page", page);
			getRequest().put("type", type);
			getRequest().put("typename", typename);
			return "success1";
		}

		return ERROR;
	}
	

}
