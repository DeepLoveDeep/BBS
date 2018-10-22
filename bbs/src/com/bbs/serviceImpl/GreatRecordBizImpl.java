package com.bbs.serviceImpl;

import com.bbs.dao.GreatRecordDao;
import com.bbs.model.GreatRecord;
import com.bbs.service.GreatRecordBiz;

/**
 * Created by ACER NO1 on 2018/10/19.
 */
public class GreatRecordBizImpl implements GreatRecordBiz {
    private GreatRecordDao greatRecordDao;

    public GreatRecordDao getGreatRecordDao() {
        return greatRecordDao;
    }

    public void setGreatRecordDao(GreatRecordDao greatRecordDao) {
        this.greatRecordDao = greatRecordDao;
    }

    @Override
    public GreatRecord queryIsGreatByUserId(GreatRecord greadRecord) {
        return greatRecordDao.queryIsGreatByUserId(greadRecord);
    }

    @Override
    public void save(GreatRecord greadRecord) {
        greatRecordDao.save(greadRecord);
    }

    @Override
    public void update(GreatRecord greadRecord) {
        greatRecordDao.update(greadRecord);
    }

    @Override
    public void delete(GreatRecord greadRecord) {
        greatRecordDao.delete(greadRecord);
    }
}
