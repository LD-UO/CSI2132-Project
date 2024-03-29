<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>

<%
    int employeeID = Integer.parseInt(request.getParameter("employeeID"));
    String name = request.getParameter("employeeName");
    String phone = request.getParameter("employeeNumber");
    String position = request.getParameter("position");
    String SIN = request.getParameter("SIN");

    Employee m = Session.currentSessionEmployee;

    int streetNum = m.getStreetNum();
    String streetName = m.getStreetName();
    String postal = m.getPostalCode();

    Employee toBeDeleted = new Employee(employeeID, streetName, streetNum, postal, name, phone, position, SIN);

    boolean result = Employee.deleteEmployee(toBeDeleted);

    if (result){
        response.sendRedirect("manage-employees.jsp");
    } else {
        response.sendRedirect("manage-employees.jsp?failure=true");
    }
%>