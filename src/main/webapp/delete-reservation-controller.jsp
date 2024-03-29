<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Reservation" %>

<%
    int roomnum = Integer.parseInt(request.getParameter("roomnum"));
    int streetnum = Integer.parseInt(request.getParameter("streetnum"));
    String streetname = request.getParameter("streetname");
    String postalCode = request.getParameter("postalCode");
    String startDate = request.getParameter("startDate");

    Reservation r = new Reservation();

    boolean result = r.deleteReservation(roomnum, streetnum, streetname, postalCode, startDate);

    if (result){
        response.sendRedirect("deleteReservation.jsp");
    } else {
        response.sendRedirect("deleteReservation.jsp?failed=true");
    }
%>