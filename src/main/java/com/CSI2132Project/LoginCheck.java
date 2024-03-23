package com.CSI2132Project;

public class LoginCheck {
    private static boolean loggedin = false;
    public static boolean getLoggedInStatus(){
        return loggedin;
    }

    public static void setLoggedinStatus(){
        loggedin = true;
    }
}
