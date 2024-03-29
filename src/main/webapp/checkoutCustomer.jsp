<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Reservation" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Checkout Customer</title>
    <link href="index.css" rel="stylesheet">
</head>
<body id="employee-landing">
    <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
    <p id="failure">Something went wrong, please try again!</p>
    <p id="success">Checked out successfully!</p>

    <%
        // Will have to get a list of all of the reservations made
        Employee e = Session.currentSessionEmployee;
        List<Reservation> assignedReservations = e.viewAllReservations(e.getEmployeeId());
        boolean notFirstTime = Boolean.parseBoolean(request.getParameter("notFirstTime"));
        boolean failedCheckOut = Boolean.parseBoolean(request.getParameter("failedCheckOut"));

        boolean combinedResult = notFirstTime && !failedCheckOut;

        %>
        <h1>Here you can view which customers need to be checked out</h1>
        <div id="reservation-e-view">
        <table id="reservation-table">
        <tr>
            <th>Room Number</th>
            <th>Customer Username</th>
            <th>Start Date</th>
            <th>End Date</th>
        </tr>
        <%
        for (Reservation r : assignedReservations){
            %>
            <tr>
                <td><%= r.getRoomNum() %></td>
                <td><%= r.getUsername() %></td>
                <td><%= r.getStartDate() %></td>
                <td><%= r.getEndDate() %> </td>
                <td>
                <form action="checkout-controller.jsp" method="POST">
                    <input type="hidden" name="roomNum" value="<%= r.getRoomNum() %>">
                    <input type="hidden" name="streetNum" value="<%= r.getStreetNum() %>">
                    <input type="hidden" name="streetName" value="<%= r.getStreetName() %>">
                    <input type="hidden" name="postalCode" value="<%= r.getPostalCode() %>">
                    <input id="checkout-button" type="submit" value="Check Out">
                </form>
                </td>
            </tr>
        <%}
    %>
    </table>
    </div>

    <script>
        if ( <%= notFirstTime && failedCheckOut %> ){
            document.getElementById("failure").innerHTML = "Something went wrong, please try again!";
        } else {
            document.getElementById("failure").style.display = "none";
        }

        if ( <%= combinedResult %> ){
            document.getElementById("success").innerHTML = "Checked out successfully!";
        } else {
            document.getElementById("success").style.display = "none";
        }
    </script>
</body>
</html>
