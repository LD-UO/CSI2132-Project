package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Represents a reservation in the hotel reservation system.
 * This class stores information about a reservation, including
 * details about the employee who made the reservation, the room number,
 * the username of the customer, a unique reservation ID, and the start
 * and end dates of the reservation period.
 */

public class Reservation {
    private int employeeId;
    private int roomNum;
    private String username;
    private int reservationId; // Assuming this is generated by the database and not passed in constructor (SERIAL)
    private String startDate;
    private String endDate;
    /**
     * Constructs a new Reservation instance.
     *
     * @param employeeId The ID of the employee who made the reservation.
     * @param roomNum The room number associated with this reservation.
     * @param username The username of the customer making the reservation.
     * @param startDate The start date of the reservation period (format: YYYY-MM-DD).
     * @param endDate The end date of the reservation period (format: YYYY-MM-DD).
     */
    public Reservation(int employeeId, int roomNum, String username, String startDate, String endDate) {
        this.employeeId = employeeId;
        this.roomNum = roomNum;
        this.username = username;
        this.startDate = startDate;
        this.endDate = endDate;
        // reservationId is not included in the constructor parameter as it's typically auto-generated by the database.
    }

    // Getters
    public int getEmployeeId() {
        return employeeId;
    }

    public int getRoomNum() {
        return roomNum;
    }

    public String getUsername() {
        return username;
    }

    public int getReservationId() {
        return reservationId;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    // Setters
    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public void setRoomNum(int roomNum) {
        this.roomNum = roomNum;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Note: Typically, you might not provide a setter for reservationId since it's auto-generated by the database.
    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }


    public boolean makeReservation (Room r, String startDate, String endDate) throws Exception {
        if (!r.isAvailable()){
            return false; //room not available
        }

        try (Connection con = new ConnectionDB().getConnection()) {
            // Select a random employee
            String selectEmployeeSql = "SELECT employee_id FROM Employee ORDER BY RANDOM() LIMIT 1";
            int employeeId = -1;
            try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(selectEmployeeSql)) {
                if (rs.next()) {
                    employeeId = rs.getInt("employee_id");
                } else {
                    throw new Exception("No employees found"); // handle error
                }
            }

            // Insert the reservation into the database
            String insertSql = "INSERT INTO Reservation (employee_id, RoomNum, username, startDate, endDate) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(insertSql)) {
                pstmt.setInt(1, employeeId);
                pstmt.setInt(2, r.getRoomNum()); // Assuming Room class has a getRoomNum method
                pstmt.setString(3, username);
                pstmt.setDate(4, java.sql.Date.valueOf(startDate));
                pstmt.setDate(5, java.sql.Date.valueOf(endDate));

                int affectedRows = pstmt.executeUpdate();
                if (affectedRows > 0) {
                    return true; //successful reservation
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }



}
