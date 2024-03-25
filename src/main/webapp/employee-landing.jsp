<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>

<html>
    <head>
        <title>Welcome!</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
        <!-- TODO: GET THE LOGOUT BUTTON WORKING! -->
        <h1>Logo will go here</h1>
        <h1 id="employee-landing-welcome">Welcome, <%= Session.currentSessionEmployee.getName() %></h1>

        <h2 id="employee-landing-slogan">What would you like to do today?</h2>

        <div id="options">
            <!-- Employee space -->
            <form id="view-assigned-reservations" action="viewreservations.jsp" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="View Assigned Reservations">
            </form>
            <form id="view-available-rooms" action="" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="View Currently Available Rooms">
            </form>
            <form id="delete-reservations" action="" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="Delete Reservations">
            </form>
            <!-- Hotel Instance Manager space -->
            <form id="manage-employees" action="" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="Employee Management">
            </form>
            <form id="manage-hotels" action="" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="Manage Hotel">
            </form>
            <!-- Hotel Chain Manager space -->
            <form id="manage-franchise" action="" method="POST">
                <input type="submit" id="view-assigned-reservations-button" value="Franchise Management">
            </form>
            <!-- TODO: Add some validation functionality to ensure that not all employees can access all of the sections-->
        </div>
    </body>
</html>