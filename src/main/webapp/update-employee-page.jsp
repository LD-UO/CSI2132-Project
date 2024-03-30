<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Employee" %>

<html>
    <head>
        <title>Update Employee</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing" onload="employeeChange()">
        <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
        <p id="failure">Something went wrong, please try again</p>
        <%
            int employeeID = Integer.parseInt(request.getParameter("employeeID"));
            boolean failed = Boolean.parseBoolean(request.getParameter("failure"));
        %>
        <form action="update-employee-controller.jsp" method="POST">
            <label for="name">Updated employee name:</label><br>
            <input type="text" id="name" name="name"><br>
            <label for="phone">Updated phone number: </label><br>
            <input type="text" id="phone" name="phone" onkeypress="return isNumberKey(event)"><br>
            <label for="position">Updated position: </label><br>
            <input type="text" id="position" name="position"><br>
            <input type="submit" id="submit" value="Update" disabled>
            <input type="hidden" name="employeeID" value="<%= employeeID %>">
        </form>

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
