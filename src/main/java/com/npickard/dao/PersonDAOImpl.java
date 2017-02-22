package com.npickard.dao;

import com.npickard.model.Person;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.stereotype.Component;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * Created by npickard on 2/22/2017.
 */
@Component
public class PersonDAOImpl implements PersonDAO {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void save(Person person) {
        em.persist(person);
    }

    @Override
    public List<Person> listAll() {
        return em.createQuery("SELECT p FROM Person p").getResultList();
    }
}
