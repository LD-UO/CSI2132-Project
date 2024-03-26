<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="java.util.List" %>

<html>
    <head>
        <title>Available Rooms</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="index.css">
    </head>
    <body style="background-color: rgba(173, 216, 230, 0.5)">
        <h1>Logo will go here</h1>
        <br>
        <br>
        <br>
        <div id="room-welcome">
            <p id="room-welcome-message">For the dates you have provided, the following rooms match your criteria: </p>
        </div>
        <br>
        <%
            String startDate = request.getParameter("checkin");
            String endDate = request.getParameter("checkout");
            Room r1 = new Room();
            List<Room> results = r1.findAvailableRooms(startDate, endDate);
            for (Room r : results){
        %>
                <form action="checkout.jsp" method="POST">
                <input type="hidden" id="currentRoomNumber" name="currentRoomNumber" value=<%= r.getRoomNum() %>>
                <input type="hidden" id="currentStreetNum" name="currentStreetNum" value=<%= r.getStreetNum() %>>
                <input type="hidden" id="currentStreetName" name="currentStreetName" value='<%= r.getStreetName() %>'>
                <input type="hidden" id="currentPostalCode" name="currentPostalCode" value=<%= r.getPostalCode() %>>
                <input type="hidden" id="currentPrice" name="currentPrice" value=<%= r.getPrice() %>>
                <input type="hidden" id="currentTv" name="currentTv" value=<%= r.isTv() %>>
                <input type="hidden" id="currentAc" name="currentAc" value=<%= r.isAc() %>>
                <input type="hidden" id="currentFridge" name="currentFridge" value=<%= r.isFridge() %>>
                <input type="hidden" id="currentCapacity" name="currentCapacity" value=<%= r.getCapacity() %>>
                <input type="hidden" id="currentExtendable" name="currentExtendable" value=<%= r.isExtendable() %>>
                <input type="hidden" id="currentDefects" name="currentDefects" value=<%= r.getDefects() %>>
                <input type="hidden" id="currentDescription" name="currentDescription" value=<%= r.getViewDescription() %>>
                <input type="hidden" id="currentAvailable" name="currentAvailable" value=<%= r.isAvailable() %>>
                <input type="hidden" id="currentStartDate" name="currentStartDate" value=<%= startDate %>>
                <input type="hidden" id="currentEndDate" name="currentEndDate" value=<%= endDate %>>

                <div class="card" style="width: 18rem;">
                  <img src="assets/hotel.jpg" class="card-img-top" alt="...">
                  <div class="card-body">

                  <!-- TODO: Could set the card header to be the hotel chain that offers the room -->
                  <!-- TODO: If no rooms could be found within the given date range, we should display a message status! -->

                    <h5 class="card-title"><%= r.getStreetNum() %> <%= r.getStreetName() %> - <%= r.getRoomNum() %></h5>
                    <p class="card-text"><%= r.getPostalCode() %></p>
                    <p class="card-text"><img src="assets/people icon.png"> - <%= r.getCapacity() %> people(s)</p>
                    <p class="card-text">Amenities: <img id="tv-icon<%= r.getRoomNum() %>" data-toggle="tooltip" data-placement="top" title="TV" src="" alt="">
                    <img id="ac-icon<%= r.getRoomNum() %>" data-toggle="tooltip" data-placement="top" title="AC" src="" alt="">
                    <img id="fridge-icon<%= r.getRoomNum() %>" data-toggle="tooltip" data-placement="top" title="Fridge" src="" alt=""></p>
                    <script>
                        if ( <%= r.isTv() %> ){
                            document.getElementById("tv-icon<%= r.getRoomNum() %>").src = "assets/tv icon.png";
                        }

                        if ( <%= r.isAc() %> ){
                            document.getElementById("ac-icon<%= r.getRoomNum() %>").src = "assets/ac icon.png";
                        }

                        if ( <%= r.isFridge() %> ){
                            document.getElementById("fridge-icon<%= r.getRoomNum() %>").src = "assets/fridge icon.png";
                        }
                    </script>
                    <p class="card-text">Can be extended: <%= r.isExtendable() %></p>
                    <button id="selectroombutton" type="submit">Book for <strong>$<%= r.getPrice() %>/night</strong> CAD! </button>
                  </div>
                </div>
                </form>

            <% }
        %>
        <script src="index.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>