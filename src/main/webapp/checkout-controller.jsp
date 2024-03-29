<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Room" %>

<%
    int roomNum = Integer.parseInt(request.getParameter("roomNum"));
    int streetNum = Integer.parseInt(request.getParameter("streetNum"));
    String streetName = request.getParameter("streetName");
    String postalCode = request.getParameter("postalCode");

    Room r = new Room(roomNum, streetNum, streetName, postalCode);

    boolean result = Room.checkOut(r);

    if (result){
        // The room was checked out successfully
        response.sendRedirect("checkoutCustomer.jsp?notFirstTime=true&failedCheckOut=false");
    } else {
        // The room could not be checkout correctly
        response.sendRedirect("checkoutCustomer.jsp?notFirstTime=true&failedCheckOut=true");
    }
%>