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
    // Load stations data and create markers
   /* fetch('metroPosition?type=stations')
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
                
                // Add click event to show station info
                marker.addEventListener('click', () => {
                    showStationInfo(station);
                });
                
                mapContainer.appendChild(marker);
                stationMarkers[station.id] = marker;
                
                // Add station label
                const label = document.createElement('div');
                label.className = 'station-label';
                label.textContent = station.name;
                label.style.left = position.x + 'px';
                label.style.top = position.y + 'px';
                mapContainer.appendChild(label);
            });
            
            // Start updating train positions
            updateTrainPositions();
        })
        .catch(error => console.error('Error loading stations:', error));
*/}

// Update train positions on the map
function updateTrainPositions() {
    fetch('metroPosition')
        .then(response => response.json())
        .then(trains => {
            updateTrainsOnMap(trains);
            setTimeout(updateTrainPositions, 2000);
        })
        .catch(error => console.error('Error updating trains:', error));
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
            
            marker.title = train.line + ' ID: ' + train.id;
            mapContainer.appendChild(marker);
            trainMarkers[train.id] = marker;
        }
        
        // Update position
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
    const infoDiv = document.getElementById('station-info');
    if (infoDiv) {
        infoDiv.innerHTML = `
            <p><strong>Station:</strong> ${station.name}</p>
            <p><strong>ID:</strong> ${station.id}</p>
            <p><strong>Coordinates:</strong> ${station.lat.toFixed(4)}, ${station.lng.toFixed(4)}</p>
        `;
    }
}

// Initialize when the document is loaded
document.addEventListener('DOMContentLoaded', initMap);