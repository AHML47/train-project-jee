// Map scaling and positioning constants
const MAP_WIDTH = 800;
const MAP_HEIGHT = 600;

// Tunisia map coordinates (based on the coastal route)
const MIN_LAT = 36.16;  // Southern limit near Mahdia
const MAX_LAT = 36.41;  // Northern limit near Sousse
const MIN_LNG = 10.63;  // Western limit
const MAX_LNG = 10.78;  // Eastern limit

// Train markers and data
let trainMarkers = {};
let stationMarkers = {};
let updateInterval = null;

// Convert geographic coordinates to pixel positions
function latLngToPixel(lat, lng) {
    const x = ((lng - MIN_LNG) / (MAX_LNG - MIN_LNG)) * MAP_WIDTH;
    const y = MAP_HEIGHT - ((lat - MIN_LAT) / (MAX_LAT - MIN_LAT)) * MAP_HEIGHT;
    return { x, y };
}

// Initialize the map and stations
function initMap() {
    // Loading indicator
    showLoadingIndicator();
    
    // Load stations data and create markers
    fetch('metroPosition?type=stations')
        .then(response => response.json())
        .then(stations => {
            const mapContainer = document.getElementById('map-container');
            
            // Add station markers
            stations.forEach(station => {
                const position = latLngToPixel(station.lat, station.lng);
                
                // Create station marker
                const marker = document.createElement('div');
                marker.className = 'station-marker';
                marker.style.left = position.x + 'px';
                marker.style.top = position.y + 'px';
                marker.title = station.name;
                
                // Add click event to show station info with animation
                marker.addEventListener('click', () => {
                    // Highlight selected station
                    document.querySelectorAll('.station-marker').forEach(m => {
                        m.classList.remove('selected');
                    });
                    marker.classList.add('selected');
                    
                    // Show station info with animation
                    showStationInfo(station);
                    
                    // Scroll to station info if it's not visible
                    const infoContainer = document.getElementById('station-info-container');
                    if (infoContainer && !isElementInViewport(infoContainer)) {
                        infoContainer.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                    }
                });
                
                mapContainer.appendChild(marker);
                stationMarkers[station.id] = marker;
                
                // Add station label
                const label = document.createElement('div');
                label.className = 'station-label';
                label.textContent = station.name;
                label.style.left = position.x + 'px';
                label.style.top = (position.y + 20) + 'px';
                mapContainer.appendChild(label);
            });
            
            // Start updating train positions
            updateTrainPositions();
            hideLoadingIndicator();
        })
        .catch(error => {
            console.error('Error loading stations:', error);
            hideLoadingIndicator();
            showErrorMessage('Failed to load station data. Please try again later.');
        });
}

// Check if element is visible in viewport
function isElementInViewport(el) {
    const rect = el.getBoundingClientRect();
    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
}

// Show loading indicator
function showLoadingIndicator() {
    // Create loading indicator if it doesn't exist
    if (!document.getElementById('loading-indicator')) {
        const loader = document.createElement('div');
        loader.id = 'loading-indicator';
        loader.innerHTML = `
            <div class="spinner"></div>
            <p>Loading map data...</p>
        `;
        
        document.getElementById('map-container').appendChild(loader);
    }
}

// Hide loading indicator
function hideLoadingIndicator() {
    const loader = document.getElementById('loading-indicator');
    if (loader) {
        // Add fade-out animation
        loader.style.opacity = '0';
        setTimeout(() => loader.remove(), 300);
    }
}

// Show error message
function showErrorMessage(message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-message';
    errorDiv.style.position = 'absolute';
    errorDiv.style.top = '50%';
    errorDiv.style.left = '50%';
    errorDiv.style.transform = 'translate(-50%, -50%)';
    errorDiv.style.background = '#ffdddd';
    errorDiv.style.color = '#d9534f';
    errorDiv.style.padding = '15px';
    errorDiv.style.borderRadius = '8px';
    errorDiv.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';
    errorDiv.style.zIndex = '1000';
    errorDiv.style.textAlign = 'center';
    errorDiv.style.maxWidth = '80%';
    
    errorDiv.innerHTML = `
        <i class="fas fa-exclamation-circle" style="font-size: 24px; margin-bottom: 10px;"></i>
        <p>${message}</p>
        <button onclick="this.parentNode.remove()" 
                style="margin-top: 10px; padding: 8px 16px; background: #d9534f; 
                color: white; border: none; border-radius: 4px; cursor: pointer;">
            Close
        </button>
    `;
    
    document.getElementById('map-container').appendChild(errorDiv);
}

