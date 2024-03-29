<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>
<%@ page import="com.CSI2132Project.UserManagement" %>

<html>
    <head>
        <link rel="stylesheet" href="index.css">
        <title>Login</title>
    </head>
    <body id="test">
        <%
            boolean loginFailed = Boolean.parseBoolean(request.getParameter("loginFailed"));
        %>
        <h1>Logo</h1>
        <div id="login-section">
            <div id="login-modal">
                <p id="login-declaration">You have not logged in, please log in below!</p>
                <form action="login-controller.jsp" method="POST">
                    <label for="username">Username: </label>
                    <input type="text" id="username" name="username" required>

                    <br>
                    <br>
                    <p id="loginFailedMessage"></p>
                    <input type="submit" id="submit-login" value="Log in">
                </form>
                <p>Do not have an account? Click <a id="register_link" href="registerPage.jsp"><strong>here</strong></a> to register</p>
            </div>
        </div>
        <script>
            if ( <%= loginFailed %>) {
                document.getElementById("loginFailedMessage").innerHTML = "We could not find the username you entered, you may have made an error or you do not have an account. The link to register can be found below";
            } else {
                document.getElementById("loginFailedMessage").innerHTML = "";
            }
        </script>
    </body>
</html>