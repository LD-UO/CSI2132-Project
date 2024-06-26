package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.sql.Date;
import java.util.Map;

import static java.util.Map.entry;

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

    private String area;

    public static Map<Integer, String> areaNumberToCity = Map.ofEntries(
            entry(100, "Toronto"),
            entry(150, "New York"),
            entry(200, "Vancouver")
    );

    public static Map<String, Integer> areaCityToNumber = Map.ofEntries(
        entry("Toronto", 100),
        entry("New York", 150),
        entry("Vancouver", 200)
    );

    public Room(){
        // Creating an empty constructor so I can create a Room instance to access the findAvailableRooms method
    }

    // Creating a separate constructor for employee functionality
    public Room(int roomNum, int streetNum, String streetname, String postalCode){
        this.roomNum = roomNum;
        this.streetNum = streetNum;
        this.streetName = streetname;
        this.postalCode = postalCode;
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
     * @param area
     */


    public Room(int roomNum, int streetNum, String streetName, String postalCode, double price, boolean tv, boolean ac, boolean fridge, int capacity, boolean isExtendable, String defects, String viewDescription, boolean available, String area) {
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
        this.area = area;
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

    public String getArea() {return area;}
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

    public void setArea(String area) {this.area = area; }
    /**
     * Finds and returns a list of available rooms for a given date range.
     *
     * @param startDate The start date of the desired reservation period (format: YYYY-MM-DD).
     * @param endDate The end date of the desired reservation period (format: YYYY-MM-DD).
     * @return A list of available rooms.
     */
    public static List<Room> findAvailableRooms(String startDate, String endDate, String area) throws Exception {

        List<Room> availableRooms = new ArrayList<>();
        ConnectionDB db = new ConnectionDB();
        String sql = "SELECT Room.* " +
                "FROM Room " +
                "LEFT JOIN Reservation ON Room.RoomNum = Reservation.RoomNum " +
                "AND Reservation.startDate <= ? " +
                "AND Reservation.endDate >= ? " +
                "WHERE Reservation.RoomNum IS NULL AND Room.area = ? AND Room.available = true " +
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
            ps.setInt(3, areaCityToNumber.get(area));

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
                            rs.getBoolean("Available"),
                            rs.getString("Area")
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
        String sql = "SELECT * " +
                "FROM Room " +
                "WHERE Available = TRUE " +
                "AND NOT EXISTS ( " +
                "    SELECT 1 " +
                "    FROM Reservation " +
                "    WHERE RoomNum = Room.RoomNum " +
                "    AND CURRENT_DATE BETWEEN startDate AND endDate " +
                ") " +
                "ORDER BY RoomNum;";//selects all rooms that are marked as available in the Room table and are not currently reserved for the current date and orders by roomnum

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
                        rs.getBoolean("Available"),
                        rs.getString("Area")
                );
                availableRooms.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return availableRooms;
    }

    public static boolean checkIn(Room room) {
        // SQL query to update the 'Available' column for a specific room
        String sql = "UPDATE room SET available = FALSE WHERE roomnum = ? AND streetnum = ? AND streetname = ? AND postalcode = ?";
        boolean success = false;

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            // Setting parameters for the PreparedStatement
            pstmt.setInt(1, room.getRoomNum());
            pstmt.setInt(2, room.getStreetNum());
            pstmt.setString(3, room.getStreetName());
            pstmt.setString(4, room.getPostalCode());

            // Execute the update
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Room checked in");
                success = true;
            } else {
                System.err.println("Cannot check into room.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }

    public static List<Reservation> getCustomerReservations(String username){
        ConnectionDB db = new ConnectionDB();
        Connection con = null;
        List<Reservation> customerReservations = new ArrayList<Reservation>();
        String sql = "SELECT * FROM reservation WHERE reservation.username = ?";

        try {
            con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            while (rs.next()){
                Reservation r = new Reservation(rs.getInt("employee_id"), rs.getInt("roomnum"),  rs.getString("username"), rs.getString("startdate"),  rs.getString("enddate"), rs.getInt("streetnum"), rs.getString("streetname"), rs.getString("postalcode"));
                customerReservations.add(r);
            }
        } catch(Exception e){
            e.printStackTrace();
        }


        return customerReservations;
    }

    public static void updateRoomAvailability(int roomNum, int streetNum, String streetName, String postalCode){
        ConnectionDB db = new ConnectionDB();
        Connection con = null;
        String sql = "UPDATE room set available = true where roomnum = ? AND streetnum = ? AND streetname = ? AND postalcode = ?";
       //  System.out.println(roomNum + " " + streetNum + " " + streetName + " " + postalCode);
        try {
            con = db.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, roomNum);
            ps.setInt(2, streetNum);
            ps.setString(3, streetName);
            ps.setString(4, postalCode);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0){
                System.out.println("Successfully set the customer's rooms to be available");
            } else {
                System.err.println("Something went wrong!");
            }

        } catch (Exception e){
            e.printStackTrace();
        }

    }
    public static boolean checkOut(Room room) {
        ConnectionDB db = new ConnectionDB();
        Connection con = null;
        boolean deleteResult = false;
        boolean updateResult = false;

        try {
            con = db.getConnection();
            // Start transaction
            con.setAutoCommit(false);

            // First, delete the reservations for the room
            String deleteReservationsSql = "DELETE FROM Reservation WHERE RoomNum = ? AND StreetNum = ? AND StreetName = ? AND PostalCode = ?";
            try (PreparedStatement deleteStmt = con.prepareStatement(deleteReservationsSql)) {
                deleteStmt.setInt(1, room.getRoomNum());
                deleteStmt.setInt(2, room.getStreetNum());
                deleteStmt.setString(3, room.getStreetName());
                deleteStmt.setString(4, room.getPostalCode());

                int deletedRows = deleteStmt.executeUpdate();
                System.out.println(deletedRows + " reservation(s) deleted.");
                deleteResult = true;
            }

            // Next, update the room's availability
            String updateRoomSql = "UPDATE Room SET Available = TRUE WHERE RoomNum = ? AND StreetNum = ? AND StreetName = ? AND PostalCode = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateRoomSql)) {
                updateStmt.setInt(1, room.getRoomNum());
                updateStmt.setInt(2, room.getStreetNum());
                updateStmt.setString(3, room.getStreetName());
                updateStmt.setString(4, room.getPostalCode());

                int rowsAffected = updateStmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Room checkout successful.");
                    updateResult = true;
                } else {
                    System.out.println("Room checkout not successful.");
                }
            }

            // Commit transaction
            con.commit();
        } catch (Exception e) {
            try {
                if (con != null) {
                    con.rollback(); // Rollback transaction in case of error
                }
            } catch (Exception rollbackEx) {
                System.err.println("Rollback failed: " + rollbackEx.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true); // Reset auto-commit to true
                    con.close();
                } catch (Exception closeEx) {
                    System.err.println("Failed to close connection: " + closeEx.getMessage());
                }
            }
        }

        return deleteResult && updateResult;
    }


    public static boolean addRoom(Room room) {
        String sql = "INSERT INTO Room (RoomNum, StreetNum, StreetName, PostalCode, Price, TV, AC, Fridge, Capacity, IsExtendable, Defects, ViewDescription, Available, Area) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        boolean result = false;

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, room.getRoomNum());
            pstmt.setInt(2, room.getStreetNum());
            pstmt.setString(3, room.getStreetName());
            pstmt.setString(4, room.getPostalCode());
            pstmt.setDouble(5, room.getPrice());
            pstmt.setBoolean(6, room.isTv());
            pstmt.setBoolean(7, room.isAc());
            pstmt.setBoolean(8, room.isFridge());
            pstmt.setInt(9, room.getCapacity());
            pstmt.setBoolean(10, room.isExtendable());
            pstmt.setString(11, room.getDefects());
            pstmt.setString(12, room.getViewDescription());
            pstmt.setBoolean(13, room.isAvailable());
            pstmt.setInt(14, areaCityToNumber.get(room.getArea()));

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Room added successfully.");
                result = true;
            } else {
                System.err.println("Failed to add room.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }


    public static boolean deleteRoom(Room room) {
        String sql = "DELETE FROM Room WHERE RoomNum = ? AND StreetNum = ? AND StreetName = ? AND PostalCode = ?;";
        boolean result = false;
        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            // Setting parameters for the PreparedStatement from the Room object
            pstmt.setInt(1, room.getRoomNum());
            pstmt.setInt(2, room.getStreetNum());
            pstmt.setString(3, room.getStreetName());
            pstmt.setString(4, room.getPostalCode());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Room deleted successfully.");
                result = true;
            } else {
                System.err.println("Failed to delete room. Room may not exist.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static boolean updateRoom(int roomNum, int streetNum, String streetName, String postalCode, double price, boolean tv, boolean ac, boolean fridge, int capacity, boolean isExtendable, String defects, String viewDescription){
        boolean result = false;
        ConnectionDB db = new ConnectionDB();

        String sql = "UPDATE room SET price = ?, tv = ?, ac = ?, fridge = ?, capacity = ?, isextendable = ?, defects = ?, viewdescription = ? WHERE roomnum = ? AND streetnum = ? AND streetname = ? AND postalcode = ?";
        try (Connection con = db.getConnection(); PreparedStatement statement = con.prepareStatement(sql)){
            statement.setDouble(1, price);
            statement.setBoolean(2, tv);
            statement.setBoolean(3, ac);
            statement.setBoolean(4, fridge);
            statement.setInt(5, capacity);
            statement.setBoolean(6, isExtendable);
            statement.setString(7, defects);
            statement.setString(8, viewDescription);
            statement.setInt(9, roomNum);
            statement.setInt(10, streetNum);
            statement.setString(11, streetName);
            statement.setString(12, postalCode);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0){
                result = true;
            } else {
                System.err.println("Something went wrong");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
    /**
     * Retrieves all rooms for a specific hotel instance based on address.
     * @param streetNum The street number of the hotel.
     * @param streetName The street name of the hotel.
     * @param postalCode The postal code of the hotel.
     * @return A list of Room objects for the specified hotel instance.
     * @throws Exception If there is an issue accessing the database.
     */
    public static List<Room> getAllRoomsInHotel(int streetNum, String streetName, String postalCode) {
        List<Room> rooms = new ArrayList<>();
        ConnectionDB db = new ConnectionDB();

        String sql = "SELECT * FROM Room WHERE StreetNum = ? AND StreetName = ? AND PostalCode = ? ORDER BY RoomNum;";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, streetNum);
            ps.setString(2, streetName);
            ps.setString(3, postalCode);

            ResultSet rs = ps.executeQuery();
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
                        rs.getBoolean("Available"),
                        rs.getString("Area")
                );
                rooms.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public static String getAreaGivenAddress(int streetNum, String streetName, String postalCode){
        ConnectionDB db = new ConnectionDB();
        String sql = "SELECT area FROM room WHERE streetnum = ? and streetname = ? and postalcode = ?";
        int resultantArea = 0;

        try (Connection con = db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, streetNum);
            ps.setString(2, streetName);
            ps.setString(3, postalCode);

            ResultSet rs = ps.executeQuery();

            while (rs.next()){
                resultantArea = rs.getInt("area");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return areaNumberToCity.get(resultantArea);
    }

    public static int getRoomsByArea(String area){
        ConnectionDB db = new ConnectionDB();
        int areaNumber = areaCityToNumber.get(area);
        int numberOfRooms = 0;

        String sql = "SELECT number_of_avalable_rooms from rooms_by_area where area = ?";

        try (Connection con = db.getConnection(); PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1, areaNumber);

            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                numberOfRooms = rs.getInt("number_of_avalable_rooms");
            }
        } catch (Exception e){
            e.printStackTrace();
        }

        return numberOfRooms;
    }


}
