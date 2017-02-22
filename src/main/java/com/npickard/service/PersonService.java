package com.npickard.service;

import com.npickard.dao.PersonDAO;
import com.npickard.model.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;

/**
 * Created by npickard on 2/22/2017.
 */
@Component
public class PersonService {

    @Autowired
    private PersonDAO personDao;

    public PersonService(){}

    @Transactional
    public void add(Person person) {
        personDao.save(person);
    }

    @Transactional
    public void addAll(Collection<Person> persons) {
        for (Person person : persons) {
            personDao.save(person);
        }
    }

    @Transactional(readOnly = true)
    public List<Person> listAll() {
        return personDao.listAll();

    }

}
