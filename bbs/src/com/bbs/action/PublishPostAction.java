package com.bbs.action;

import java.awt.*;
import java.io.*;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;

import com.bbs.model.MainForum;
import com.bbs.model.Post;
import com.bbs.model.SubForum;
import com.bbs.model.User;
import com.bbs.service.BlackListBiz;
import com.bbs.service.PostBiz;
import org.apache.struts2.ServletActionContext;
import sun.misc.BASE64Decoder;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

public class PublishPostAction extends BaseAction{
	private String title;
	private String content;
	private int mainForum;
	private int subForum;
	private int postId;
	private String photo_url;
	private PostBiz postBiz;
	private BlackListBiz blackListBiz;

	public String getPhoto_url() {
		return photo_url;
	}

	public void setPhoto_url(String photo_url) {
		this.photo_url = photo_url;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public void setBlackListBiz(BlackListBiz blackListBiz) {
		this.blackListBiz = blackListBiz;
	}

	public void setPostBiz(PostBiz postBiz) {
		this.postBiz = postBiz;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setContent(String content) {
		this.content = content;
	}

	public void setMainForum(int mainForum) {
		this.mainForum = mainForum;
	}

	public void setSubForum(int subForum) {
		this.subForum = subForum;
	}

	@Override
	public String execute() throws Exception {

		int userId = (Integer) getSession().get("userId");
		int level = blackListBiz.getLevel(userId);
		if (level<=3&&level>0){
			this.addFieldError("limit", "您已被管理员限制发帖");
			return "publish";
		}
		Post post = new Post();
		if(photo_url!=null&&!"".equals(photo_url)){
			BASE64Decoder decoder = new BASE64Decoder();
			//Base64解码
			byte[] b = decoder.decodeBuffer(photo_url.replace("data:image/jpeg;base64,", ""));
			//idPhotoUrl = idPhotoUrl.replace("data:image/jpeg;base64,", "");
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {//调整异常数据
					b[i] += 256;
				}
			}
			//生成jpeg图片
			Properties prop = new Properties();
			InputStream ins = this.getClass().getResourceAsStream("/resource/properties.properties");
			prop.load(ins);
			String imgFilePath = prop.getProperty("PHOTOURL") + UUID.randomUUID() + ".jpg";//新生成的图片
			OutputStream out = new FileOutputStream(imgFilePath);
			out.write(b);
			out.flush();
			out.close();
			post.setPhoto_url(imgFilePath);
		}else {
			post.setPhoto_url(null);
		}
		post.setTitle(title);
		post.setCardContent(content);
		SubForum subFrom = new SubForum();
		subFrom.setId(subForum);
		MainForum main = new MainForum();
		main.setId(mainForum);
		subFrom.setMainForum(main);
		post.setSubForum(subFrom);
		User user  = new User();
		user.setId((Integer)getSession().get("userId"));
		post.setUser(user);
		post.setPostType(0);
		post.setReplyNum(0);
		post.setViewNum(0);
		post.setGreatNum(0);
		post.setIf_pass(1);
		post.setIf_delete(1);
		post.setSendDate(new Timestamp(System.currentTimeMillis()));
		postBiz.pushlish(post);
		return SUCCESS;
	}
	
	public String commitEditor(){
		if (postId>0){
			postBiz.updatePost(postId,title,content,mainForum,subForum);
			getRequest().put("postId", postId);
			getRequest().put("page", 1);
		}
		return SUCCESS;
	}

	public String toshowPic() {
		HttpServletResponse response =ServletActionContext.getResponse();
		File imgFile = new File(photo_url);
		FileInputStream fin = null;
		OutputStream output = null;
		try {
			output = response.getOutputStream();
			fin = new FileInputStream(imgFile);
			byte[] arr = new byte[1024 * 10];
			int n;
			while ((n = fin.read(arr)) != -1) {
				output.write(arr, 0, n);
			}
			output.flush();
			output.close();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
}
