<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.LoginCheck" %>
<%@ page import="com.CSI2132Project.Customer" %>

<%
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String username = LoginCheck.getUserName();

    boolean result = Customer.updateCustomer(username, name, address);

    if (result){
        response.sendRedirect("accountInfo.jsp");
    } else {
        response.sendRedirect("accountInfo.jsp?failure=true");
    }
%>