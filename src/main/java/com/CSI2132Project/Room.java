package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
                "AND Reservation.startDate <= '2024-03-20' " +
                "AND Reservation.endDate >= '2024-03-15' " +
                "WHERE Reservation.RoomNum IS NULL " +
                "GROUP BY Room.RoomNum, Room.StreetNum, Room.StreetName, Room.PostalCode " +
                "HAVING COUNT(Reservation.RoomNum) = 0;";


        try {
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            // Setting the parameters for the PreparedStatement
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ps.setString(3, startDate);
            ps.setString(4, endDate);

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



}
