<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Metro Tracking System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/metro-style.css">
</head>
<body>
    <nav class="navbar">
        <a href="metroInterfaceS" class="logo">
            <i class="fas fa-train"></i> Sahel Metro
        </a>
        <ul class="nav-links">
            <li><a href="metroInterfaceS"><i class="fas fa-map-marked-alt"></i> Map</a></li>
            <li><a href="#"><i class="fas fa-info-circle"></i> About</a></li>
            <li><a href="#"><i class="fas fa-phone"></i> Contact</a></li>
        </ul>
    </nav>

    <div class="container">
        <h1><i class="fas fa-map-marker-alt"></i> Live Metro Tracking</h1>
        
        <div class="card">
            <div id="map-container">
                <img id="metro-map" src="https://www.skyscrapercity.com/cdn-cgi/image/format=auto,onerror=redirect,width=1920,height=1920,fit=scale-down/https://www.skyscrapercity.com/attachments/screenshot-2024-01-24-at-12-05-57-pm-png.6594050/" alt="Metro Map">
                
                <!-- Map legend -->
                <div class="map-legend">
                    <div class="legend-item">
                        <div class="legend-marker train-marker line-sahelline"></div>
                        <span>SahelLine Train</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-marker station-marker"></div>
                        <span>Station</span>
                    </div>
                </div>
            </div>
            
            <div class="controls">
                <div>
                    <button id="refresh-btn" class="btn" onclick="updateTrainPositions()">
                        <i class="fas fa-sync-alt"></i> Refresh Positions
                    </button>
                </div>
                
                <div>
                    <a href="${buttonLink}">
                        <button class="btn btn-secondary">
                            <i class="${buttonText == 'Generate Carte' ? 'fas fa-id-card' : 'fas fa-user-plus'}"></i> 
                            ${buttonText != null ? buttonText : "Sign Up or Login"}
                        </button>
                    </a>
                </div>
            </div>
        </div>
        
        <div class="card" id="station-info-container" style="display: none;">
            <div class="card-header">
                <i class="fas fa-subway" style="font-size: 1.5rem; color: var(--primary-color);"></i>
                <h3 class="card-title">Station Information</h3>
            </div>
            <div id="station-info">
                <!-- Station information will be displayed here -->
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <p>&copy; 2024 Sahel Metro Tracking System. All rights reserved.</p>
    </footer>
    
    <script src="js/metro-map.js"></script>
    <script>
        // Show station info container when a station is clicked
        function showStationInfo(station) {
            const infoDiv = document.getElementById('station-info');
            const container = document.getElementById('station-info-container');
            
            if (infoDiv) {
                infoDiv.innerHTML = `
                    <div class="user-detail">
                        <strong><i class="fas fa-map-marker-alt"></i> Station:</strong>
                        <span>${station.name}</span>
                    </div>
                    <div class="user-detail">
                        <strong><i class="fas fa-hashtag"></i> ID:</strong>
                        <span>${station.id}</span>
                    </div>
                    <div class="user-detail">
                        <strong><i class="fas fa-location-arrow"></i> Coordinates:</strong>
                        <span>${station.lat.toFixed(4)}, ${station.lng.toFixed(4)}</span>
                    </div>
                `;
                
                // Show with animation
                container.style.display = 'block';
                
                // Add highlight class
                setTimeout(() => {
                    container.classList.add('highlight-card');
                    setTimeout(() => {
                        container.classList.remove('highlight-card');
                    }, 1000);
                }, 100);
            }
        }
    </script>
    <style>
        /* Additional styles for the metro interface */
        .map-legend {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: rgba(255, 255, 255, 0.9);
            padding: 10px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            z-index: 500;
            font-size: 0.8rem;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }
        
        .legend-marker {
            position: static;
            transform: none;
            margin-right: 8px;
        }
        
        .highlight-card {
            animation: highlightCard 1s ease;
        }
        
        @keyframes highlightCard {
            0% { box-shadow: 0 0 0 2px var(--primary-color); }
            50% { box-shadow: 0 0 0 5px var(--primary-light); }
            100% { box-shadow: var(--shadow); }
        }
        
        .station-marker.selected {
            background-color: var(--accent-color);
            transform: translate(-50%, -50%) scale(1.5);
            box-shadow: 0 0 0 3px rgba(255, 109, 0, 0.3), var(--shadow);
        }
    </style>
</body>
</html>
