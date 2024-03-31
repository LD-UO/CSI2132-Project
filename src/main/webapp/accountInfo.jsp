<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>
<%@ page import="com.CSI2132Project.Customer" %>

<%
    String username = LoginCheck.getUserName();
    String usernameLoggedIn = "";
    boolean failure = Boolean.parseBoolean(request.getParameter("failure"));
%>

<html>
    <head>
        <title>Account Summary</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing" onload="nameChange()">
        <div id="employee-banner">
            <div id="employee-logo">
                <a href="index.jsp"><img src="assets/logo.png" id="website-logo"></a>
            </div>
        </div>
        <br>
        <p id="failure">Something went wrong, please try again!</p>
        <%
            String loggedInUsername = request.getParameter("username");

            if (loggedInUsername == null){
                usernameLoggedIn = username;
            } else {
                usernameLoggedIn = loggedInUsername;
            }

            Customer c = Customer.getCustomer(usernameLoggedIn);
        %>

        <div id="account-info-wrapper">
            <h1>Welcome <%= c.getName() %>!</h1>
            <p>Here you can edit your account settings and even delete your account if you so wish. Click on a field to begin editing</p>
            <div id="add-employee-form">
            <br>
            <br>
                <form action="update-account.jsp" method="POST">
                    <label for="name">Update your name: </label><br>
                    <input type="text" id="name" name="name"><br>
                    <br>
                    <label for="address">Update your address: </label><br>
                    <br>
                    <input type="text" id="address" name="address"><br>
                    <br>
                    <input type="submit" id="add-employee-submit" value="Update!" disabled>
                    <br><br><br>
                </form>

                <form action="delete-account.jsp" method="POST">
                    <input type="hidden" name="username" value="<%= c.getUsername() %>">
                    <input type="hidden" name="name" value="<%= c.getName() %>">
                    <input type="hidden" name="SIN" value="<%= c.getSIN() %>">
                    <input type="hidden" name="address" value="<%= c.getAddress() %>">
                    <input type="submit" id="delete-account-button" value="Delete Account">
                </form>
                <br><br>
            </div>
            <script src="index.js"></script>
            <script>
            if ( <%= failure %> ){
                document.getElementById("failure").innerHTML = "Something went wrong, please try again!";
            } else {
                document.getElementById("failure").style.display = "none";
            }
            </script>
        </div>
    </body>
</html>