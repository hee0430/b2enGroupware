package com.b2en.groupware.console.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.b2en.groupware.console.Const;
import com.b2en.groupware.console.util.dao.SequenceUtilDAO;

@Component
public class SequenceUtil {
    private static Logger logger = LoggerFactory.getLogger(SequenceUtil.class);

    @Autowired
    SequenceUtilDAO sequenceUtilDAO;

    @Transactional(transactionManager = Const.TRANSACTION_MANAGER_DEFAULT, propagation = Propagation.REQUIRES_NEW)
    public synchronized int getSequence(String seqId) throws Exception {
	logger.debug("Make [{}] Sequence", seqId);
	return sequenceUtilDAO.getSequence(seqId);
	//
    }

}
