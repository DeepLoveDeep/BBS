package com.bbs.serviceImpl;

import com.bbs.dao.SysMessageDao;
import com.bbs.model.SysMessage;
import com.bbs.model.SysUser;
import com.bbs.service.SysMessageBiz;

import java.util.List;

/**
 * @author Shen
 * @version 1.0
 *          2018年6月16日下午1:32:23
 */
public class SysMessageBizImpl implements SysMessageBiz {

    private SysMessageDao sysMessageDao;

    public void setSysMessageDao(SysMessageDao sysMessageDao) {
        this.sysMessageDao = sysMessageDao;
    }

    /**
     * 查询所有系统消息
     */
    @Override
    public Long findAll(Integer userid) {
        return sysMessageDao.findAll(userid);
    }

    /**
     * 分页查找所有系统消息
     * */
    @Override
    public List<SysUser> findAllByUserId(Integer userId) {
        return sysMessageDao.findAllByUserId(userId);
    }
}
