<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="com.CSI2132Project.Room" %>

<%
    int roomNum = Integer.parseInt(request.getParameter("roomNum"));
    double price = Double.parseDouble(request.getParameter("price"));
    boolean hasTv = Boolean.parseBoolean(request.getParameter("tv"));
    boolean hasAc = Boolean.parseBoolean(request.getParameter("ac"));
    boolean hasFridge = Boolean.parseBoolean(request.getParameter("fridge"));
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    boolean isExtendable = Boolean.parseBoolean(request.getParameter("extend"));
    String defects = request.getParameter("defects");
    String view = request.getParameter("view");

    Employee m = Session.currentSessionEmployee;

    int streetNum = m.getStreetNum();
    String streetName = m.getStreetName();
    String postalCode = m.getPostalCode();

    String area = Room.getAreaGivenAddress(streetNum, streetName, postalCode);

    // Setting the availability of the new room to be true as a new room cannot possibly have any reservations
    Room toBeAdded = new Room(roomNum, streetNum, streetName, postalCode, price, hasTv, hasAc, hasFridge, capacity, isExtendable, defects, view, true, area);

    boolean result = Room.addRoom(toBeAdded);

    if (result){
        response.sendRedirect("manage-rooms.jsp");
    } else {
        response.sendRedirect("manage-rooms.jsp?failure=true");
    }
%>