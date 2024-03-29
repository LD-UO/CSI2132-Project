<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>

<%
    int employeeID = Integer.parseInt(request.getParameter("employeeID"));
    String name = request.getParameter("name");
    String number = request.getParameter("number");
    String position = request.getParameter("position");
    String SIN = request.getParameter("SIN");

    Employee e = Session.currentSessionEmployee;

    int streetNum = e.getStreetNum();
    String streetName = e.getStreetName();
    String postalCode = e.getPostalCode();

    Employee newEmployee = new Employee(employeeID, streetName, streetNum, postalCode, name, number, position, SIN);


    boolean result = Employee.addEmployee(newEmployee);

    if (result) {
        response.sendRedirect("manage-employees.jsp");
    } else {
        response.sendRedirect("manage-employees.jsp?failure=true");
    }
%>