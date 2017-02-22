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
public class MySample {

    @Autowired
    EntityManager entityManager;

    @Autowired
    PersonService personService;

    public MySample(){}

    public void doThis(){
        System.out.println("Do this in sample");
        if (entityManager==null){
            System.out.println("EntityManager is null");
        } else {
            System.out.println("EntityManager is valid!!!!!!");

            Person person = new Person();
            person.setName("Fred Bloggs");
            person.setCountry("UK");
            personService.add(person);
        }
    }


}
