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

    // Empty constructor to use the methods
    public Employee(){}

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

    public List<Reservation> viewAllReservations(int employeeID) {
        List<Reservation> myReservations = new ArrayList<>();

        // Include a join with the Room table to check room availability and compare startDate with the current date
        String sql = "SELECT Reservation.* FROM Reservation " +
                "JOIN Room ON Reservation.RoomNum = Room.RoomNum " +
                "AND Reservation.streetnum = Room.streetnum " +
                "AND Reservation.streetname = Room.streetname " +
                "AND Reservation.postalcode = Room.postalcode " +
                "WHERE Reservation.employee_id = ? " +
                "AND (Room.Available = FALSE);";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, employeeID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // Assuming Reservation constructor and attributes
                Reservation reservation = new Reservation(
                        rs.getInt("reservation_id"),
                        rs.getInt("RoomNum"),
                        rs.getString("username"),
                        rs.getDate("startDate").toString(),
                        rs.getDate("endDate").toString(),
                        rs.getInt("StreetNum"),
                        rs.getString("StreetName"),
                        rs.getString("PostalCode")
                );
                myReservations.add(reservation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return myReservations;
    }

    /**
     * Views reservations for an employee where the reservation's start date hasn't arrived yet or if the room is available.
     * @param employeeID The employee ID to view reservations for.
     * @return A list of reservations meeting the criteria.
     */
    public List<Reservation> viewMyReservations(int employeeID) {
        List<Reservation> myReservations = new ArrayList<>();

        // Include a join with the Room table to check room availability and compare startDate with the current date
        String sql = "SELECT Reservation.* FROM Reservation " +
                "JOIN Room ON Reservation.RoomNum = Room.RoomNum " +
                "AND Reservation.streetnum = Room.streetnum " +
                "AND Reservation.streetname = Room.streetname " +
                "AND Reservation.postalcode = Room.postalcode " +
                "WHERE Reservation.employee_id = ? " +
                "AND (Room.Available = TRUE AND Reservation.startDate >= CURRENT_DATE);";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, employeeID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // Assuming Reservation constructor and attributes
                Reservation reservation = new Reservation(
                        rs.getInt("reservation_id"),
                        rs.getInt("RoomNum"),
                        rs.getString("username"),
                        rs.getDate("startDate").toString(),
                        rs.getDate("endDate").toString(),
                        rs.getInt("StreetNum"),
                        rs.getString("StreetName"),
                        rs.getString("PostalCode")
                );
                myReservations.add(reservation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return myReservations;
    }

    public static boolean addEmployee(Employee employee) {
        String sql = "INSERT INTO Employee (employee_id, streetName, streetNum, postalCode, name, phone, position, SIN) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        boolean result = false;

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, employee.getEmployeeId());
            pstmt.setString(2, employee.getStreetName());
            pstmt.setInt(3, employee.getStreetNum());
            pstmt.setString(4, employee.getPostalCode());
            pstmt.setString(5, employee.getName());
            pstmt.setString(6, employee.getPhone());
            pstmt.setString(7, employee.getPosition());
            pstmt.setString(8, employee.getSIN());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Employee added successfully.");
                result = true;
            } else {
                System.err.println("Failed to add employee.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static boolean deleteEmployee(Employee employee) {
        String sql = "DELETE FROM Employee WHERE employee_id = ?;";
        boolean result = false;

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, employee.getEmployeeId());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Employee deleted successfully.");
                result = true;
            } else {
                System.err.println("Failed to delete employee. Employee may not exist or could not be found with the given ID.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static boolean updateEmployee(int employeeID, String name, String phoneNumber, String position){
        // Need to have cases for each
        boolean result = false;
        ConnectionDB db = new ConnectionDB();
        String sql = "";

        if (!name.isEmpty() && phoneNumber.isEmpty() && position.isEmpty()){
            sql = "UPDATE employee SET name = ? dWHERE employee_id = ?";
            try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
                statement.setString(1, name);
                statement.setInt(2, employeeID);

                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        } else if (!name.isEmpty() && !phoneNumber.isEmpty() && position.isEmpty()){
            sql = "UPDATE employee SET name = ?, phone = ?WHERE employee_id = ?";
            try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
                statement.setString(1, name);
                statement.setString(2, phoneNumber);
                statement.setInt(3, employeeID);

                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        } else if (!name.isEmpty() && !phoneNumber.isEmpty() && !position.isEmpty()){
            sql = "UPDATE employee SET name = ?, phone = ?, position = ? WHERE employee_id = ?";
            try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
                statement.setString(1, name);
                statement.setString(2, phoneNumber);
                statement.setString(3, position);
                statement.setInt(4, employeeID);

                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        } else if (name.isEmpty() && !phoneNumber.isEmpty() && position.isEmpty()){
            sql = "UPDATE employee SET phone = ? WHERE employee_id = ?";
            try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
                statement.setString(1, phoneNumber);
                statement.setInt(2, employeeID);

                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        } else if (name.isEmpty() && !phoneNumber.isEmpty() && !position.isEmpty()){
            sql = "UPDATE employee SET phone = ?, position = ? WHERE employee_id= ?";
            try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
                statement.setString(1, phoneNumber);
                statement.setString(2, position);
                statement.setInt(2, employeeID);

                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        } else if (name.isEmpty() && phoneNumber.isEmpty() && !position.isEmpty()){
            sql = "UPDATE employee SET position = ? WHERE employee_id= ?";
            try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
                statement.setString(1, position);
                statement.setInt(2, employeeID);

                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0){
                    result = true;
                } else {
                    System.err.println("Something went wrong!");
                }
            } catch (Exception e){
                e.printStackTrace();
            }

        } else if (!name.isEmpty() && phoneNumber.isEmpty() && !position.isEmpty()){
            sql = "UPDATE employee SET name = ?, position = ? WHERE employee_id = ?";
            try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
                statement.setString(1, name);
                statement.setString(2, position);
                statement.setInt(3, employeeID);

                int rowsAffected = statement.executeUpdate();
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
    /**
     * Retrieves all employees working at a specific hotel instance identified by its address.
     *
     * @param streetNum The street number of the hotel.
     * @param streetName The street name of the hotel.
     * @param postalCode The postal code of the hotel.
     * @return A list of Employee objects representing all employees working at the specified hotel.
     *
     */
    public static List<Employee> getAllEmployeesAtHotel(int streetNum, String streetName, String postalCode) {
        List<Employee> employees = new ArrayList<>();
        ConnectionDB db = new ConnectionDB();

        String sql = "SELECT * FROM Employee WHERE StreetNum = ? AND StreetName = ? AND PostalCode = ?;"; //join these attrs with PK of hotelinstance

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, streetNum);
            ps.setString(2, streetName);
            ps.setString(3, postalCode);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Employee employee = new Employee(
                        rs.getInt("employee_id"),
                        rs.getString("streetName"),
                        rs.getInt("streetNum"),
                        rs.getString("postalCode"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("position"),
                        rs.getString("SIN")
                );
                employees.add(employee);
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return employees;
    }

    public static int getRoomsInHotel(int streetNum, String streetName, String postalCode){
        ConnectionDB db = new ConnectionDB();
        int capacity = 0;


        String sql = "SELECT capacity from hotels_by_capacity where streetnum = ? and streetname = ? and postalcode=?";

        try (Connection con = db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1, streetNum);
            ps.setString(2, streetName);
            ps.setString(3, postalCode);

            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                capacity = rs.getInt("capacity");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return capacity;
    }

}
