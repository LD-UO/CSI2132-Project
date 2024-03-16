package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class Registration extends UserManagement{
     /*
    The functionality for this class will be similar to login, in that it will check if a user is already registered. If they are, they will not be allowed
    to register again. If they are not, they will be allowed to register and it will setup a new user in the database.
     */
    /**
     * Registers user into the hotel database.
     * @param registeredUsername The username given when registering.
     * @param registeredName The name given when registering.
     * @param registeredSin The SIN given when registering.
     * @param registeredAddress The address given when registering.
     */
    public Customer userRegistration(String registeredUsername, String registeredName, String registeredSin, String registeredAddress) throws Exception {
        if (!usernameExists(registeredUsername)){

            Customer c = new Customer(registeredUsername, registeredName, registeredSin, registeredAddress); //creates new Customer obj

            Customer.addCustomer(c); //adds to DB, will throw exception if error is encountered

            return c; //returns said Customer obj

        }else{

            return null; //returns null when usernameExists, can be handled in front end

        }
    }
}
