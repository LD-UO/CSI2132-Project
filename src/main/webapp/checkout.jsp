<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>
<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="com.CSI2132Project.Session" %>

<html>
<head>
</head>
<body>
    <%
        Room currentRoom;
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

            currentRoom = new Room(roomNum, streetNum, streetName, postalCode, price, isTv, isAc, isFridge, capacity, isExtendable, defects, description, isAvailable);
            Session.setRoom(currentRoom);
        } catch (Exception e){
            currentRoom = Session.currentSessionRoom;
        }

        LoginCheck l1 = new LoginCheck();
        boolean status = l1.getLoggedInStatus();

        if (!status){
            String redirectURL = "loginPage.jsp";
            response.sendRedirect(redirectURL);
        } else {
            %>
            <p>Here is a quick summary of the room you have selected: </p>
           <p><%= Session.currentSessionRoom.getRoomNum() %></p>
           <p><%= Session.currentSessionRoom.getStreetNum() %></p>
           <p><%= Session.currentSessionRoom.getStreetName() %></p>
           <p><%= Session.currentSessionRoom.getPostalCode() %></p>
           <p><%= Session.currentSessionRoom.getPrice() %></p>
           <p><%= Session.currentSessionRoom.isTv() %></p>
           <p><%= Session.currentSessionRoom.isAc() %></p>
           <p><%= Session.currentSessionRoom.isFridge() %></p>
           <p><%= Session.currentSessionRoom.getCapacity() %></p>
           <p><%= Session.currentSessionRoom.isExtendable() %></p>
           <p><%= Session.currentSessionRoom.getDefects() %></p>
           <p><%= Session.currentSessionRoom.getViewDescription() %></p>
           <p><%= Session.currentSessionRoom.isAvailable() %></p>
        <% }
        %>
</body>
</html>