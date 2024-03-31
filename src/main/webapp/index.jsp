<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>


<html>
<head>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="index.css">
    <link rel="icon" type="image/x-icon" href="assets/logo.png">
    <title>Welcome to HotelExpress!</title>
</head>
<body onload="loadDates()">
    <%
        boolean loggedIn = LoginCheck.getLoggedInStatus();
    %>
    <div id="banner">
        <div id="logo-div">
            <h1>Logo will go here</h1>
        </div>
        <div id="employee-login-div">
            <form id="login-form-button-customer" action="loginPage.jsp?accountInfo=true" method="POST">
                <input type="hidden" id="hiddenUsername" name="username" value="">
                <input id="employee-login-button" type="submit" value="My Info">
            </form>
            <form id="login-form-button" action="employee-login.jsp" action="POST">
                <input id="employee-login-button" type="submit" value="Employee Login">
            </form>
        </div>
    </div>
    <div class="container-fluid" id="welcome-banner">
        <div id="welcome-message">
            <h3 id="slogan">Book stress free with</h3>
            <br>
            <h1 id="service-name">HotelExpress</h1>
        </div>
    </div>

    <!-- May need to add some more criteria here based on the assignment document -->

    <div id="datewrapper">
        <br>
        <br>
        <div id="dateinput">
            <div id="disclaimer">
                <p>We here at <strong>HotelExpress</strong> pride ourselves on our high quality reservation system that
                has provided millions of customers with accommodations for decades.
                But, no need to hear it from us, <strong>try it out for yourself below!</strong> </p>
            </div>
            <form id="search-form" action="availablerooms.jsp" method="POST">
                <div id="checkindiv">
                    <label for="checkin">Check-in Date: </label>
                    <br>
                    <input id="checkindateinput" name="checkin" type="date" required onchange="computeCheckout()">
                </div>
                <div id="checkoutdiv">
                    <label for="checkout">Check-out Date: </label>
                    <br>
                    <input id="checkoutdateinput" name="checkout" type="date" required>
                </div>
                <div id="locationdiv">
                    <label for="city">Location:</label>
                    <br>
                    <select name="city" required>
                        <option value="Toronto">Toronto</option>
                        <option value="New York">New York</option>
                        <option value="Vancouver">Vancouver</option>
                    </select>
                </div>
                <div id="submit-button-div">
                    <button id="submitbutton" type="submit">Check Availability!</button>
                </div>
            </form>
        </div>
        <br>
        <br>
    </div>

    <!-- Including the necessary Bootstrap javascript files -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="index.js"></script>
    <script>
        if (<%= loggedIn %>){
            document.getElementById("login-form-button-customer").action = "accountInfo.jsp";
            document.getElementById("hiddenUsername").value = "<%= LoginCheck.getUserName() %>";
        } else {

        }
    </script>
</body>
</html>
