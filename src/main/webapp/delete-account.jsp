<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>
<%@ page import="com.CSI2132Project.Customer" %>

<%

    String username = request.getParameter("username");
    String name = request.getParameter("name");
    String SIN = request.getParameter("SIN");
    String address = request.getParameter("address");

    Customer customerToBeDeleted = new Customer(username, name, SIN, address);

    boolean result = Customer.deleteCustomer(customerToBeDeleted);

    if (result){
        // Successfully deleted the customer
        LoginCheck.deleteAccount();
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("accountInfo.jsp?failure=true");
    }
%>