package com.CSI2132Project;

// This class is used to keep track of the current session's room
public class Session {
    public static Room currentSessionRoom;
    public static Employee currentSessionEmployee;
    public static String currentSessionStartDate;
    public static String currentSessionEndDate;
    public static void setRoom(Room room){
        currentSessionRoom = room;
    }
    public static void setCurrentSessionStartDate(String date) {currentSessionStartDate = date;}
    public static void setCurrentSessionEndDate(String date) {currentSessionEndDate = date;}

    public static void setCurrentSessionEmployee(Employee e){currentSessionEmployee = e;}
}
