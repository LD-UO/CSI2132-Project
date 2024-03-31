<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.CSI2132Project.Employee" %>

<html>
    <head>
        <title>Available Rooms</title>
        <link href="index.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assets/logo.png">
    </head>
    <body id="available-rooms-page">
        <%
            List<Room> availableRoomsAtHotel = new ArrayList<Room>();
            Employee e = Session.currentSessionEmployee;
            Room sessionRoom = new Room();

            int eStreetNum = e.getStreetNum();
            String eStreetName = e.getStreetName();
            String ePostalCode = e.getPostalCode();

            List<Room> availableRooms = Room.findAllAvailableRooms();
            for (Room r : availableRooms){
                int streetNum = r.getStreetNum();
                String streetName = r.getStreetName();
                String postalCode = r.getPostalCode();

                if (streetNum == eStreetNum && streetName.equals(eStreetName) && postalCode.equals(ePostalCode)){
                    availableRoomsAtHotel.add(r);
                    sessionRoom = r;
                }
            }

            Session.setRoom(sessionRoom);
        %>

        <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
        <h1>All of the currently available rooms are in the dropdown below: </h1>
            <div id="rentroomform">
            <form action="rentavailableroom.jsp" method="POST">
                <br>
                <br>
                <label id="dropdown-label" for="available-rooms-list">Please choose a room: </label><br>
                <select name="available-rooms-list" required>
                    <% for (Room r : availableRoomsAtHotel){ %>
                    <option value="<%= r.getRoomNum() %>"><%= r.getRoomNum() %></option>
                    <% } %>
                </select><br><br><br>
                <label id="checkout-label" for="checkoutdaterent">Please enter the date you would like to checkout: </label><br>
                <input type="date" id="checkoutdaterent" name="checkoutdaterent" required><br><br><br>
                <label id="username-label" for="customerusername">Please enter the username of the customer: </label><br>
                <input type="text" id="customerusername" name="customerusername" required><br><br><br>
                <input type="hidden" id="checkindaterent" name="checkindaterent">
                <input type="submit" id="submit-rent" value="Book!">
                <br><br>
            </form>
        </div>
        <script>
            var currentDate = new Date();
            document.getElementById("checkindaterent").value = currentDate.toISOString().split("T")[0]
            document.getElementById("checkoutdaterent").min = currentDate.toISOString().split("T")[0]
        </script>
    </body>
</html>
