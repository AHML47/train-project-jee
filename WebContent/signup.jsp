<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/metro-style.css">
</head>
<body>
    <h1>Sign Up</h1>
    <% if(request.getAttribute("error") != null) { %>
        <div style="color: red;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    <form action="/signup" method="post">
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Sign Up</button>
    </form>
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</body>
</html> 