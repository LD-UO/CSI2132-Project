package com.CSI2132Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class Login extends UserManagement{


    public Employee employeeLogin (int employeeId){
        String sql = "SELECT * FROM Employee WHERE employee_id = ?";

        try (Connection con = new ConnectionDB().getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, employeeId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Assuming the Employee table contains columns as specified in your SQL schema
                int id = rs.getInt("employee_id");
                String streetName = rs.getString("StreetName");
                int streetNum = rs.getInt("StreetNum");
                String postalCode = rs.getString("PostalCode");
                String name = rs.getString("Name");
                String phone = rs.getString("Phone");
                String position = rs.getString("Position");
                String SIN = rs.getString("SIN");


                return new Employee(id, streetName, streetNum, postalCode, name, phone, position, SIN);

            } else {
                return null; //no employee found
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    }



