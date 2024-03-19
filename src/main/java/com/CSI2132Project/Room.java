package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

public class Room {

    private int roomNum;
    private int streetNum;
    private String streetName;
    private String postalCode;
    private double price;
    private boolean tv;
    private boolean ac;
    private boolean fridge;
    private int capacity;
    private boolean isExtendable;
    private String defects;
    private String viewDescription;
    private boolean available;


    public Room(){
        // Creating an empty constructor so I can create a Room instance to access the findAvailableRooms method
    }
    /**
     * Constructor
     * @param roomNum
     * @param streetNum
     * @param streetName
     * @param postalCode
     * @param price
     * @param tv
     * @param ac
     * @param fridge
     * @param capacity
     * @param isExtendable
     * @param defects
     * @param viewDescription
     * @param available
     */


    public Room(int roomNum, int streetNum, String streetName, String postalCode, double price, boolean tv, boolean ac, boolean fridge, int capacity, boolean isExtendable, String defects, String viewDescription, boolean available) {
        this.roomNum = roomNum;
        this.streetNum = streetNum;
        this.streetName = streetName;
        this.postalCode = postalCode;
        this.price = price;
        this.tv = tv;
        this.ac = ac;
        this.fridge = fridge;
        this.capacity = capacity;
        this.isExtendable = isExtendable;
        this.defects = defects;
        this.viewDescription = viewDescription;
        this.available = available;
    }

    // Getters
    public int getRoomNum() { return roomNum; }
    public int getStreetNum() { return streetNum; }
    public String getStreetName() { return streetName; }
    public String getPostalCode() { return postalCode; }
    public double getPrice() { return price; }
    public boolean isTv() { return tv; }
    public boolean isAc() { return ac; }
    public boolean isFridge() { return fridge; }
    public int getCapacity() { return capacity; }
    public boolean isExtendable() { return isExtendable; }
    public String getDefects() { return defects; }
    public String getViewDescription() { return viewDescription; }
    public boolean isAvailable() { return available; }


    // Setters
    public void setRoomNum(int roomNum) { this.roomNum = roomNum; }
    public void setStreetNum(int streetNum) { this.streetNum = streetNum; }
    public void setStreetName(String streetName) { this.streetName = streetName; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }
    public void setPrice(double price) { this.price = price; }
    public void setTv(boolean tv) { this.tv = tv; }
    public void setAc(boolean ac) { this.ac = ac; }
    public void setFridge(boolean fridge) { this.fridge = fridge; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    public void setExtendable(boolean isExtendable) { this.isExtendable = isExtendable; }
    public void setDefects(String defects) { this.defects = defects; }
    public void setViewDescription(String viewDescription) { this.viewDescription = viewDescription; }
    public void setAvailable(boolean available) { this.available = available; }

    /**
     * Finds and returns a list of available rooms for a given date range.
     *
     * @param startDate The start date of the desired reservation period (format: YYYY-MM-DD).
     * @param endDate The end date of the desired reservation period (format: YYYY-MM-DD).
     * @return A list of available rooms.
     */
    public static List<Room> findAvailableRooms(String startDate, String endDate) throws Exception {

        List<Room> availableRooms = new ArrayList<>();
        ConnectionDB db = new ConnectionDB();
        String sql = "SELECT Room.* " +
                "FROM Room " +
                "LEFT JOIN Reservation ON Room.RoomNum = Reservation.RoomNum " +
                "AND Reservation.startDate <= ? " +
                "AND Reservation.endDate >= ? " +
                "WHERE Reservation.RoomNum IS NULL " +
                "GROUP BY Room.RoomNum, Room.StreetNum, Room.StreetName, Room.PostalCode " +
                "HAVING COUNT(Reservation.RoomNum) = 0;";

        // Converting the string dates to SQL date objects so that they can be used for comparison purposes
        Date startDateSQL = Date.valueOf(startDate);
        Date endDateSQL = Date.valueOf(endDate);

        try {
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            // Setting the parameters for the PreparedStatement
            ps.setDate(1, startDateSQL);
            ps.setDate(2, endDateSQL);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    //Get all rooms in this query
                    Room room = new Room(
                            rs.getInt("RoomNum"),
                            rs.getInt("StreetNum"),
                            rs.getString("StreetName"),
                            rs.getString("PostalCode"),
                            rs.getDouble("Price"),
                            rs.getBoolean("TV"),
                            rs.getBoolean("AC"),
                            rs.getBoolean("Fridge"),
                            rs.getInt("Capacity"),
                            rs.getBoolean("IsExtendable"),
                            rs.getString("Defects"),
                            rs.getString("ViewDescription"),
                            rs.getBoolean("Available")
                    );

                    availableRooms.add(room);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return availableRooms;
    }

    public static List<Room> findAllAvailableRooms() {
        List<Room> availableRooms = new ArrayList<>();
        String sql = "SELECT * FROM Room WHERE Available = TRUE AND NOT EXISTS (" +
                "SELECT 1 FROM Reservation WHERE RoomNum = Room.RoomNum AND " +
                "CURRENT_DATE BETWEEN startDate AND endDate)"; //selects all rooms that are marked as available in the Room table and are not currently reserved for the current date

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Room room = new Room(
                        rs.getInt("RoomNum"),
                        rs.getInt("StreetNum"),
                        rs.getString("StreetName"),
                        rs.getString("PostalCode"),
                        rs.getDouble("Price"),
                        rs.getBoolean("TV"),
                        rs.getBoolean("AC"),
                        rs.getBoolean("Fridge"),
                        rs.getInt("Capacity"),
                        rs.getBoolean("IsExtendable"),
                        rs.getString("Defects"),
                        rs.getString("ViewDescription"),
                        rs.getBoolean("Available")
                );
                availableRooms.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return availableRooms;
    }






}
