<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
    <head>
        <title>Employee Login</title>
        <link rel="stylesheet" href="index.css">
    </head>
    <body id="employee-login-page">
        <%
            boolean loginFailed = Boolean.parseBoolean(request.getParameter("loginFailed"));
        %>
        <h1>Logo will go here</h1>
        <div id="login-form">
            <form action="employee-login-controller.jsp" method="POST">
                <label id="login-declaration" for="employee-id">Please enter your Employee ID: </label><br>
                <br>
                <input type="text" id="employee-id" name="employee-id" required><br>
                <br>
                <p id="loginFailedMessage">Entered Employee ID could not be found, please try again! You can contact your hotel manager to receive your Employee ID if forgotten</p>
                <input id="employee-login-button-2" type="submit" value="Login">
            </form>
        </div>
        <script>
            if ( <%= loginFailed %> ){
                document.getElementById("loginFailedMessage").innerHTML = "Entered Employee ID could not be found, please try again! You can contact your hotel manager to receive your Employee ID if forgotten";
            } else {
                document.getElementById("loginFailedMessage").innerHTML = "";
            }
        </script>
    </body>
</html>