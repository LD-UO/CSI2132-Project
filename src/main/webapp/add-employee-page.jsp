<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>

<html>
    <head>
        <title>Add Employee</title>
        <link href="index.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assets/logo.png">
    </head>
    <body id="employee-landing">
        <div id="employee-banner">
            <div id="employee-logo">
                <a href="employee-landing.jsp"><img src="assets/logo.png" id="website-logo"></a>
            </div>
            <div id="employee-logout">
                <p><a id="logo-link" href="index.jsp">Logout</a></p>
            </div>
        </div>
        <br>
        <br>
        <div id="add-employee-form">
            <form action="add-employee-controller.jsp" method="POST">
                <br>
                <br>
                <label for="employeeID">Employee ID: </label><br>
                <input id="employee-text-input" type="text" name="employeeID" onkeypress="return isNumberKey(event)" required><br>
                <br>
                <label for="name">Full Name: </label><br>
                <input id="employee-text-input" type="text" name="name" required><br>
                <br>
                <label for="number">Phone Number: </label><br>
                <input id="employee-text-input" type="text" name="number" onkeypress="return isNumberKey(event)" minlength="10" maxlength="10" placeholder="1234567890" required><br>
                <br>
                <label for="position">Position: </label><br>
                <input id="employee-text-input" type="text" name="position" required><br>
                <br>
                <label for="SIN">SIN: </label><br>
                <input id="employee-text-input" type="text" name="SIN" onkeypress="return isNumberKey(event)" minlength="9", maxlength="9", placeholder="123456789" required><br>
                <br>
                <input type="submit" id="add-employee-submit" value="Submit">
                <br>
                <br>
                <br>
            </form>
        </div>

    <script src="index.js"></script>
    <body>
</html>