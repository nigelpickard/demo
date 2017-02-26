package com.npickard.dao;

import com.npickard.model.Person;

import java.util.List;

/**
 * Created by npickard on 2/22/2017.
 */
public interface PersonDAO {

    public void save(Person person);

    public List<Person> listAll();

}
