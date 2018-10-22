package com.bbs.action;

import com.bbs.model.User;
import com.bbs.service.UserBiz;

/**
 * 激活信息处理
 *
 * @author Shen
 * @version 1.0
 *          2018年6月16日下午4:38:12
 */
public class ActiveAction extends BaseAction {
    private UserBiz userBiz;
    private String code;



    /**
     * @param code the code to set
     */
    public void setCode(String code) {this.code = code; }

    /**
     * @param userBiz the userBiz to set
     */
    public void setUserBiz(UserBiz userBiz) {
        this.userBiz = userBiz;
    }


    /* (non-Javadoc)
     * @see com.opensymphony.xwork2.ActionSupport#execute()
     */
    @Override
    public String execute() throws Exception {
        if (code == null){
            return "index";
        }else{
            String str = "message";
            int res = userBiz.activeUser(code);
            if (res==0) {
                getRequest().put("message", "该用户不存在");
            }else if(res==1){
                getRequest().put("message", "恭喜您！账户激活成功，五秒钟后自动跳转，无法跳转请点击下面按钮");
                str = "skip_login";
            }else{
                getRequest().put("message", "该用户已激活，请勿重复激活");
            }
            return str;
        }

    }

}
