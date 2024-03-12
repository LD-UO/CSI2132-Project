<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Login" %>
<%@ page import="com.CSI2132Project.Customer" %>

<%
    String username = request.getParameter("username");
    Login login = new Login();

    try {
        boolean result = login.usernameExists(username);
        // Need to do something here for the result
        // Based on the value of result, if it is true, redirect to one page, if it is false, redirect
        // back to the homepage
    } catch (Exception e){
        e.printStackTrace();

    }

    // TODO: Going to need some sort of verification here
    response.sendRedirect("index.jsp");
%>
