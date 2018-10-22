package com.bbs.service;


import com.bbs.model.SysMessage;
import com.bbs.model.SysUser;

import java.util.List;

public interface SysUserBiz {
    /**
     * 根据用户id修改系统消息状态
     * */
    public void readAll( Integer userid);

  /*  *//**
     * 分页查找所有系统消息
     * *//*
    public void findAllByUserId(Integer userId);*/
}