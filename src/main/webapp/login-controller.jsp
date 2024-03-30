<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Login" %>

<%
    String username = request.getParameter("username");
    boolean accountInfo = Boolean.parseBoolean(request.getParameter("accountInfoRedirect"));
    Login login = new Login();
    boolean result = false;
    try {
        result = login.customerLogin(username);
    } catch (Exception e){
        e.printStackTrace();

    }

    if (result){
        if (!accountInfo){
            response.sendRedirect("checkout.jsp");
        } else {
            response.sendRedirect("accountInfo.jsp");
        }
    } else {
        if (!accountInfo){
            response.sendRedirect("loginPage.jsp?loginFailed=true");
        } else {
            response.sendRedirect("loginPage.jsp?loginFailed=true&accountInfo=true");
        }
    }
%>
