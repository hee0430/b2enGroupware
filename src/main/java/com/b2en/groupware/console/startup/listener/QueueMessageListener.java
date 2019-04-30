package com.b2en.groupware.console.startup.listener;

import javax.jms.Message;
import javax.jms.MessageListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class QueueMessageListener implements MessageListener {

    static final Logger logger = LoggerFactory.getLogger(QueueMessageListener.class);

    @Override
    public void onMessage(Message arg0) {
	logger.debug("{}", arg0);
    }

}
