<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="css/metro-style.css">
</head>
<body>
    <h1>Login</h1>
    <% if(request.getAttribute("error") != null) { %>
        <div style="color: red;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    <form action="login" method="post">
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
    </form>
    <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
</body>
</html> 