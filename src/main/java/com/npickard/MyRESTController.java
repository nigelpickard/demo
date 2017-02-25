package com.npickard;

import com.npickard.model.Person;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Created by npickard on 2/20/2017.
 */
@RestController
public class MyRESTController {
    private static final Log log = LogFactory.getLog(MyRESTController.class);

    @Autowired
    PersonBuilder personBuilder;

    @RequestMapping("/")
    public String index() {
        return "This is a message from MyHelloController!";
    }

    @RequestMapping(value = "/person", method = RequestMethod.GET)
    public String createPersonByRequestParam(@RequestParam("name") String personName) {
        log.info("about to create a person called " + personName);
        Person person = new Person();
        person.setName(personName);
        personBuilder.createPerson(person);
        return ("Person saved is " + person.toString());
    }

}
