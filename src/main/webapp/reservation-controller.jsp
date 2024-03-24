<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="com.CSI2132Project.Reservation" %>
<%@ page import="com.CSI2132Project.LoginCheck" %>
<%
    Room currentRoom = Session.currentSessionRoom;
    String startDate = Session.currentSessionStartDate;
    String endDate = Session.currentSessionEndDate;
    boolean reservationCreated = false;
    Reservation r = new Reservation(LoginCheck.getUserName());

    try {
        reservationCreated = r.makeReservation(currentRoom, startDate, endDate);
    } catch (Exception e){
    %>
        <script>
            alert("Something went wrong! Please try again");
        </script>
    <%
        response.sendRedirect("checkout.jsp");
    }

    if (reservationCreated){
        response.sendRedirect("index.jsp");
    } else {
        %>
        <script>
            alert("Something went wrong! Please try again");
        </script>
        <%
        response.sendRedirect("checkout.jsp");
    }


%>