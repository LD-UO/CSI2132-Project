<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<html>
    <head>
        <title>Manage Rooms</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
    <%
         boolean failed = Boolean.parseBoolean(request.getParameter("failure"));
         Employee manager = Session.currentSessionEmployee;
         int streetNum = manager.getStreetNum();
         String streetName = manager.getStreetName();
         String postalCode = manager.getPostalCode();
         int totalRooms = manager.getRoomsInHotel(streetNum, streetName, postalCode);
    %>
    <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
    <p id="failure">Something went wrong, please try again</p>
    <h1>Here are all the rooms at your hotel</h1>
    <p>You can have a total of <%= totalRooms %> customers at your hotel! </p>
    <div id="add-employee-div">
            <form action="add-room-page.jsp" method="POST">
                <input type="submit" id="add-employee-button" value="+ Add Room">
            </form>
        </div>
    <div id="reservation-e-view">
        <table id="reservation-table">
        <tr>
            <th>Room Number</th>
            <th>Price (CAD) </th>
            <th>Defects</th>
        </tr>
        <%
            List<Room> allRooms = Room.getAllRoomsInHotel(streetNum, streetName, postalCode);
            List<Room> deletableRooms = new ArrayList<Room>();

            for (Room r : allRooms){
                if (r.isAvailable()){
                    deletableRooms.add(r);
                }
            }

            for (Room d : deletableRooms){
            %>
                <tr>
                    <td><%= d.getRoomNum() %></td>
                    <td>$<%= d.getPrice() %></td>
                    <td><%= d.getDefects() %></td>
                    <td>
                        <form action="delete-room-controller.jsp" method="POST">
                            <input type="hidden" name="roomNum" value="<%= d.getRoomNum() %>">
                            <input type="submit" id="delete-reservation-button" value="X">
                        </form>
                    </td>
                    <td>
                        <form action="update-room-page.jsp" method="POST">
                            <input type="hidden" name="roomNum" value="<%= d.getRoomNum() %>">
                            <input type="hidden" name="price" value="<%= d.getPrice() %>">
                            <input type="hidden" name="tv" value="<%= d.isTv() %>">
                            <input type="hidden" name="ac" value="<%= d.isAc() %>">
                            <input type="hidden" name="fridge" value="<%= d.isFridge() %>">
                            <input type="hidden" name="capacity" value="<%= d.getCapacity() %>">
                            <input type="hidden" name="extendable" value="<%= d.isExtendable() %>">
                            <input type="hidden" name="defects" value="<%= d.getDefects() %>">
                            <input type="hidden" name="view" value="<%= d.getViewDescription() %>">

                            <input type="image" id="update-icon" name="submit" src="assets/pencil icon.png">
                        </form>
                    </td>
                </tr>
            <%}
        %>
        </table>
    </div>

    <script>
        if ( <%= failed %> ){
            document.getElementById("failure").innerHTML = "Something went wrong, please try again!";
        } else {
            document.getElementById("failure").style.display = "none";
        }
    </script>
    </body>
</html>