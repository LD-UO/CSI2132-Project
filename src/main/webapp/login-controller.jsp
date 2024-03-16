<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Login" %>
<%@ page import="com.CSI2132Project.Customer" %>

<%
    String username = request.getParameter("username");
    Login login = new Login();
    boolean result = false;
    try {
        result = login.usernameExists(username);
        // Need to do something here for the result
        // Based on the value of result, if it is true, redirect to one page, if it is false, redirect
        // back to the homepage
    } catch (Exception e){
        e.printStackTrace();

    }

    // TODO: CHANGE IN PLANS, WILL ONLY USE THIS CODE WHEN THE USER TRIES TO BOOK A ROOM
    // MAKES THINGS EASIER WHEN TRYING TO GO BETWEEN PAGES
    if (result){
        response.sendRedirect("index.jsp");
    } else {
        System.out.println("The username entered could not be found! You can register here!");
    }
%>
