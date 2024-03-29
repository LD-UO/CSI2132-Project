<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>

<html>
    <head>
        <title>Add Employee</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
        <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
        <form action="add-employee-controller.jsp" method="POST">
            <label for="employeeID">Employee ID: </label><br>
            <input type="text" name="employeeID" onkeypress="return isNumberKey(event)" required><br>
            <label for="name">Full Name: </label><br>
            <input type="text" name="name" required><br>
            <label for="number">Phone Number: </label><br>
            <input type="text" name="number" onkeypress="return isNumberKey(event)" minlength="10" maxlength="10" placeholder="1234567890" required><br>
            <label for="position">Position: </label><br>
            <input type="text" name="position" required><br>
            <label for="SIN">SIN: </label><br>
            <input type="text" name="SIN" onkeypress="return isNumberKey(event)" minlength="9", maxlength="9", placeholder="123456789" required><br>
            <input type="submit" id="add-employee-submit" value="Submit">
        </form>


    <script src="index.js"></script>
    <body>
</html>