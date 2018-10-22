package com.bbs.serviceImpl;

import com.bbs.dao.SysMessageDao;
import com.bbs.dao.SysUserDao;
import com.bbs.model.SysMessage;
import com.bbs.model.SysUser;
import com.bbs.service.SysUserBiz;

import java.util.List;

/**
 * @author Shen
 * @version 1.0
 *          2018年6月16日下午1:32:23
 */
public class SysUserBizImpl implements SysUserBiz {

    private SysUserDao sysUserDao;

    public void setSysUserDao(SysUserDao sysUserDao) {
        this.sysUserDao = sysUserDao;
    }

    @Override
    public void readAll(Integer userid) {
        sysUserDao.readAll(userid);
    }
}
