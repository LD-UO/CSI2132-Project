<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Employee" %>

<html>
    <head>
        <title>Update Employee</title>
        <link href="index.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assets/logo.png">
    </head>
    <body id="employee-landing" onload="employeeChange()">
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

        <p id="failure">Something went wrong, please try again</p>
        <h1>Here you can update employee information! </h1>
        <%
            int employeeID = Integer.parseInt(request.getParameter("employeeID"));
            boolean failed = Boolean.parseBoolean(request.getParameter("failure"));
        %>
        <div id="add-employee-form">
            <form action="update-employee-controller.jsp" method="POST">
                <br>
                <br>
                <label for="name">Updated employee name:</label><br>
                <input type="text" id="name" name="name"><br>
                <br>
                <label for="phone">Updated phone number: </label><br>
                <input type="text" id="phone" name="phone" onkeypress="return isNumberKey(event)" min="10" max="10"><br>
                <br>
                <label for="position">Updated position: </label><br>
                <input type="text" id="position" name="position"><br>
                <br>
                <input id="add-employee-submit" type="submit" id="submit" value="Update" disabled>
                <br>
                <br>
                <br>
                <input type="hidden" name="employeeID" value="<%= employeeID %>">
            </form>
        </div>

        <script src="index.js"></script>
        <script>
            if ( <%= failed %> ){
                document.getElementById("failure").innerHTML = "Something went wrong, please try again!";
            } else {
                document.getElementById("failure").style.display = "none";
            }
        </script>
    </body>
</html>
