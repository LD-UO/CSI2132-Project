package com.CSI2132Project;

// This class is used to keep track of the current session's room
public class Session {
    public static Room currentSessionRoom;
    public static void setRoom(Room room){
        currentSessionRoom = room;
    }
}
