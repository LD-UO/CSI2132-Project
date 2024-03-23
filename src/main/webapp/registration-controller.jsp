<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Registration" %>
<%@ page import="com.CSI2132Project.Customer" %>
<%@ page import="com.CSI2132Project.LoginCheck" %>
<%
    LoginCheck l = new LoginCheck();
    String username = request.getParameter("username");
    String name = request.getParameter("name");
    String sin = request.getParameter("sin");
    String apt_number = request.getParameter("apt-number");
    String street_number = request.getParameter("street-number");
    String street_name = request.getParameter("street-name");
    String city_name = request.getParameter("city-name");

    String address = apt_number + " " + street_number + " " + street_name + ", " + city_name;

    Registration r = new Registration();
    Customer customerReturned;

    try {
        customerReturned = r.userRegistration(username, name, sin, address);
    } catch (Exception e){
        customerReturned = null;
    }
    if (customerReturned != null){
        l.setLoggedinStatus();
        response.sendRedirect("checkout.jsp");
    } else {
        System.out.println("Something went wrong!");
        response.sendRedirect("registerPage.jsp?registrationFailed=true");
    }

%>