<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome!</title>
</head>
<body>
    <h2>Welcome to our Hotel!</h2>
    <form name="login-form" action="login-controller.jsp" method="POST">
        <label for="username">Username: </label>
        <input type="text" name="username">
        <br>
        <button type="submit">Log in</button>
    </form>
</body>
</html>
