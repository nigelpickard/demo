package com.npickard;

import com.npickard.model.Person;
import com.npickard.service.PersonService;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;

/**
 * Created by npickard on 2/22/2017.
 */
@Component
public class PersonBuilder {

    @Autowired
    EntityManager entityManager;

    @Autowired
    PersonService personService;

    public PersonBuilder(){}

    public void createPerson(Person person){
        System.out.println("Do this in sample");
        if (entityManager==null){
            System.out.println("EntityManager is null");
        } else {
            System.out.println("EntityManager is valid!!!!!!");
            personService.add(person);
        }
    }


}
