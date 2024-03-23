<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>
<%@ page import="com.CSI2132Project.UserManagement" %>

<html>
    <head>
    </head>
    <body>
        <%
            boolean loginFailed = Boolean.parseBoolean(request.getParameter("loginFailed"));
        %>
        <p>You have not logged in! Please log in below!</p>
        <form action="login-controller.jsp" method="POST">
            <input type="text" id="username" name="username" required>
            <p id="loginFailedMessage"></p>
            <input type="submit" value="Log in">
        </form>
        <p>Do not have an account? Click <a href="registerPage.jsp">here</a> to register</p>

        <script>
            if ( <%= loginFailed %>) {
                document.getElementById("loginFailedMessage").innerHTML = "We could not find the username you entered, you may have made an error or you do not have an account. The link to register can be found below:";
            } else {
                document.getElementById("loginFailedMessage").innerHTML = "";
            }
        </script>
    </body>
</html>