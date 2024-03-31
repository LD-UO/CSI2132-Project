<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
    <head>
        <title>Employee Login</title>
        <link rel="stylesheet" href="index.css">
        <link rel="icon" type="image/x-icon" href="assets/logo.png">
    </head>
    <body id="employee-login-page">
        <%
            boolean loginFailed = Boolean.parseBoolean(request.getParameter("loginFailed"));
        %>
        <div id="employee-banner">
            <div id="employee-logo">
                <a href="index.jsp"><img src="assets/logo.png" id="website-logo"></a>
            </div>
        </div>
        <div id="login-form">
            <form action="employee-login-controller.jsp" method="POST">
                <label id="login-declaration" for="employee-id">Please enter your Employee ID: </label><br>
                <br>
                <input type="text" id="employee-id" name="employee-id" required  onkeypress="return isNumberKey(event)"><br>
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
        <script src="index.js"></script>
    </body>
</html>