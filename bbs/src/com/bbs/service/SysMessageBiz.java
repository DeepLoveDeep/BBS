package com.bbs.service;


import com.bbs.model.SysMessage;
import com.bbs.model.SysUser;

import java.util.List;

public interface SysMessageBiz {
   /**
    * 查找所有系统消息总量
    * */
    public Long findAll( Integer userid);

    /**
     * 分页查找所有系统消息
     * */
    public List<SysUser> findAllByUserId(Integer userId);
}