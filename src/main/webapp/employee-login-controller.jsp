<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.CSI2132Project.Login" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="com.CSI2132Project.Session" %>

<%
    int employee_id = Integer.parseInt(request.getParameter("employee-id"));
    Login l = new Login();

    Employee e = l.employeeLogin(employee_id);

    if (e == null){
        // This means that the employee ID could not be found in the table
        response.sendRedirect("employee-login.jsp?loginFailed=true");
    } else {
        // This means that the employee ID could be found
        Session.setCurrentSessionEmployee(e);
        response.sendRedirect("employee-landing.jsp");
    }
%>