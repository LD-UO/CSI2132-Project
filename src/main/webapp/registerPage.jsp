<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
    <head>
        <link rel="stylesheet" href="index.css">
        <title>Registration</title>
    </head>
    <body id="registration-page">
    <h1>Logo</h1>
        <%
            boolean registrationFailed = Boolean.parseBoolean(request.getParameter("registrationFailed"));
            boolean returnToBooking = Boolean.parseBoolean(request.getParameter("booking"));
        %>
        <div id="registration-section">
        <div id="registration-modal">
        <p>Welcome to the registration page, please enter the following information to create an account and begin booking your dream vacation! </p>
        <form action="registration-controller.jsp" method="POST">
            <label for="username">Username: </label>
            <br>
            <input type="text" name="username" required>
            <br>
            <label for="name">Full Name: </label>
            <br>
            <input type="text" name="name" required>
            <br>
            <!-- Could add some validation here to ensure the SIN complies by standards -->
            <label for="sin">SIN: </label>
            <br>
            <input type="text" name="sin" onkeypress="return isNumberKey(event)" required>
            <br>

            <!-- Making the address input a multi-valued attribute -->
            <label for="apt-number">Apartment Number: </label>
            <br>
            <input type="text" name="apt-number" onkeypress="return isNumberKey(event)">
            <br>
            <label for="street-number">Street Number: </label>
            <br>
            <input type="text" name="street-number" onkeypress="return isNumberKey(event)" required>
            <br>
            <label for="street-name">Street Name: </label>
            <br>
            <input type="text" name="street-name" required>
            <br>
            <label for="city-name">City: </label>
            <br>
            <input type="text" name="city-name" required>
            <br>
            <br>
            <input type="submit" id="submit-login" value="Register">
            <input type="hidden" id="booking" name="booking" value="<%= returnToBooking %>">
            <p id="registrationFailedMessage"></p>
        </form>
        </div>
        </div>
        <script>
            if ( <%= registrationFailed %>) {
                document.getElementById("registrationFailedMessage").innerHTML = "Registration failed, either a field was improperly inputted or there is already an account with that username, you can try logging in <a id='login_link' href='loginPage.jsp'>here</a>";
            } else {
                document.getElementById("registrationFailedMessage").innerHTML = "";
            }
        </script>
        <script src="index.js"></script>
    </body>
</html>