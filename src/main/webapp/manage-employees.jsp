<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.CSI2132Project.Session" %>
<%@ page import="com.CSI2132Project.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
    <head>
        <title>Employee Management</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing">
    <%
         boolean failed = Boolean.parseBoolean(request.getParameter("failure"));
    %>
    <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
    <p id="failure">Something went wrong, please try again</p>
    <h1>Here are all the employees at your hotel</h1>
    <div id="add-employee-div">
        <form action="add-employee-page.jsp" method="POST">
            <input type="submit" id="add-employee-button" value="+ Add Employee">
        </form>
    </div>
    <div id="reservation-e-view">
    <table id="reservation-table">
    <tr>
        <th>Employee ID</th>
        <th>Name</th>
        <th>Phone Number</th>
        <th>Position</th>
        <th>SIN</th>
    </tr>
        <%
            Employee e = Session.currentSessionEmployee;
            int streetNum = e.getStreetNum();
            String streetName = e.getStreetName();
            String postalCode = e.getPostalCode();

            List<Employee> relevantEmployees = new ArrayList<Employee>();
            List<Employee> hotelEmployees = Employee.getAllEmployeesAtHotel(streetNum, streetName, postalCode);

            // Filtering through and removing the manager so we disallow managers from firing themselves
            for (Employee list : hotelEmployees){
                if (list.getEmployeeId() != e.getEmployeeId()){
                    relevantEmployees.add(list);
                }
            }
            for (Employee listEmployee : relevantEmployees){
        %>
            <tr>
                <td><%= listEmployee.getEmployeeId() %> </td>
                <td><%= listEmployee.getName() %></td>
                <td><%= listEmployee.getPhone() %></td>
                <td><%= listEmployee.getPosition() %></td>
                <td><%= listEmployee.getSIN() %></td>
                <td>
                    <form action="delete-employee-controller.jsp" method="POST">
                        <input type="hidden" name="employeeID" value="<%= listEmployee.getEmployeeId() %>">
                        <input type="hidden" name="employeeName" value="<%= listEmployee.getName() %>">
                        <input type="hidden" name="employeeNumber" value="<%= listEmployee.getPhone() %>">
                        <input type="hidden" name="position" value="<%= listEmployee.getPosition() %>">
                        <input type="hidden" name="SIN" value="<%= listEmployee.getSIN() %>">
                        <input type="submit" id="delete-reservation-button" value="X">
                    </form>
                </td>
                <td>
                    <form action="update-employee-page.jsp" method="POST">
                        <input type="hidden" name="employeeID" value="<%= listEmployee.getEmployeeId() %>">
                        <input type="image" name="submit" id="update-icon" src="assets/pencil icon.png">
                    </form>
                </td>
            </tr>
        <%
        }
        %>
        </table>
        </div>

        <script>
            if ( <%= failed %> ){
                document.getElementById("failure").innerHTML = "Something went wrong, please try again!";
            } else {
                document.getElementById("failure").style.display = "none";
            }
        </script>
    </body>
</html>

