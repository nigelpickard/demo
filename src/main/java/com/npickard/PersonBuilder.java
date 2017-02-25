package com.npickard;

import com.npickard.model.Person;
import com.npickard.service.PersonService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;

/**
 * Created by npickard on 2/22/2017.
 */
@Component
public class PersonBuilder implements ApplicationContextAware {
    private static final Log log = LogFactory.getLog(PersonBuilder.class);
    private ApplicationContext applicationContext;

    @Autowired
    EntityManager entityManager;

    @Autowired
    PersonService personService;

    //@Autowired
    JmsTemplate jmsTemplate;

    public PersonBuilder(){}

    public void createPerson(MessagePersistenceMode messagePersistenceMode, Person person){

        jmsTemplate = applicationContext.getBean(JmsTemplate.class);
        if (messagePersistenceMode == null){
            log.warn("Message Persistence Mode is null; no operation done.");
        }

        if (person == null){
            log.warn("Person to create is null!");
        }

        log.info("Creating person(" + person.toString() + ") with persistence mode: " + messagePersistenceMode);

        if (MessagePersistenceMode.MESSAGE.equals(messagePersistenceMode)){
            log.info("Sending person message: " + person.toString());
            jmsTemplate.convertAndSend("mailbox", person);
        }

        if (MessagePersistenceMode.PERSIST.equals(messagePersistenceMode)){
            log.info("Persisting person: " + person.toString());
            personService.add(person);
        }
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
