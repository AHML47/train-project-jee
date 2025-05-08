// Map scaling and positioning constants
const MAP_WIDTH = 800;
const MAP_HEIGHT = 600;
const MIN_LAT = 48.80;
const MAX_LAT = 48.92;
const MIN_LNG = 2.20;
const MAX_LNG = 2.45;

// Train markers and data
let trainMarkers = {};

// Convert geographic coordinates to pixel positions
function latLngToPixel(lat, lng) {
    const x = ((lng - MIN_LNG) / (MAX_LNG - MIN_LNG)) * MAP_WIDTH;
    const y = MAP_HEIGHT - ((lat - MIN_LAT) / (MAX_LAT - MIN_LAT)) * MAP_HEIGHT;
    return { x, y };
}

// Initialize the map and stations
function initMap() {
    // Load stations data and create markers
    fetch('metro-position?type=stations')
        .then(response => response.json())
        .then(stations => {
            const mapContainer = document.getElementById('map-container');
            
            // Add station markers
            stations.forEach(station => {
                const position = latLngToPixel(station.lat, station.lng);
                const marker = document.createElement('div');
                marker.className = 'station-marker';
                marker.style.left = position.x + 'px';
                marker.style.top = position.y + 'px';
                marker.title = station.name;
                mapContainer.appendChild(marker);
            });
            
            // Start updating train positions
            updateTrainPositions();
        })
        .catch(error => console.error('Error loading stations:', error));
}

// Update train positions on the map
function updateTrainPositions() {
    fetch('metro-position')
        .then(response => response.json())
        .then(trains => {
            trains.forEach(train => {
                const position = latLngToPixel(train.lat, train.lng);
                
                // Create or update train marker
                if (!trainMarkers[train.id]) {
                    const marker = document.createElement('div');
                    marker.className = 'train-marker';
                    marker.classList.add('line' + train.line.replace('Line ', ''));
                    marker.title = train.line + ' ID: ' + train.id;
                    document.getElementById('map-container').appendChild(marker);
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
            
            // Schedule next update
            setTimeout(updateTrainPositions, 2000);
        })
        .catch(error => console.error('Error updating trains:', error));
}

// Initialize when the document is loaded
document.addEventListener('DOMContentLoaded', initMap);