package com.bbs.service;

import java.util.List;

import com.bbs.model.User;

/**
 * @author Shen
 * @version 1.0
 * 2018年6月16日下午1:32:23
 */
public interface UserBiz {
	public int regist(User user);
	/**
	 * 
	 * @param email
	 * @param password
	 * @return
	 */
	public int login(String email,String password);
	
	/**
	 * 判断用户的各项信息是否存在，包括用户名，邮箱
	 * @param user
	 * @return 返回1代表存在相同的用户名，2代表存在相同的邮箱，返回负数代表不存在该用户的信息
	 */
	public int isExist(User user);
	
	
	/**
	 * 激活用户
	 * @param activeCode 激活码
	 * @return 1-激活成功,0-该用户未激活
	 */
	public int activeUser(String activeCode);


	public void updateCode(String username,String code);
	
	public void update(User user);
	public int getUserIdByUsername(String username);
	public int getUserIdByEmail(String email);
	public User getUserById(Integer integer);
	public List<User> getUserLike(String like);

	

}
