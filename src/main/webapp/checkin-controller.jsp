<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Room" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%

    int roomNum = Integer.parseInt(request.getParameter("checkin-roomnumber"));
    int streetNum = Integer.parseInt(request.getParameter("checkin-streetnumber"));
    String streetName = request.getParameter("checkin-streetname");
    String postalCode = request.getParameter("checkin-postalcode");
    String date = request.getParameter("checkin-startdate");
    boolean result = false;


    SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
    Date d1 = sdformat.parse(date);
    Date now = new Date();
    Date d2 = sdformat.parse(sdformat.format(new Date()));

    System.out.println(d1.compareTo(d2));

    if (d1.compareTo(d2) == 0){
        Room checkInTo = new Room(roomNum, streetNum, streetName, postalCode);
        result = Room.checkIn(checkInTo);
    }



    if (result){
        response.sendRedirect("viewreservations.jsp?success=true");
    } else {
        response.sendRedirect("viewreservations.jsp?failure=true");
    }
%>