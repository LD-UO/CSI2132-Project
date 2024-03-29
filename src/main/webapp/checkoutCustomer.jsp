<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Reservation" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Checkout Customer</title>
    <link href="index.css" rel="stylesheet">
</head>
<body id="employee-landing">
    <h1>Logo will go here</h1>
    <p id="failure">Something went wrong, please try again!</p>
    <p id="success">Checked out successfully!</p>

    <%
        // Will have to get a list of all of the reservations made
        Employee e = Session.currentSessionEmployee;
        List<Reservation> assignedReservations = e.viewAllReservations(e.getEmployeeId());
        boolean notFirstTime = Boolean.parseBoolean(request.getParameter("notFirstTime"));
        boolean failedCheckOut = Boolean.parseBoolean(request.getParameter("failedCheckOut"));

        boolean combinedResult = notFirstTime && !failedCheckOut;
        System.out.println(combinedResult);
        for (Reservation r : assignedReservations){
            %>

            <p><%= r.getRoomNum() + " " + r.getUsername() %></p>
            <form action="checkout-controller.jsp" method="POST">
                <input type="hidden" name="roomNum" value="<%= r.getRoomNum() %>">
                <input type="hidden" name="streetNum" value="<%= r.getStreetNum() %>">
                <input type="hidden" name="streetName" value="<%= r.getStreetName() %>">
                <input type="hidden" name="postalCode" value="<%= r.getPostalCode() %>">
                <input type="submit" value="Check Out">
            </form>
        <%}
    %>

    <script>
        if ( <%= notFirstTime && failedCheckOut %> ){
            document.getElementById("failure").innerHTML = "Something went wrong, please try again!";
        } else {
            document.getElementById("failure").style.display = "none";
        }

        if ( <%= combinedResult %> ){
            document.getElementById("success").innerHTML = "Checked out successfully!";
        } else {
            document.getElementById("success").style.display = "none";
        }
    </script>
</body>
</html>