// Update train positions on the map
function updateTrainPositions() {
    const refreshBtn = document.getElementById('refresh-btn');
    if (refreshBtn) {
        refreshBtn.disabled = true;
        refreshBtn.innerHTML = '<i class="fas fa-sync-alt fa-spin"></i> Updating...';
    }
    
    fetch('metroPosition')
        .then(response => response.json())
        .then(trains => {
            updateTrainsOnMap(trains);
            
            if (refreshBtn) {
                refreshBtn.disabled = false;
                refreshBtn.innerHTML = '<i class="fas fa-sync-alt"></i> Refresh Positions';
            }
            
            // Set a timeout for the next update
            setTimeout(updateTrainPositions, 2000);
        })
        .catch(error => {
            console.error('Error updating trains:', error);
            if (refreshBtn) {
                refreshBtn.disabled = false;
                refreshBtn.innerHTML = '<i class="fas fa-sync-alt"></i> Refresh Positions';
            }
            
            // Try again after delay even if there was an error
            setTimeout(updateTrainPositions, 5000);
        });
}

// Update train markers on the map
function updateTrainsOnMap(trains) {
    const mapContainer = document.getElementById('map-container');
    
    trains.forEach(train => {
        // Get coordinates from train data, handling different property names
        const lat = train.currentLat || train.lat;
        const lng = train.currentLng || train.lng;
        const position = latLngToPixel(lat, lng);
        
        // Create or update train marker
        if (!trainMarkers[train.id]) {
            const marker = document.createElement('div');
            marker.className = 'train-marker';
            
            // Fix: Convert line name to valid CSS class name by removing spaces and special characters
            const lineClass = 'line-' + train.line.toLowerCase().replace(/[^a-z0-9]/g, '-');
            marker.classList.add(lineClass);
            
            marker.title = `${train.line} - Train ID: ${train.id}`;
            
            // Add tooltip span
            const tooltip = document.createElement('span');
            tooltip.className = 'train-tooltip';
            tooltip.textContent = marker.title;
            tooltip.style.position = 'absolute';
            tooltip.style.top = '-30px';
            tooltip.style.left = '50%';
            tooltip.style.transform = 'translateX(-50%)';
            tooltip.style.opacity = '0';
            tooltip.style.transition = 'opacity 0.2s ease';
            tooltip.style.pointerEvents = 'none';
            
            marker.appendChild(tooltip);
            
            // Add hover effect
            marker.addEventListener('mouseenter', () => {
                tooltip.style.opacity = '1';
            });
            
            marker.addEventListener('mouseleave', () => {
                tooltip.style.opacity = '0';
            });
            
            mapContainer.appendChild(marker);
            trainMarkers[train.id] = marker;
        }
        
        // Update position with smooth transition
        const marker = trainMarkers[train.id];
        marker.style.left = position.x + 'px';
        marker.style.top = position.y + 'px';
        
        // Add animation class if in motion
        if (train.inMotion) {
            marker.classList.add('in-motion');
        } else {
            marker.classList.remove('in-motion');
        }
    });
}

// Start periodic updates
function startSimulation() {
    if (!updateInterval) {
        updateInterval = setInterval(updateTrainPositions, 2000);
    }
}

// Stop periodic updates
function stopSimulation() {
    if (updateInterval) {
        clearInterval(updateInterval);
        updateInterval = null;
    }
}

// Reset trains to initial positions
function resetTrains() {
    fetch('metroPosition?reset=true')
        .then(response => response.json())
        .then(trains => {
            updateTrainsOnMap(trains);
        })
        .catch(error => console.error('Error resetting trains:', error));
}

// Show information about a station
function showStationInfo(station) {
    // This function is now defined in the metro-interface.jsp file
    if (window.showStationInfo) {
        window.showStationInfo(station);
    }
}

// Initialize when the document is loaded
document.addEventListener('DOMContentLoaded', initMap);