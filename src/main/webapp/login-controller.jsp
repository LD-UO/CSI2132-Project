<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Login" %>

<%
    String username = request.getParameter("username");
    Login login = new Login();
    boolean result = false;
    try {
        result = login.customerLogin(username);
    } catch (Exception e){
        e.printStackTrace();

    }

    if (result){
        response.sendRedirect("checkout.jsp");
    } else {
        response.sendRedirect("loginPage.jsp?loginFailed=true");
    }
%>
