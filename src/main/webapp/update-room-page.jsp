<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<html>
    <head>
        <title>Update Room</title>
        <link href="index.css" rel="stylesheet">
    </head>
    <body id="employee-landing" onload="allEmptyFieldCheck()">
    <h1><a id="logo-link" href="employee-landing.jsp">Logo will go here<a></h1>
        <%
            int roomNum = Integer.parseInt(request.getParameter("roomNum"));
            System.out.println(roomNum);
            double price = Double.parseDouble(request.getParameter("price"));
            boolean tv = Boolean.parseBoolean(request.getParameter("tv"));
            boolean ac = Boolean.parseBoolean(request.getParameter("ac"));
            boolean fridge = Boolean.parseBoolean(request.getParameter("fridge"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            boolean extendable = Boolean.parseBoolean(request.getParameter("extendable"));
            String defects = request.getParameter("defects");
            String view = request.getParameter("view");
        %>
            <form action="update-room-controller.jsp" method="POST">
                <label for="price">Updated Price: </label><br>
                <input type="text" id="price" name="price" onkeypress="return isNumberKey(event)" value="<%= price %>"><br>

                <p>Does the room have a TV?</p>
                <input type="radio" id="yestv" name="tv" value="true">
                <label for="yestv">Yes</label><br>
                <input type="radio" id="notv" name="tv" value="false">
                <label for="notv">No</label><br>

                <p>Does the room have an AC?</p>
                <input type="radio" id="yesac" name="ac" value="true">
                <label for="yesac">Yes</label><br>
                <input type="radio" id="noac" name="ac" value="false">
                <label for="noac">No</label><br>

                <p>Does the room have a fridge?</p>
                <input type="radio" id="yesfridge" name="fridge" value="true">
                <label for="yesfridge">Yes</label><br>
                <input type="radio" id="nofridge" name="fridge" value="false">
                <label for="nofridge">No</label><br>

                <label for="capacity">Please enter the capacity of the room</label><br>
                <input type="number" min=1 name="capacity" id="capacity" value="<%= capacity %>"><br>


                <p>Is the room extendable?</p>
                <input type="radio" id="yesextend" name="extend" value="true" required>
                <label for="yesextend">Yes</label><br>
                <input type="radio" id="noextend" name="extend" value="false">
                <label for="noexted">No</label><br>

                <label for="defects">Please enter any defects: </label><br>
                <input type="text" id="defects" name="defects" value="None" value="<%= defects %>"><br>

                <label for="view">Please enter the updated view description: </label><br>
                <input type="text" id="view" name="view" value="<%= view %>"><br>

                <input type="hidden" name="roomNum" value="<%= roomNum %>">
                <input type="submit" id="submit" value="Update">

        </form>
        <script src="index.js"></script>
        <script>
            if ( <%= tv %> ){
                document.getElementById("yestv").checked = true;
            } else {
                document.getElementById("notv").checked = true;
            }

            if ( <%= ac %> ){
                document.getElementById("yesac").checked = true;
            } else {
                document.getElementById("noac").checked = true;
            }

            if ( <%= fridge %> ){
                document.getElementById("yesfridge").checked = true;
            } else {
                document.getElementById("nofridge").checked = true;
            }

            if ( <%= extendable %> ){
                document.getElementById("yesextend").checked = true;
            } else {
                document.getElementById("noextend").checked = true;
            }
        </script>
    </body>
</html>
