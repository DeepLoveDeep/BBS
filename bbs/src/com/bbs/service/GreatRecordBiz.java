package com.bbs.service;

import com.bbs.model.GreatRecord;

/**
 * Created by ACER NO1 on 2018/10/19.
 */
public interface GreatRecordBiz {
    //根据用户id和评论id查询点赞记录
    public GreatRecord queryIsGreatByUserId(GreatRecord greadRecord);
    //新增点赞记录
    public void save(GreatRecord greadRecord);
    ///修改点赞记录
    public void update(GreatRecord greadRecord);
    //删除点赞记录
    public void delete(GreatRecord greadRecord);
}
