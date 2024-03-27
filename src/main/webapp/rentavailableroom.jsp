<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="com.CSI2132Project.Login" %>
<%@ page import="com.CSI2132Project.Reservation" %>

<%
    Room chosenRoom = null;
    String username = "";
    String startDate = "";
    String endDate = "";
    Login l = new Login();

    String redirectedUsername = request.getParameter("username");
    int employeeID = Session.currentSessionEmployee.getEmployeeId();
    try {
        int chosenRoomNum = Integer.parseInt(request.getParameter("available-rooms-list"));
        username = request.getParameter("customerusername");
        startDate = request.getParameter("checkindaterent");
        endDate = request.getParameter("checkoutdaterent");
        chosenRoom = Session.currentSessionRoom;

        chosenRoom.setRoomNum(chosenRoomNum);

        Session.setRoom(chosenRoom);
        Session.setCurrentSessionStartDate(startDate);
        Session.setCurrentSessionEndDate(endDate);

    } catch(Exception e) {
        chosenRoom = Session.currentSessionRoom;
        startDate = Session.currentSessionStartDate;
        endDate = Session.currentSessionEndDate;
        username = request.getParameter("username");
    }

    if (l.customerLogin(username)){
        // Customer already has an account, we can go ahead with creating the reservation
        Reservation r = new Reservation();
        boolean resultReservation = r.makeReservationWithEmployee(employeeID, chosenRoom, startDate, endDate, username);
        boolean resultCheckin = Room.checkIn(chosenRoom);

        System.out.println(resultCheckin);
        if (resultReservation && resultReservation){
            response.sendRedirect("employee-landing.jsp?reservationCreated=true");
            // Still need to check them in to mark the room as being unavailable
        } else {
            response.sendRedirect("employee-landing.jsp?reservationCreated=false&notFirstTime=true");
        }
    } else {
        // Customer needs to register
        response.sendRedirect("registerPage.jsp?booking=true");
    }

%>