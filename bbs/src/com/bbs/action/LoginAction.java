package com.bbs.action;

import com.bbs.model.User;
import com.bbs.service.BlackListBiz;
import com.bbs.service.UserBiz;

/**
 * @author Shen
 * @version 1.0
 * 2018年6月16日下午3:25:02
 */
public class LoginAction extends BaseAction {
	
	private String username;
	private String email;
	private String password;
	private UserBiz userBiz;

	private BlackListBiz blackListBiz;


	
	
	public void setBlackListBiz(BlackListBiz blackListBiz) {
		this.blackListBiz = blackListBiz;
	}






	/**
	 * 
	 */
	public LoginAction() {
		super();
		// TODO Auto-generated constructor stub
	}






	public void setUserBiz(UserBiz userBiz) {
		this.userBiz = userBiz;
	}


	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}






	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}






	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}






	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}






	/* (non-Javadoc)
	 * @see com.opensymphony.xwork2.ActionSupport#execute()
	 */
	@Override
	public String execute() throws Exception {
			int result = userBiz.login(username,password);
		    User user = userBiz.getUserById(result);
			if (result > 0){
				int level = blackListBiz.getLevel(result);
				if (level == 1){
					this.addFieldError("username", "您已被管理员限制登陆");
					return "login";
				}
				//将用户id，和姓名写入session
				getSession().put("username", username);
				getSession().put("userId", result);
				getSession().put("name",user.getUsername() );
				return SUCCESS;
			}
			switch (result) {
			case -1:
				addFieldError("password", "密码不正确");
				return "login";
			case -2:
				addFieldError("username","账户未激活，请验证激活后进行登陆");
				return "login";
			case 0:
				addFieldError("username", "该用户不存在");
				return "login";
			default:
				break;
			}
		
		return "login";
	}
	
	
	

}
