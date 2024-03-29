<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>

<html>
    <head>
        <title>Welcome!</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
        <%
        boolean reservationCreated = Boolean.parseBoolean(request.getParameter("reservationCreated"));
        boolean notFirstTime = Boolean.parseBoolean(request.getParameter("notFirstTime"));
        %>
        <!-- TODO: GET THE LOGOUT BUTTON WORKING! -->
        <h1>Logo will go here</h1>
        <h1 id="employee-landing-welcome">Welcome, <%= Session.currentSessionEmployee.getName() %></h1>

        <h2 id="employee-landing-slogan">What would you like to do today?</h2>
        <p id="success">Successfully checked in the customer!</p>
        <p id="failure">Failed to check in the customer, please try again!</p>
        <div id="options">
            <!-- Employee space -->
            <form id="view-assigned-reservations" action="viewreservations.jsp" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="View Assigned Reservations">
            </form>
            <form id="view-available-rooms" action="currentlyavailablerooms.jsp" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="View Currently Available Rooms">
            </form>
            <form id="checkout-customer" action="checkoutCustomer.jsp" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="Check out Customer">
            </form>
            <form id="delete-reservations" action="" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="Delete Reservations">
            </form>
            <!-- Hotel Instance Manager space -->
            <form id="manage-employees" action="" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="Employee Management">
            </form>
            <!-- TODO: Add some validation functionality to ensure that not all employees can access all of the sections-->
        </div>
        <script>
            if ( <%= reservationCreated %> ){
                document.getElementById("success").innerHTML = "Successfully checked in the customer!";
            } else {
                document.getElementById("success").style.display = "none";
            }

            if ( <%= !reservationCreated && notFirstTime %> ){
                document.getElementById("failure").innerHTML = "Failed to check in the customer, please try again!";
            } else {
                document.getElementById("failure").style.display = "none";
            }
        </script>
    </body>
</html>