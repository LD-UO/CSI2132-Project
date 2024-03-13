package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Customer class to store customer information
 */
public class Customer {
    private String username;
    private String name;
    private String SIN;
    private String address;

    /**
     * Constructor to store customer's information
     * @param username username of the customer
     * @param name name of the customer
     * @param SIN SIN of the customer
     * @param address address of the customer
     */
    public Customer(String username, String name, String SIN, String address){
        // Am I going to need validation here to ensure that the fields have been entered correctly?
        this.username = username;
        this.name = name;
        this.SIN = SIN;
        this.address = address;
    }

    // getters
    public String getUsername(){ return this.username; }

    public String getName(){ return this.name; }

    public String getSIN(){ return this.SIN; }

    public String getAddress(){ return this.address; }

    // setters
    // Will only allow customers to update their name and address, as username and SIN does not make semantic sense to be able to be changed
    public void setName(String name){ this.name = name; }
    public void setAddress(String address){ this.address = address; }

    // TODO: Implement a toString() method? Is there any need for displaying the customer information, I don't think so

    /**
     * Inserts a new customer into the database.
     * @param customer The customer to be added to the database.
     * @throws Exception Throws an exception if the database operation fails.
     */
    public static void addCustomer(Customer customer) throws Exception {
        ConnectionDB db = new ConnectionDB();
        Connection con = null;
        try {
            con = db.getConnection();
            String insertQuery = "INSERT INTO Customers (username, name, sin, address) VALUES (?, ?, ?, ?)";

            PreparedStatement statement = con.prepareStatement(insertQuery);
            statement.setString(1, customer.getUsername());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getSIN());
            statement.setString(4, customer.getAddress());

            statement.executeUpdate(); //executes CRUD statements that modify DB but don't return anything, we are INSERTING here

            statement.close();
            con.close();
            db.close();
        } catch (Exception e) {
            throw new Exception("Error adding customer: " + e.getMessage());
        }
    }

}
