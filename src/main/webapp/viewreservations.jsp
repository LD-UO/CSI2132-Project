<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="com.CSI2132Project.Reservation" %>
<%@ page import="java.util.List" %>

<html>
    <head>
        <title>View My Reservations</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
        <h1>Logo will go here</h1>
        <h1>Here are your assigned reservations</h1>
        <div id="list-of-assigned-reservations">
            <%
                Employee e = Session.currentSessionEmployee;
                List<Reservation> results = e.viewMyReservations(e.getEmployeeId());

                for (Reservation r: results){ %>
                    <div id="reservation-e-view">
                        <table id="reservation-table">
                            <tr>
                                <td>
                                    <p><%= r.getRoomNum() %></p>
                                </td>
                                <td>
                                    <p><%= r.getUsername() %></p>
                                </td>
                                <td>
                                    <p><%= r.getStartDate() %></p>
                                </td>
                                <td>
                                    <p><%= r.getEndDate() %></p>
                                </td>
                                <td>
                                    <!-- Will need to turn this into a button which when clicked will run the query to change the room availability to false and status of the reservation to be renting (i.e. should not show up on the employee page anymore! -->
                                    <p>Convert to Renting</p>
                                </td>
                            </tr>
                        </table>
                    </div>
                 <%}
            %>
        </div>
    <body>
</html>

