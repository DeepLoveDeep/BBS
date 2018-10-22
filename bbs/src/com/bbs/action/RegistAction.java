package com.bbs.action;


import java.net.InetAddress;
import java.rmi.ServerException;
import java.sql.Timestamp;

import com.aliyun.oss.ClientException;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dm.model.v20151123.SingleSendMailRequest;
import com.aliyuncs.dm.model.v20151123.SingleSendMailResponse;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.bbs.constants.Constant;
import com.bbs.model.User;
import com.bbs.service.UserBiz;
import com.bbs.utils.MailUtil;
import com.bbs.utils.Utils;

/**
 * @author Shen
 * @version 1.0
 * 2018年6月16日下午3:08:03
 */
public class RegistAction extends BaseAction {
	private String username;
	private String password;
	private String email;
	private UserBiz userBiz;
	
	
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	public void setUserBiz(UserBiz userBiz) {
		this.userBiz = userBiz;
	}
	
	/* (non-Javadoc)
	 * @see com.opensymphony.xwork2.ActionSupport#execute()
	 */
	@Override
	public String execute() throws Exception {
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		switch (userBiz.isExist(user)) {
		case 1:
			addFieldError("username", "该用户名已被注册");
			getRequest().put("username", username);
			getRequest().put("password", password);
			getRequest().put("email", email);
			return "regist";
		case 2:
			addFieldError("email","该邮箱已被注册");
			getRequest().put("username", username);
			getRequest().put("password", password);
			getRequest().put("email", email);
			return "regist";
		default:
			break;
		}		
		String code = Utils.createUUID();
		user.setActiveCode(code);
		user.setLevel(1);
		user.setType(1);
		user.setSex("男");
		user.setRegisterDate(new Timestamp(System.currentTimeMillis()));
		user.setHasActive(0);
		user.setPhotoUrl("/upload/default/head_icon.jpg");//默认头像
		userBiz.regist(user);
		// 如果是除杭州region外的其它region（如新加坡、澳洲Region），需要将下面的"cn-hangzhou"替换为"ap-southeast-1"、或"ap-southeast-2"。
		IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAITBoOMYwOuyzA", "Rpq5EGBfSBIySSP3c8E04EvrCkob7n");
		// 如果是除杭州region外的其它region（如新加坡region）， 需要做如下处理
		//try {
		//DefaultProfile.addEndpoint("dm.ap-southeast-1.aliyuncs.com", "ap-southeast-1", "Dm",  "dm.ap-southeast-1.aliyuncs.com");
		//} catch (ClientException e) {
		//e.printStackTrace();
		//}
		IAcsClient client = new DefaultAcsClient(profile);
		SingleSendMailRequest request = new SingleSendMailRequest();
		try {
			//request.setVersion("2017-06-22");// 如果是除杭州region外的其它region（如新加坡region）,必须指定为2017-06-22
			request.setAccountName("xne@xneio.com");
			request.setFromAlias("杭州世数网络科技");
			request.setAddressType(1);
			request.setTagName("bbs");
			request.setReplyToAddress(true);
			request.setToAddress(email);
			//可以给多个收件人发送邮件，收件人之间用逗号分开，批量发信建议使用BatchSendMailRequest方式
			//request.setToAddress("邮箱1,邮箱2");
			request.setSubject("用户注册激活码");
			String info = "欢迎注册我们的技术论坛，点击下方链接激活您的账户<br/><br/>";
			//获取服务器地址
			String warning = "<br/><br/>本邮件为系统邮件，请勿回复";
			InetAddress addr = InetAddress.getLocalHost();
			String ip=addr.getHostAddress().toString(); //获取本机ip
			request.setHtmlBody(info+"http://"+ip+":"+Constant.PORT+"/"+Constant.PROJECT_NAME+"/active.action?code="+code+warning);
			SingleSendMailResponse httpResponse = client.getAcsResponse(request);
		}catch (ClientException e) {
				e.printStackTrace();
			}
		//注册完成后跳转至中转页面，等待用户邮箱验证
		return "skip";
	}
	
	
	
	
	

	

}
