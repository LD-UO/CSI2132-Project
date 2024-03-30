package com.CSI2132Project;

public class LoginCheck {
    private static boolean loggedin = false;
    private static String username = "";
    public static boolean getLoggedInStatus(){
        return loggedin;
    }

    public static void setLoggedinStatus(){
        loggedin = true;
    }

    public static String getUserName(){return username;}

    public static void setUserName(String entereduser) {username = entereduser;}

    public static void deleteAccount(){loggedin = false;}
}
