package service;

import model.MetroStation;
import model.MetroTrain;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MetroService {
    private static final MetroService instance = new MetroService();
    
    private Map<Integer, MetroStation> stations;
    private Map<Integer, MetroTrain> trains;
    private List<RoutePoint> routePoints; // Store the blue line path coordinates
    private Map<Integer, Integer> trainPositionIndices; // Track each train's position on the route
    private Map<Integer, Integer> trainDirections; // Track each train's travel direction (+1 southwards, -1 northwards)
    
    private MetroService() {
        // Initialize with sample data
        initSampleData();
    }
    
    public static MetroService getInstance() {
        return instance;
    }
    
    private void initSampleData() {
        // Initialize the route points (coordinates of the blue line)
        initRoutePoints();
        
        // Initialize stations based on the Tunisian coastal route
        stations = new HashMap<>();
        stations.put(1, new MetroStation(1, "Sousse Bab Jedid", 36.365, 10.642));
        stations.put(2, new MetroStation(2, "Sousse Sud", 36.350, 10.651));
        stations.put(3, new MetroStation(3, "Sahline", 36.325, 10.656));
        stations.put(4, new MetroStation(4, "Hôtels", 36.320, 10.665));
        stations.put(5, new MetroStation(5, "Aéroport", 36.328, 10.675));
        stations.put(6, new MetroStation(6, "Monastir", 36.330, 10.685));
        stations.put(7, new MetroStation(7, "Khniss-Bembla", 36.309, 10.684));
        stations.put(8, new MetroStation(8, "Ksibet Mediouni", 36.292, 10.685));
        stations.put(9, new MetroStation(9, "Lamta", 36.279, 10.693));
        stations.put(10, new MetroStation(10, "Bouhjar", 36.285, 10.689));
        stations.put(11, new MetroStation(11, "Sayada", 36.274, 10.698));
        stations.put(12, new MetroStation(12, "Ksar Helal", 36.266, 10.703));
        stations.put(13, new MetroStation(13, "Moknine", 36.265, 10.708));
        stations.put(14, new MetroStation(14, "Téboulba", 36.265, 10.718));
        stations.put(15, new MetroStation(15, "Bekalta", 36.250, 10.726));
        stations.put(16, new MetroStation(16, "Zone Touristique", 36.232, 10.728));
        stations.put(17, new MetroStation(17, "Mahdia", 36.198, 10.735));
        
        // Initialize trains at specified stations
        trains = new HashMap<>();
        trainPositionIndices = new HashMap<>();
        trainDirections = new HashMap<>();
        
        // Precomputed routePoint indices for key stations:
        // Sousse Bab Jedid -> index 0
        // Moknine         -> index 191
        // Bekalta         -> index 223
        int idxSousse = 0;
        int idxMoknine = 191;
        int idxBekalta = 223;
        
        // Train 101 starts at Sousse Bab Jedid, heading south (+1)
        trains.put(101, new MetroTrain(101, "SahelLine",
                routePoints.get(idxSousse).lat,
                routePoints.get(idxSousse).lng,
                1, true));
        trainPositionIndices.put(101, idxSousse);
        trainDirections.put(101, 1);
        
        // Train 102 starts at Moknine, heading south (+1)
        trains.put(102, new MetroTrain(102, "SahelLine",
                routePoints.get(idxMoknine).lat,
                routePoints.get(idxMoknine).lng,
                1, true));
        trainPositionIndices.put(102, idxMoknine);
        trainDirections.put(102, 1);
        
        // Train 103 starts at Bekalta, heading south (+1)
        trains.put(103, new MetroTrain(103, "SahelLine",
                routePoints.get(idxBekalta).lat,
                routePoints.get(idxBekalta).lng,
                1, true));
        trainPositionIndices.put(103, idxBekalta);
        trainDirections.put(103, 1);
    }
    
    private void initRoutePoints() {
        routePoints = new ArrayList<>();
        // Define segments as before...
        addRouteSegment(36.365, 10.642 , 36.350, 10.651 , 15);
        addRouteSegment(36.350, 10.651 , 36.325, 10.656, 15);
        addRouteSegment(36.325, 10.656, 36.320,10.665, 15);
        addRouteSegment(36.320,10.665, 36.328, 10.675, 15);
        addRouteSegment(36.328, 10.675, 36.330, 10.685, 15);
        addRouteSegment(36.330, 10.685, 36.309, 10.684, 15);
        addRouteSegment(36.309, 10.684, 36.292, 10.685, 15);
        addRouteSegment(36.292, 10.685, 36.285, 10.689, 15);
        addRouteSegment(36.285, 10.689, 36.279, 10.693, 15);
        addRouteSegment(36.279, 10.693, 36.274, 10.698, 15);
        addRouteSegment(36.274, 10.698, 36.266, 10.703, 15);
        addRouteSegment(36.266, 10.703, 36.265, 10.708, 15);
        addRouteSegment(36.265, 10.708, 36.265, 10.718, 15);
        addRouteSegment(36.265, 10.718, 36.250,10.726, 15);
        addRouteSegment(36.250,10.726, 36.232, 10.728, 15);
        addRouteSegment(36.232, 10.728, 36.198, 10.735, 15);
    }
    
    private void addRouteSegment(double startLat, double startLng, double endLat, double endLng, int points) {
        double latStep = (endLat - startLat) / points;
        double lngStep = (endLng - startLng) / points;
        for (int i = 0; i <= points; i++) {
            double lat = startLat + (latStep * i);
            double lng = startLng + (lngStep * i);
            routePoints.add(new RoutePoint(lat, lng));
        }
    }
    
    public List<MetroStation> getAllStations() {
        return new ArrayList<>(stations.values());
    }
    
    public List<MetroTrain> getAllTrains() {
        return new ArrayList<>(trains.values());
    }
    
    public void updateTrainPosition(int trainId, double lat, double lng) {
        if (trains.containsKey(trainId)) {
            MetroTrain train = trains.get(trainId);
            train.setCurrentLat(lat);
            train.setCurrentLng(lng);
            trains.put(trainId, train);
        }
    }
    
    // For simulation purposes - makes trains follow the blue line and reverse at endpoints
    public void simulateTrainMovements() {
        for (MetroTrain train : trains.values()) {
            if (train.isInMotion()) {
                int trainId = train.getId();
                int currentIndex = trainPositionIndices.get(trainId);
                int direction = trainDirections.get(trainId);
                
                // Check for endpoint and reverse if needed
                if (currentIndex + direction >= routePoints.size() || currentIndex + direction < 0) {
                    direction = -direction; // reverse direction
                    trainDirections.put(trainId, direction);
                }
                
                // Move to next point based on direction
                currentIndex += direction;
                RoutePoint nextPoint = routePoints.get(currentIndex);
                
                // Update train position
                train.setCurrentLat(nextPoint.lat);
                train.setCurrentLng(nextPoint.lng);
                
                // Save updated index
                trainPositionIndices.put(trainId, currentIndex);
            }
        }
    }
    
    // Inner class to represent a point on the route
    private class RoutePoint {
        double lat;
        double lng;
        public RoutePoint(double lat, double lng) {
            this.lat = lat;
            this.lng = lng;
        }
    }
}