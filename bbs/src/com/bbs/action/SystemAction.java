package com.bbs.action;

import com.bbs.model.SysMessage;
import com.bbs.service.*;
import net.sf.json.JSONArray;

import java.util.List;

public class SystemAction extends BaseAction {
    private Integer systemId;
    private String content;
    private SysMessageBiz systemBiz;
    private int pageNum;
    private int pageSize;

    public void setPageSize(int pageSize) {this.pageSize = pageSize;}

    public void setPageNum(int pageNum) {this.pageNum = pageNum;}

    public void setSystemBiz(SysMessageBiz systemBiz) {
        this.systemBiz = systemBiz;
    }

    public void setSystemId(Integer systemId) {
        this.systemId = systemId;
    }

    public void setContent(String content) {
        this.content = content;
    }

   /* public String findAllByPage()  {
        try {
            List<SysMessage> lists = systemBiz.findAllByPage(pageNum, pageSize);
            getRequest().put("sysMessages", lists);
            getRequest().put("page", pageNum);
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
    }*/
}
