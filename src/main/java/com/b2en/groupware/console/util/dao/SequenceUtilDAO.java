package com.b2en.groupware.console.util.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.b2en.groupware.console.Const;

@Component
public class SequenceUtilDAO {

    @Autowired
    @Qualifier(Const.DATABASE_POOL_NAME_DEFAULT)
    private SqlSession sqlSession;

    public synchronized int getSequence(String seqId) throws Exception {
	String seqValue = null;
	try {
	    Map<String, Object> param = new HashMap<>();
	    param.put("seqId", seqId);
	    seqValue = sqlSession.selectOne("SequenceMapper.SELECT_SEQUENCE", param);
	    if (seqValue == null) {
		param.put("seqValue", 2);
		sqlSession.insert("SequenceMapper.INSERT_SEQUENCE", param);
		seqValue = "1";
	    } else {
		sqlSession.update("SequenceMapper.UPDATE_SEQUENCE", param);
	    }
	} catch (Exception e) {
	    throw e;
	}
	return Integer.parseInt(seqValue);
    }
}
