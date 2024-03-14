package com.CSI2132Project;

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


}
