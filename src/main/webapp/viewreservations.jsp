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
        <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
        <h1>Here are your active, assigned reservations</h1>
        <p id="success">Successfully checked in the customer!</p>
        <p id="failure">Failed to check in the customer, please try again!</p>
        <div id="list-of-assigned-reservations">
            <%
                Employee e = Session.currentSessionEmployee;
                List<Reservation> results = e.viewMyReservations(e.getEmployeeId());
                boolean success = Boolean.parseBoolean(request.getParameter("success"));
                boolean failure = Boolean.parseBoolean(request.getParameter("failure"));
                // Need to have some functionality for if the reservations list is empty TODO:

                for (Reservation r: results){ %>
                    <div id="reservation-e-view">
                        <table id="reservation-table">
                            <tr>
                                <th>Room: </th>
                                <th>Username: </th>
                                <th>Reservation Start Date: </th>
                                <th>Reservation End Date: </th>
                            </tr>
                            <tr>
                                <td>
                                    <p><%= r.getStreetNum() + " " + r.getStreetName() + " - " + r.getRoomNum() %></p>
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
                                    <form action="checkin-controller.jsp" method="POST">
                                        <input type="submit" onclick="verifyDates()" id="checkin-button" value="Check In">
                                        <input type="hidden" id="checkin-startdate" name="checkin-startdate" value=<%= r.getStartDate() %>>
                                        <input type="hidden" id="checkin-roomnumber" name="checkin-roomnumber" value=<%= r.getRoomNum() %>>
                                        <input type="hidden" id="checkin-streetnumber" name="checkin-streetnumber" value=<%= r.getStreetNum() %>>
                                        <input type="hidden" id="checkin-streetname" name="checkin-streetname" value='<%= r.getStreetName() %>'>
                                        <input type="hidden" id="checkin-postalcode" name="checkin-postalcode" value=<%= r.getPostalCode() %>>
                                    </form>
                                </td>
                            </tr>
                        </table>
                    </div>
                 <%}
            %>
        </div>
        <script>
            if ( <%= success %> ){
                document.getElementById("success").innerHTML = "Successfully checked in the customer!";
            } else {
                document.getElementById("success").style.display = "none";
            }

            if ( <%= failure %> ){
                document.getElementById("failure").innerHTML = "Failed to check in the customer, please try again!";
            } else {
                document.getElementById("failure").style.display = "none";
            }
        </script>
        <script src="index.js"></script>
    <body>
</html>

