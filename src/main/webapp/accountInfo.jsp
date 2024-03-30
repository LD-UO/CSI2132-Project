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
        <h1><a id="logo-link" href="index.jsp">Logo will go here<a></h1>
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

            <form action="update-account.jsp" method="POST">
                <label for="name">Update your name: </label><br>
                <input type="text" id="name" name="name"><br>
                <label for="address">Update your address: </label><br>
                <input type="text" id="address" name="address"><br>
                <input type="submit" id="submit" value="Update!" disabled>
            </form>

            <form action="delete-account.jsp" method="POST">
                <input type="submit" id="delete" value="Delete Account">
            </form>
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