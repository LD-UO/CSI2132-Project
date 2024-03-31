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

    public static boolean updateCustomer(String username, String name, String address){
        boolean result = false;

        // If there's only been a change to the address
        if (name.length() == 0){
            String sql = "UPDATE customers SET address = ? WHERE username = ?";

            try (Connection con = new ConnectionDB().getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, address);
                pstmt.setString(2, username);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        } else if(address.length() == 0) {
            // If there's only been a change to the name
            String sql = "UPDATE customers SET name = ? WHERE username = ?";

            try (Connection con = new ConnectionDB().getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, username);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        } else {
            // There's been a change to both
            String sql = "UPDATE customers SET address = ?, name = ? WHERE username = ?";

            try (Connection con = new ConnectionDB().getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, address);
                pstmt.setString(2, name);
                pstmt.setString(3, username);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return result;
    }
    public static Customer getCustomer(String username) {
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            String sql = "SELECT * FROM Customers WHERE username = ?";

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, username);

                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String customerUsername = rs.getString("username");
                    String name = rs.getString("name");
                    String SIN = rs.getString("sin");
                    String address = rs.getString("address");

                    return new Customer(customerUsername, name, SIN, address);
                }

            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return null; //If no customer could be found
    }
    public static boolean deleteCustomer(Customer customer) {
        boolean result = false;
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
                    result = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
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
