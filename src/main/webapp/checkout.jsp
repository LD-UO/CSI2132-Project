<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>
<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="com.CSI2132Project.Session" %>

<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="index.css">
</head>
<body id="checkout-page">
    <%
        Room currentRoom;
        String startDate;
        String endDate;
        try {
            int roomNum = Integer.parseInt(request.getParameter("currentRoomNumber"));
            int streetNum = Integer.parseInt(request.getParameter("currentStreetNum"));
            String streetName = request.getParameter("currentStreetName");
            String postalCode = request.getParameter("currentPostalCode");
            double price = Double.parseDouble(request.getParameter("currentPrice"));
            boolean isTv = Boolean.parseBoolean(request.getParameter("currentTv"));
            boolean isAc = Boolean.parseBoolean(request.getParameter("currentAc"));
            boolean isFridge = Boolean.parseBoolean(request.getParameter("currentFridge"));
            int capacity = Integer.parseInt(request.getParameter("currentCapacity"));
            boolean isExtendable = Boolean.parseBoolean(request.getParameter("currentExtendable"));
            String defects = request.getParameter("currentDefects");
            String description = request.getParameter("currentDescription");
            boolean isAvailable = Boolean.parseBoolean(request.getParameter("currentAvailable"));
            startDate = request.getParameter("currentStartDate");
            endDate = request.getParameter("currentEndDate");

            currentRoom = new Room(roomNum, streetNum, streetName, postalCode, price, isTv, isAc, isFridge, capacity, isExtendable, defects, description, isAvailable);

            Session.setRoom(currentRoom);
            Session.setCurrentSessionStartDate(startDate);
            Session.setCurrentSessionEndDate(endDate);

        } catch (Exception e){
            currentRoom = Session.currentSessionRoom;
            startDate = Session.currentSessionStartDate;
            endDate = Session.currentSessionEndDate;
        }

        LoginCheck l1 = new LoginCheck();
        boolean status = l1.getLoggedInStatus();

        if (!status){
            String redirectURL = "loginPage.jsp";
            response.sendRedirect(redirectURL);
        } else {
            %>
            <div id="disclaimer-summary">
                <p id="disclaimer-summary-text">This is a quick summary of the room that you have chosen plus some additional information. Please note that payments will be accepted
                at the time of checking in. Once you click on the Book Room button at the bottom of the page, you will be redirected to the homepage and you will receive an email with the receipt
                of your booking which you can display at the time of check in. </p>
                <p id="another-choice">Click <a id="back-link" href="availablerooms.jsp?checkin=<%= startDate %>&checkout=<%= endDate %>">here</a> if you would like to choose another room</p>
            </div>
            <div id="summary">
                <p id="summary-text-header">Here is a quick summary of the room you have selected: </p>
                <div id="summary-text">
                <h3>Address: </h3>
                <p><%= Session.currentSessionRoom.getStreetNum() + " " + Session.currentSessionRoom.getStreetName() + " - " + Session.currentSessionRoom.getRoomNum() %></p>
                <p><%= Session.currentSessionRoom.getPostalCode() %></p>
                <div id="remainder">
                    <h3>Pricing (CAD): </h3>
                    <p><%= Session.currentSessionRoom.getPrice() %></p>
                        <h3>Amenities: </h3>
                        <p><img id="tv-icon<%= currentRoom.getRoomNum() %>" data-toggle="tooltip" data-placement="top" title="TV" src="" alt="">
                                            <img id="ac-icon<%= currentRoom.getRoomNum() %>" data-toggle="tooltip" data-placement="top" title="AC" src="" alt="">
                                            <img id="fridge-icon<%= currentRoom.getRoomNum() %>" data-toggle="tooltip" data-placement="top" title="Fridge" src="" alt=""></p>
                        <script>
                            if ( <%= currentRoom.isTv() %> ){
                                document.getElementById("tv-icon<%= currentRoom.getRoomNum() %>").src = "assets/tv icon.png";
                            }

                            if ( <%= currentRoom.isAc() %> ){
                                 document.getElementById("ac-icon<%= currentRoom.getRoomNum() %>").src = "assets/ac icon.png";
                            }

                            if ( <%= currentRoom.isFridge() %> ){
                                  document.getElementById("fridge-icon<%= currentRoom.getRoomNum() %>").src = "assets/fridge icon.png";
                            }
                        </script>
                        <h3>Capacity: </h3>
                        <p><img src="assets/people icon.png"> - <%= currentRoom.getCapacity() %> people(s)</p>
                        <p>Can be extended? - <%= Session.currentSessionRoom.isExtendable() %></p>
                        <p>Defect(s): <%= Session.currentSessionRoom.getDefects() %></p>
                        <p>View: <%= Session.currentSessionRoom.getViewDescription() %></p>
                    </div>
                </div>
                <div id ="summary-image">
                    <img id="hotel-image" src="assets/hotel.jpg">
                </div>

                <div id="submit-checkout">
                    <form action="reservation-controller.jsp" method="POST">
                        <input type="submit" id="submit-reservation" value="Book Room!">
                    </form>
                </div>
            </div>

        <% }
        %>
</body>
</html>