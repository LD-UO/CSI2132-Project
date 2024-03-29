<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<html>
    <head>
        <title>Add Room</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
        <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
        <form action="add-room-controller.jsp" method="POST">
            <label for="roomNum">Room Number: </label><br>
            <input type="text" name="roomNum" onkeypress="return isNumberKey(event)" required><br>

            <label for="price">Price: </label><br>
            <input type="text" name="price" onkeypress="return isNumberKey(event)" required><br>

            <p>Does the room have a TV?</p>
            <input type="radio" id="yestv" name="tv" value="true" required>
            <label for="yestv">Yes</label><br>
            <input type="radio" id="notv" name="tv" value="false">
            <label for="notv">No</label><br>

            <p>Does the room have an AC?</p>
            <input type="radio" id="yestac" name="ac" value="true" required>
            <label for="yesac">Yes</label><br>
            <input type="radio" id="noac" name="ac" value="false">
            <label for="noac">No</label><br>

            <p>Does the room have a fridge?</p>
            <input type="radio" id="yesfridge" name="fridge" value="true" required>
            <label for="yesfridge">Yes</label><br>
            <input type="radio" id="nofridge" name="fridge" value="false">
            <label for="nofridge">No</label><br>

            <label for="capacity">Please enter the capacity of the room</label><br>
            <input type="number" min=1 name="capacity" id="capacity" required><br>


            <p>Is the room extendable?</p>
            <input type="radio" id="yesextend" name="extend" value="true" required>
            <label for="yesextend">Yes</label><br>
            <input type="radio" id="noextend" name="extend" value="false">
            <label for="noexted">No</label><br>

            <label for="defects">Please enter any defects: </label><br>
            <input type="text" id="defects" name="defects" value="None" required><br>

            <label for="view">Please enter the view description: </label><br>
            <input type="text" id="view" name="view" required><br>


            <input type="submit" id="add-employee-submit" value="Submit">
        </form>


    <script src="index.js"></script>
    <body>
</html>