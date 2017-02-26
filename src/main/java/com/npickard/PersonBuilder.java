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
import java.util.List;

/**
 * Created by npickard on 2/22/2017.
 */
@Component
public class PersonBuilder implements ApplicationContextAware {
    private static final Log log = LogFactory.getLog(PersonBuilder.class);
    private ApplicationContext applicationContext;
    private boolean isJMS = true;

    @Autowired
    private EntityManager entityManager;

    @Autowired
    private PersonService personService;

    private JmsTemplate jmsTemplate;

    public PersonBuilder(){}

    public void createPerson(MessagePersistenceMode messagePersistenceMode, Person person){

        if (messagePersistenceMode == null){
            log.warn("Message Persistence Mode is null; no operation done.");
        }

        if (person == null){
            log.warn("Person to create is null!");
        }

        jmsTemplate = applicationContext.getBean(JmsTemplate.class);

        if (MessagePersistenceMode.MESSAGE.equals(messagePersistenceMode)){
            if (isJMS) {
                log.info("Sending person message: " + person.toString());
                jmsTemplate.convertAndSend("mailbox", person);
            }else {
                log.info("JMS not on; setting person to just persist");
                messagePersistenceMode = MessagePersistenceMode.PERSIST;
            }
        }

        if (MessagePersistenceMode.PERSIST.equals(messagePersistenceMode)){
            log.info("Persisting person: " + person.toString());
            personService.add(person);
        }
    }

    public List<Person> getAllPersons(){
        return personService.listAll();
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    public void isJMS(boolean val){
        isJMS = val;
    }
}
