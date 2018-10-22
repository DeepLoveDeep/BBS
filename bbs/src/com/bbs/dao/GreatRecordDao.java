package com.bbs.dao;

import com.bbs.model.GreatRecord;

/**点赞记录接口
 * Created by ACER NO1 on 2018/10/18.
 */
public interface GreatRecordDao {

    public GreatRecord queryIsGreatByUserId(GreatRecord greadRecord);

    public void save(GreatRecord greadRecord);

    public void update(GreatRecord greadRecord);

    public void delete(GreatRecord greadRecord);
}
