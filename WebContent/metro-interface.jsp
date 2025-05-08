
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Metro Tracking System</title>
    <link rel="stylesheet" href="css/metro-style.css">
</head>
<body>
    <div class="container">
        <h1>Paris Metro Tracking System</h1>
        
        <div id="map-container">
            <img id="metro-map" src="images/metro-map.png" alt="Paris Metro Map">
            <!-- Train markers will be added here dynamically -->
        </div>
        
        <div class="controls">
            <button id="refresh-btn" onclick="updateTrainPositions()">Refresh Positions</button>
        </div>
    </div>
    
    <script src="js/metro-map.js"></script>
</body>
</html>