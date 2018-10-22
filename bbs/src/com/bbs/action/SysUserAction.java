package com.bbs.action;


import com.bbs.service.SysUserBiz;

public class SysUserAction extends BaseAction {
    private Integer userid;
    private SysUserBiz sysUserBiz;

    public void setSysUserBiz(SysUserBiz sysUserBiz) {
        this.sysUserBiz = sysUserBiz;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    /**
     * 根据用户id修改系统消息状态
     * */
public String readAll(){
        try {
            sysUserBiz.readAll(userid);
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }
}
