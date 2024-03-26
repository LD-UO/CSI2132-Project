package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
        try (Connection con = db.getConnection()) {
            String sql = "INSERT INTO Customers (username, name, SIN, address) VALUES (?, ?, ?, ?)";

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, customer.getUsername());
                pstmt.setString(2, customer.getName());
                pstmt.setString(3, customer.getSIN());
                pstmt.setString(4, customer.getAddress());

                int affectedRows = pstmt.executeUpdate();
                if (affectedRows == 0) {
                    throw new Exception("Inserting customer failed, no rows affected.");
                }
            }
        } catch (Exception e) {
            throw new Exception("Error adding customer: " + e.getMessage(), e);
        }
    }

    public static void deleteCustomer(Customer customer) throws Exception {
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            String sql = "DELETE FROM Customers WHERE username = ?";

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, customer.getUsername());

                int affectedRows = pstmt.executeUpdate();
                if (affectedRows == 0) {
                    throw new Exception("Deleting customer failed, no rows affected.");
                } else {
                    System.out.println("Customer deleted successfully.");
                }
            }
        } catch (Exception e) {
            throw new Exception("Error deleting customer: " + e.getMessage(), e);
        }
    }

    /**
     * Retrieves all customers from the database.
     * @return A List of Customer objects.
     * @throws Exception If an error occurs during database access.
     */
    public static List<Customer> getAllCustomers() throws Exception {
        List<Customer> customers = new ArrayList<>();
        ConnectionDB db = new ConnectionDB();

        String sql = "SELECT * FROM Customers;"; //simple get all customers

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getString("username"),
                        rs.getString("name"),
                        rs.getString("SIN"),
                        rs.getString("address")
                );
                customers.add(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Failed to retrieve customers: " + e.getMessage());
        }
        return customers;
    }

}
