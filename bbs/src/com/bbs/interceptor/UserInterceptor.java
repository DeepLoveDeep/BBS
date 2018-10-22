package com.bbs.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;

public class UserInterceptor extends AbstractInterceptor {

	@Override
	public String intercept(ActionInvocation arg0) throws Exception {
		String username = (String) ActionContext.getContext().getSession().get("username");
		String adminname = (String) ActionContext.getContext().getSession().get("adminname");
		if (username == null&&adminname == null){

			HttpServletRequest req = ServletActionContext.getRequest();
			// 获取此请求的地址，请求地址包含application name，进行subString操作，去除application name
			String path = req.getRequestURI().substring(10);
			// 获得请求中的参数
			String queryString = req.getQueryString();
			// 预防空指针
			if (queryString == null) {
				queryString = "";
			}
			// 拼凑得到登陆之前的地址
			String realPath = path + "?" + queryString;
			// 存入session，方便调用
			ActionContext.getContext().getSession().put("prePage", realPath);



			//未登录，进行拦截
			System.out.println("未登录进行拦截");
			return "login";
		}else {
			//放行
			return arg0.invoke();
		}
		
	}

}
