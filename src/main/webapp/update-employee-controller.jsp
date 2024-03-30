<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Employee" %>

<%
    int employeeID = Integer.parseInt(request.getParameter("employeeID"));
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String position = request.getParameter("position");

    boolean result = Employee.updateEmployee(employeeID, name, phone, position);

    if (result){
        response.sendRedirect("manage-employees.jsp");
    } else {
        response.sendRedirect("manage-employees.jsp?failure=true");
    }
%>