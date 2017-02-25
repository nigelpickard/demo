package com.npickard;

import com.npickard.model.Person;
import com.npickard.service.PersonService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;

/**
 * Created by npickard on 2/22/2017.
 */
@Component
public class PersonBuilder {
    private static final Log log = LogFactory.getLog(PersonBuilder.class);

    @Autowired
    EntityManager entityManager;

    @Autowired
    PersonService personService;

    public PersonBuilder(){}

    public void createPerson(Person person){
        System.out.println("Do this in sample");
        if (entityManager==null){
            log.error("EntityManager is null");
        } else {
            log.info("EntityManager is valid");
            personService.add(person);
        }
    }

}
