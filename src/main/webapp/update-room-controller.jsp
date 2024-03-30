<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>

<%
    Employee manager = Session.currentSessionEmployee;
    int streetNum = manager.getStreetNum();
    String streetName = manager.getStreetName();
    String postalCode = manager.getPostalCode();
    int roomNum = Integer.parseInt(request.getParameter("roomNum"));


    double price = Double.parseDouble(request.getParameter("price"));
    boolean tv = Boolean.parseBoolean(request.getParameter("tv"));
    boolean ac = Boolean.parseBoolean(request.getParameter("ac"));
    boolean fridge = Boolean.parseBoolean(request.getParameter("fridge"));
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    boolean extendable = Boolean.parseBoolean(request.getParameter("extend"));
    String defects = request.getParameter("defects");
    String view = request.getParameter("view");

    boolean result = Room.updateRoom(roomNum, streetNum, streetName, postalCode, price, tv, ac, fridge, capacity, extendable, defects, view);

    if (result){
        response.sendRedirect("manage-rooms.jsp");
    } else {
        response.sendRedirect("manage-rooms.jsp?failure=true");
    }


%>