<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Metro Tracking System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/design-system.css">
    <link rel="stylesheet" href="css/components.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--primary-100), var(--neutral-200));
            display: flex;
            flex-direction: column;
            font-family: var(--font-primary);
            margin: 0;
            padding-top: 80px; /* Account for fixed navbar */
        }

        .page-header {
            text-align: center;
            margin-bottom: var(--spacing-2xl);
            animation: slideDown var(--transition-normal);
        }

        .page-header h1 {
            font-size: var(--text-3xl);
            color: var(--neutral-900);
            margin-bottom: var(--spacing-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: var(--spacing-sm);
        }

        .page-header p {
            color: var(--neutral-600);
            font-size: var(--text-lg);
            max-width: 600px;
            margin: 0 auto;
        }

        .map-card {
            background: var(--neutral-100);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-xl);
            overflow: hidden;
            margin-bottom: var(--spacing-2xl);
            animation: slideUp var(--transition-normal);
        }

        #map-container {
            position: relative;
            width: 100%;
            height: 600px;
            overflow: hidden;
            border-radius: var(--radius-lg);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #metro-map {
            width: 100%;
            height: 100%;
            position: relative;
        }

        .map-controls {
            position: absolute;
            top: var(--spacing-md);
            right: var(--spacing-md);
            display: flex;
            gap: var(--spacing-sm);
            z-index: 10;
        }

        .map-control-btn {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border: none;
            border-radius: var(--radius-md);
            padding: var(--spacing-sm) var(--spacing-md);
            color: var(--neutral-800);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            font-size: var(--text-sm);
            font-weight: 500;
            transition: all var(--transition-fast);
        }

        .map-control-btn:hover {
            background: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .map-legend {
            position: absolute;
            bottom: var(--spacing-md);
            right: var(--spacing-md);
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-md);
        }

        .legend-title {
            font-weight: 600;
            color: var(--neutral-800);
            margin-bottom: var(--spacing-sm);
            font-size: var(--text-sm);
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-xs);
            font-size: var(--text-sm);
            color: var(--neutral-700);
        }

        .legend-marker {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            border: 2px solid white;
            box-shadow: var(--shadow-sm);
        }

        .train-marker {
            background: var(--success);
            animation: pulse 2s infinite;
        }

        .station-marker {
            background: var(--primary-600);
        }

        .station-info-card {
            background: var(--neutral-100);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            padding: var(--spacing-xl);
            margin-top: var(--spacing-xl);
            animation: slideUp var(--transition-normal);
        }

        .station-info-header {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-md);
            border-bottom: 1px solid var(--neutral-200);
        }

        .station-info-icon {
            width: 40px;
            height: 40px;
            background: var(--primary-100);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-600);
            font-size: var(--text-xl);
        }

        .station-info-title {
            margin: 0;
            font-size: var(--text-xl);
            color: var(--neutral-900);
        }

        .station-detail {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-md);
            padding: var(--spacing-md);
            background: var(--neutral-50);
            border-radius: var(--radius-md);
            transition: all var(--transition-fast);
        }

        .station-detail:hover {
            background: var(--primary-50);
            transform: translateX(var(--spacing-xs));
        }

        .station-detail i {
            color: var(--primary-600);
            font-size: var(--text-lg);
        }

        .station-detail-content {
            flex: 1;
        }

        .station-detail-label {
            font-size: var(--text-sm);
            color: var(--neutral-600);
            margin-bottom: var(--spacing-xs);
        }

        .station-detail-value {
            font-size: var(--text-base);
            color: var(--neutral-900);
            font-weight: 500;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(82, 196, 26, 0.4);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(82, 196, 26, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(82, 196, 26, 0);
            }
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-lg);
            background: var(--neutral-50);
            border-top: 1px solid var(--neutral-200);
        }

        .control-group {
            display: flex;
            gap: var(--spacing-md);
        }

        .highlight-card {
            animation: highlightCard var(--transition-normal);
        }

        @keyframes highlightCard {
            0% { box-shadow: 0 0 0 2px var(--primary-600); }
            50% { box-shadow: 0 0 0 5px var(--primary-100); }
            100% { box-shadow: var(--shadow-lg); }
        }

        /* Station and Train Markers - Add these styles */
        .station-marker {
            position: absolute;
            width: 14px;
            height: 14px;
            background-color: var(--primary-600);
            border-radius: 50%;
            border: 3px solid white;
            transform: translate(-50%, -50%);
            z-index: 50;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s ease, box-shadow 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .station-marker:hover {
            transform: translate(-50%, -50%) scale(1.5);
            background-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(255, 109, 0, 0.3), var(--shadow);
        }

        .station-marker.selected {
            background-color: var(--error);
            transform: translate(-50%, -50%) scale(1.5);
            box-shadow: 0 0 0 4px rgba(255, 77, 79, 0.3);
        }

        .train-marker {
            position: absolute;
            width: 20px;
            height: 20px;
            background-color: var(--success);
            border-radius: 50%;
            border: 3px solid white;
            transform: translate(-50%, -50%);
            z-index: 100;
            box-shadow: var(--shadow-sm);
            transition: transform 1s ease;
        }

        .train-marker.in-motion {
            animation: trainPulse 1.5s infinite alternate;
        }

        .train-tooltip {
            position: absolute;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            font-size: 12px;
            white-space: nowrap;
            transform: translateY(-30px);
            opacity: 0;
            transition: opacity 0.3s;
            pointer-events: none;
            z-index: 101;
        }

        @keyframes trainPulse {
            from {
                transform: translate(-50%, -50%) scale(1);
                box-shadow: 0 0 0 3px white, 0 0 10px rgba(0, 0, 0, 0.5);
            }
            to {
                transform: translate(-50%, -50%) scale(1.3);
                box-shadow: 0 0 0 3px white, 0 0 20px rgba(0, 0, 0, 0.7);
            }
        }

        .station-label {
            position: absolute;
            font-size: 11px;
            white-space: nowrap;
            background: rgba(255, 255, 255, 0.9);
            padding: 4px 8px;
            border-radius: var(--radius-sm);
            transform: translate(-50%, 10px);
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s ease, transform 0.3s ease;
            box-shadow: var(--shadow-sm);
            z-index: 40;
        }

        .station-marker:hover + .station-label {
            opacity: 1;
            transform: translate(-50%, 15px);
        }

        #loading-indicator {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.9);
            padding: var(--spacing-lg);
            border-radius: var(--radius-md);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: var(--spacing-md);
            z-index: 1000;
            box-shadow: var(--shadow-md);
        }

        #loading-indicator .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid var(--neutral-300);
            border-top: 4px solid var(--primary-600);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="metroInterfaceS" class="logo">
            <i class="fas fa-train floating-icon"></i> Sahel Metro
        </a>
        <ul class="nav-links">
            <li><a href="metroInterfaceS" class="hover-scale"><i class="fas fa-map-marked-alt"></i> Map</a></li>
            <li><a href="#" class="hover-scale"><i class="fas fa-info-circle"></i> About</a></li>
            <li><a href="#" class="hover-scale"><i class="fas fa-phone"></i> Contact</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>
                <i class="fas fa-map-marker-alt text-gradient"></i>
                <span class="text-gradient">Live Metro Tracking</span>
            </h1>
            <p>Track metro trains in real-time across the Sahel region</p>
        </div>
        
        <div class="map-card hover-lift">
            <div id="map-container">
                <img id="metro-map" src="https://www.skyscrapercity.com/cdn-cgi/image/format=auto,onerror=redirect,width=1920,height=1920,fit=scale-down/https://www.skyscrapercity.com/attachments/screenshot-2024-01-24-at-12-05-57-pm-png.6594050/" alt="Metro Map">
                
                <div class="map-controls">
                    <button id="refresh-btn" class="map-control-btn" onclick="updateTrainPositions()">
                        <i class="fas fa-sync-alt"></i>
                        <span>Refresh</span>
                    </button>
                    
                    <a href="${buttonLink}">
                        <button class="map-control-btn">
                            <i class="${buttonText == 'Generate Carte' ? 'fas fa-id-card' : 'fas fa-user-plus'}"></i>
                            <span>${buttonText != null ? buttonText : "Sign Up"}</span>
                        </button>
                    </a>
                    
                    <% if(session.getAttribute("user") != null) { %>
                    <a href="logout">
                        <button class="map-control-btn">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </button>
                    </a>
                    <% } %>
                </div>
                
                <div class="map-legend">
                    <div class="legend-title">Map Legend</div>
                    <div class="legend-item">
                        <div class="legend-marker train-marker"></div>
                        <span>Active Train</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-marker station-marker"></div>
                        <span>Metro Station</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="station-info-card" id="station-info-container" style="display: none;">
            <div class="station-info-header">
                <div class="station-info-icon">
                    <i class="fas fa-subway"></i>
                </div>
                <h3 class="station-info-title">Station Information</h3>
            </div>
            <div id="station-info">
                <!-- Station information will be dynamically inserted here -->
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h4>Sahel Metro</h4>
                <p>Your trusted partner for modern metro transportation in the Sahel region.</p>
            </div>
            <div class="footer-section">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="metroInterfaceS">Live Map</a></li>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h4>Contact Us</h4>
                <ul class="footer-links">
                    <li><i class="fas fa-phone"></i> +216 XX XXX XXX</li>
                    <li><i class="fas fa-envelope"></i> contact@sahelmetro.tn</li>
                    <li><i class="fas fa-map-marker-alt"></i> Sousse, Tunisia</li>
                </ul>
            </div>
        </div>
    </footer>
    
    <script src="js/metro-map.js"></script>
    <script>
        function showStationInfo(station) {
            const infoDiv = document.getElementById('station-info');
            const container = document.getElementById('station-info-container');
            
            if (infoDiv) {
                infoDiv.innerHTML = `
                    <div class="station-detail hover-scale">
                        <i class="fas fa-map-marker-alt"></i>
                        <div class="station-detail-content">
                            <div class="station-detail-label">Station Name</div>
                            <div class="station-detail-value">${station.name}</div>
                        </div>
                    </div>
                    
                    <div class="station-detail hover-scale">
                        <i class="fas fa-hashtag"></i>
                        <div class="station-detail-content">
                            <div class="station-detail-label">Station ID</div>
                            <div class="station-detail-value">${station.id}</div>
                        </div>
                    </div>
                    
                    <div class="station-detail hover-scale">
                        <i class="fas fa-location-arrow"></i>
                        <div class="station-detail-content">
                            <div class="station-detail-label">Coordinates</div>
                            <div class="station-detail-value">${station.lat.toFixed(4)}, ${station.lng.toFixed(4)}</div>
                        </div>
                    </div>
                `;
                
                container.style.display = 'block';
                container.classList.add('highlight-card');
                
                setTimeout(() => {
                    container.classList.remove('highlight-card');
                }, 1000);
            }
        }

        // Add loading animation to refresh button
        document.getElementById('refresh-btn').addEventListener('click', function() {
            const btn = this;
            const icon = btn.querySelector('i');
            const text = btn.querySelector('span');
            
            // Add spinning animation
            icon.classList.add('fa-spin');
            text.textContent = 'Refreshing...';
            btn.disabled = true;
            
            // Remove spinning after 1 second
            setTimeout(() => {
                icon.classList.remove('fa-spin');
                text.textContent = 'Refresh';
                btn.disabled = false;
            }, 1000);
        });
    </script>
</body>
</html>
