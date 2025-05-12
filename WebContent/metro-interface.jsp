<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Metro Tracking System</title>
    <link rel="stylesheet" href="css/metro-style.css">
    <style>
        .login-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 15px;
        }
        
        .login-btn:hover {
            background-color: #45a049;
        }
        
        .controls {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Metro Position</h1>
        
        <div id="map-container">
            <img id="metro-map" src="https://www.skyscrapercity.com/cdn-cgi/image/format=auto,onerror=redirect,width=1920,height=1920,fit=scale-down/https://www.skyscrapercity.com/attachments/screenshot-2024-01-24-at-12-05-57-pm-png.6594050/" alt="Metro Map">
            <!-- Train markers will be added here dynamically -->
        </div>
        
        <div class="controls">
            <button id="refresh-btn" onclick="updateTrainPositions()">Refresh Positions</button>
            <a href="signUp"><button class="login-btn">Carte d'Identification</button></a>
        </div>
    </div>
    
    <script src="js/metro-map.js"></script>
</body>
</html>