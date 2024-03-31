<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<html>
    <head>
        <title>Add Room</title>
        <link href="index.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assets/logo.png">
    </head>
    <body id="employee-landing">
        <div id="employee-banner">
            <div id="employee-logo">
                <a href="employee-landing.jsp"><img src="assets/logo.png" id="website-logo"></a>
            </div>
            <div id="employee-logout">
                <p><a id="logo-link" href="index.jsp">Logout</a></p>
            </div>
        </div>
        <br>
        <h1>Here you can add a new room! </h1>
        <div id="add-employee-form">
        <form action="add-room-controller.jsp" method="POST">
        <br>
        <br>
            <label for="roomNum">Room Number: </label><br>
            <input id="room-input-roomNum" type="text" name="roomNum" onkeypress="return isNumberKey(event)" required><br>
            <br>
            <label for="price">Price: </label><br>
            <input id="room-input-price" type="text" name="price" onkeypress="return isNumberKey(event)" required><br>
            <br>
            <p>Does the room have a TV?</p>
            <input type="radio" id="yestv" name="tv" value="true" required>
            <label for="yestv">Yes</label><br>
            <input type="radio" id="notv" name="tv" value="false">
            <label for="notv">No</label><br>
            <br>
            <p>Does the room have an AC?</p>
            <input type="radio" id="yesac" name="ac" value="true" required>
            <label for="yesac">Yes</label><br>
            <input type="radio" id="noac" name="ac" value="false">
            <label for="noac">No</label><br>
            <br>
            <p>Does the room have a fridge?</p>
            <input type="radio" id="yesfridge" name="fridge" value="true" required>
            <label for="yesfridge">Yes</label><br>
            <input type="radio" id="nofridge" name="fridge" value="false">
            <label for="nofridge">No</label><br>
            <br>
            <label for="capacity">Please enter the capacity of the room</label><br>
            <input type="number" min=1 max = 5 name="capacity" id="capacity" required><br>

            <br>
            <p>Is the room extendable?</p>
            <input type="radio" id="yesextend" name="extend" value="true" required>
            <label for="yesextend">Yes</label><br>
            <input type="radio" id="noextend" name="extend" value="false">
            <label for="noexted">No</label><br>

            <br>
            <label for="defects">Please enter any defects: </label><br>
            <input type="text" id="room-input-defects" name="defects" value="None" required><br>

            <br>
            <label for="view">Please enter the view description: </label><br>
            <input type="text" id="room-input-view" name="view" required><br>
            <br>

            <input type="submit" id="add-employee-submit" value="Submit">
            <br>
            <br>
        </form>
        </div>


    <script src="index.js"></script>
    <body>
</html>