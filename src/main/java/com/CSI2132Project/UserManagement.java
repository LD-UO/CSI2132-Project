package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public abstract class UserManagement {
    /*
    Method used in both classes that deal with user's, login and registration.
     */

    /**
     *
     * @param usernameToCheck
     * @return result
     * @throws Exception
     */
    public boolean usernameExists(String usernameToCheck) throws Exception{
        boolean result = false;
        Connection con = null;

        // Object that will create connection with the database
        ConnectionDB db = new ConnectionDB();
        // Running the query to get the number of results returned from the Customers table
        // The rationale behind this was because each username has to be unique, the number of
        // rows returned should just be 1
        String searchStudentQuery = "SELECT COUNT(*) FROM Customers WHERE username = '" + usernameToCheck + "'";
        try {
            // Creating the connection and then preparing the query to be run
            con = db.getConnection();
            PreparedStatement statement = con.prepareStatement(searchStudentQuery);

            // Getting the resultant set of rows returned by the query
            ResultSet rs = statement.executeQuery();


            // Iterating over the results while it still has some values, and if it does this means that the
            // user does in fact exist in the system already and can log in successfully
            while (rs.next()){
                System.out.println(rs.getInt(1));
                result = true;
            }

            // Closing all of the connections associated with the database to ensure no memory leaks
            rs.close();
            statement.close();
            con.close();
            db.close();

            // Exception handling
        } catch (Exception e){
            throw new Exception(e.getMessage());
        }

        // Returning the value of result, true if user can be found, false if the user could not be found
        return result;
    }
}
