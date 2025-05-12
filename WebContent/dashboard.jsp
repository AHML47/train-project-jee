<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/metro-style.css">
</head>
<body>
    <%
        // Check if user is logged in
        Object userObj = session.getAttribute("user");
        if (userObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get user properties
        String username = (String) session.getAttribute("username");
        String email = (String) session.getAttribute("email");
        if (username == null || email == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <div class="dashboard-container">
        <header>
            <h1>Welcome, <%= username %>!</h1>
            <nav>
                <a href="metro-interface.jsp">Metro Interface</a>
                <a href="carteutilisateur.jsp">User Card</a>
                <a href="logout">Logout</a>
            </nav>
        </header>
        
        <main>
            <section class="dashboard-section">
                <h2>Quick Actions</h2>
                <div class="action-buttons">
                    <a href="metro-interface.jsp" class="btn">View Metro Schedule</a>
                    <a href="carteutilisateur.jsp" class="btn">Manage User Card</a>
                </div>
            </section>
            
            <section class="dashboard-section">
                <h2>Account Information</h2>
                <div class="info-card">
                    <p><strong>Username:</strong> <%= username %></p>
                    <p><strong>Email:</strong> <%= email %></p>
                </div>
            </section>
        </main>
    </div>
</body>
</html> 