<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="com.CSI2132Project.Room" %>

<%
    int roomNum = Integer.parseInt(request.getParameter("roomNum"));
    Employee e = Session.currentSessionEmployee;

    int streetNum = e.getStreetNum();
    String streetName = e.getStreetName();
    String postalCode = e.getPostalCode();

    Room roomToDelete = new Room(roomNum, streetNum, streetName, postalCode);

    boolean result = Room.deleteRoom(roomToDelete);

    if (result){
        response.sendRedirect("manage-rooms.jsp");
    } else {
        response.sendRedirect("manage-rooms.jsp?failure=true");
    }
%>