<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="com.CSI2132Project.Reservation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
    <head>
        <title>Delete Reservation</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
        <h1>Logo will go here</h1>
        <p id="failure">Something went wrong, please try again!</p>
        <%
            Employee e = Session.currentSessionEmployee;
            List<Reservation> upcomingReservations = Reservation.getUpcomingReservations();
            List<Reservation> relevantReservations = new ArrayList<Reservation>();
            boolean failure = Boolean.parseBoolean(request.getParameter("failed"));

            for (Reservation r : upcomingReservations){
                if (r.getStreetNum() == e.getStreetNum() && r.getStreetName().equals(e.getStreetName()) && r.getPostalCode().equals(e.getPostalCode())) {
                    relevantReservations.add(r);
                }
            }

            %>
            <div id="reservation-e-view">
            <table id="reservation-table">
            <tr>
                <th>Assigned Employee</th>
                <th>Room Number</th>
                <th>Customer Username</th>
                <th>Start Date</th>
                <th>End Date</th>
            </tr>
            <%
                for (Reservation r : relevantReservations){
            %>
            <tr>
                <td><%= r.getEmployeeId() %></td>
                <td><%= r.getRoomNum() %></td>
                <td><%= r.getUsername() %></td>
                <td><%= r.getStartDate() %></td>
                <td><%= r.getEndDate() %></td>
                <td>
                    <form action="delete-reservation-controller.jsp" method="POST">
                        <input type="hidden" name="roomnum" value="<%= r.getRoomNum() %>">
                        <input type="hidden" name="streetnum" value="<%= r.getStreetNum() %>">
                        <input type="hidden" name="streetname" value="<%= r.getStreetName() %>">
                        <input type="hidden" name="postalCode" value="<%= r.getPostalCode() %>">
                        <input type="hidden" name="startDate" value="<%= r.getStartDate() %>">
                        <input type="submit" id="delete-reservation-button" value="X">
                    </form>
                </td>
            </tr>


        <%    }
        %>
        </table>
        </div>
        <script>
            if ( <%= failure %> ) {
                document.getElementById("failure").innerHTML = "Something went wrong, please try again!";
            } else {
                document.getElementById("failure").style.display = "none";
            }
        </script>
    </body>
</html>