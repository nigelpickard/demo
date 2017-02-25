package com.npickard;

import com.npickard.model.Person;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by npickard on 2/20/2017.
 */
@RestController
public class MyDemoRESTController {
    private static final Log log = LogFactory.getLog(MyDemoRESTController.class);
    private static final MessagePersistenceMode messagePersistenceMode = MessagePersistenceMode.MESSAGE;

    @Autowired
    PersonBuilder personBuilder;

    @RequestMapping("/")
    public String index() {
        return "This is a message from the MyDemo REST Controller!";
    }

    @RequestMapping(value = "/person", method = RequestMethod.GET)
    public String createPersonByRequestParam(@RequestParam("name") String personName) {
        log.info("about to create a person called " + personName);
        Person person = new Person(personName);
        personBuilder.createPerson(messagePersistenceMode, person);
        return ("Person saved is " + person.toString());
    }

    @RequestMapping(value = "/persons", method = RequestMethod.GET)
    public String getAllPerson() {
        log.info("about to get all persons");
        List<Person> persons = personBuilder.getAllPersons();
        StringBuffer sb = new StringBuffer();
        sb.append("<br>");
        for (Person person : persons){
            sb.append(person.toString() + "<br>");
        }
        return ("Persons persisted in database are " + sb.toString());
    }
    @RequestMapping(value = "/mq", method = RequestMethod.GET)
    public String createPersonByRequestParam(@RequestParam("on") boolean isOn) {
        String message = "JMS is turned ";
        if (isOn){
            message = message + "on!";
        } else {
            message = message + "off...";
        }
        return message;
    }

}
