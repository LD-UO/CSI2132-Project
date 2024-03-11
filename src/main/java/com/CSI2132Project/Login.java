package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class Login {
    // Will be putting the login functionality here

    /*
    The functionality for this class will be kept relatively simple for the time being, will update if needed. For the time
    being it will just return a boolean value indicating if a matching username could be found in the table
     */
    public boolean usernameExists(String usernameToCheck) throws Exception{
        boolean result = false;
        Connection con = null;

        ConnectionDB db = new ConnectionDB();
        String searchStudentQuery = "SELECT COUNT(*) FROM Customers WHERE username = '" + usernameToCheck + "'";
        try {
            con = db.getConnection();
            PreparedStatement statement = con.prepareStatement(searchStudentQuery);

            ResultSet rs = statement.executeQuery();

            while (rs.next()){
                System.out.println(rs.getInt(1));
            }

            rs.close();
            statement.close();
            con.close();
            db.close();
        } catch (Exception e){
            throw new Exception(e.getMessage());
        }

        return result;
    }

}
