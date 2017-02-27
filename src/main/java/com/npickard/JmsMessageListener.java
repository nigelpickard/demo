package com.npickard;

import com.npickard.model.Person;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
/**
 * POJO class, have handleMessage(...) method.
 * The return of handleMessage(...) will be
 * automatically send back to message.getJMSReplyTo().
 */
public class JmsMessageListener {
    private static final Log log = LogFactory.getLog(JmsMessageListener.class);
    MessagePersistenceMode messagePersistenceMode = MessagePersistenceMode.PERSIST;

    @Autowired
    PersonBuilder personBuilder;

    public String handleMessage(String text) {
        log.info("Received: " + text);
        personBuilder.createPerson(messagePersistenceMode, new Person(text));
        return "ACK from handleMessage";
    }
}