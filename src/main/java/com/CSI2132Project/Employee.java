package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Employee {
    private int employeeId;
    private String streetName;
    private int streetNum;
    private String postalCode;
    private String name;
    private String phone;
    private String position;
    private String SIN;

    // Constructor
    public Employee(int employeeId, String streetName, int streetNum, String postalCode,
                    String name, String phone, String position, String SIN) {
        this.employeeId = employeeId;
        this.streetName = streetName;
        this.streetNum = streetNum;
        this.postalCode = postalCode;
        this.name = name;
        this.phone = phone;
        this.position = position;
        this.SIN = SIN;
    }

    // Getters
    public int getEmployeeId() {
        return employeeId;
    }

    public String getStreetName() {
        return streetName;
    }

    public int getStreetNum() {
        return streetNum;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String getPosition() {
        return position;
    }

    public String getSIN() {
        return SIN;
    }

    // Setters
    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

    public void setStreetNum(int streetNum) {
        this.streetNum = streetNum;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public void setSIN(String SIN) {
        this.SIN = SIN;
    }

    public static boolean checkEmployeeExists(int employeeId) {
        boolean exists = false; //default case

        String sql = "SELECT EXISTS (SELECT 1 FROM Employee WHERE employee_id = ?) AS \"exists\"";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, employeeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getBoolean("exists");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }

    public List<Reservation> viewMyReservations() {
        List<Reservation> myReservations = new ArrayList<>();
        String sql = "SELECT * FROM Reservation WHERE employee_id = ?"; //gets all reservations for THIS employee

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, this.employeeId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Reservation reservation = new Reservation(
                        rs.getInt("reservation_id"),
                        rs.getInt("RoomNum"),
                        rs.getString("username"),
                        rs.getString("startDate"),
                        rs.getString("endDate")
                ); //create reservation object through iteration and add to arraylist of reservations
                myReservations.add(reservation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return myReservations;
    }


}
