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
        
        // Initialize stations based on the Tunisian coastal route shown in the image     Y/X
        stations = new HashMap<>();
        stations.put(1, new MetroStation(1, "Sousse Bab Jedid", 36.365, 10.642));
        stations.put(2, new MetroStation(2, "Sousse Sud", 36.350, 10.651));
        stations.put(3, new MetroStation(3, "Sahline", 36.325, 10.656));
        stations.put(4, new MetroStation(4, "Hôtels", 36.320,10.665));
        stations.put(5, new MetroStation(5, "Aéroport", 36.328, 10.675));
        stations.put(6, new MetroStation(6, "Monastir", 36.330, 10.685));
        stations.put(7, new MetroStation(7, "Khniss-Bembla", 36.309, 10.684));
        stations.put(8, new MetroStation(8, "Ksibet Mediouni", 36.292, 10.685));
        stations.put(9, new MetroStation(9, "Lamta", 36.279, 10.693));
        stations.put(10, new MetroStation(10, "Bouhjar", 36.285, 10.689));
        stations.put(11, new MetroStation(11, "Sayada", 36.274, 10.698));
        stations.put(12, new MetroStation(12, "Ksar Helal", 36.266, 10.703));
        stations.put(13, new MetroStation(13, "Moknine", 36.230, 10.730));
        stations.put(14, new MetroStation(14, "Téboulba", 36.215, 10.740));
        stations.put(15, new MetroStation(15, "Bekalta",36.200,10.750));
        stations.put(16, new MetroStation(16, "Zone Touristique", 36.185, 10.760));
        stations.put(17, new MetroStation(17, "Mahdia", 36.170, 10.770));
        
        // Initialize trains at different positions along the route
        // Use line names WITHOUT spaces to avoid DOM token errors in JavaScript
        trains = new HashMap<>();
        trains.put(101, new MetroTrain(101, "SahelLine", routePoints.get(0).lat, routePoints.get(0).lng, 1, true));
        trains.put(102, new MetroTrain(102, "SahelLine", routePoints.get(30).lat, routePoints.get(30).lng, 1, true));
        trains.put(103, new MetroTrain(103, "SahelLine", routePoints.get(60).lat, routePoints.get(60).lng, 1, true));
        
        // Initialize the position indices for each train
        trainPositionIndices = new HashMap<>();
        trainPositionIndices.put(101, 0);    // Train 101 starts at the beginning of the route
        trainPositionIndices.put(102, 30);   // Train 102 starts in the middle
        trainPositionIndices.put(103, 60);   // Train 103 starts near the end
    }
    
    private void initRoutePoints() {
        // Create a sequence of coordinates that represents the blue line in the image
        routePoints = new ArrayList<>();
        
        // Define the blue line path with lat/lng coordinates
        // The points are estimated based on the image - in a real application, you would use precise coordinates
        
        // Sousse to Mahdia - coastal route as per the image
        // Approximate coordinates for the blue line route from north to south
        // Starting from Sousse Bab Jedid
        addRouteSegment(36.400, 10.639, 36.395, 10.641, 50); // Sousse Bab Jedid to Sousse Sud
        addRouteSegment(36.395, 10.641, 36.380, 10.645, 50); // Sousse Sud to Sahline
        addRouteSegment(36.380, 10.645, 36.365, 10.650, 50); // Sahline to Hôtels
        addRouteSegment(36.365, 10.650, 36.350, 10.655, 50); // Hôtels to Aéroport
        addRouteSegment(36.350, 10.655, 36.335, 10.660, 50); // Aéroport to Monastir
        addRouteSegment(36.335, 10.660, 36.320, 10.670, 50); // Monastir to Khniss-Bembla
        addRouteSegment(36.320, 10.670, 36.305, 10.680, 50); // Khniss-Bembla to Ksibet Mediouni
        addRouteSegment(36.305, 10.680, 36.290, 10.690, 50); // Ksibet Mediouni to Lamta
        addRouteSegment(36.290, 10.690, 36.275, 10.700, 50); // Lamta to Bouhjar
        addRouteSegment(36.275, 10.700, 36.260, 10.710, 50); // Bouhjar to Sayada
        addRouteSegment(36.260, 10.710, 36.245, 10.720, 50); // Sayada to Ksar Helal
        addRouteSegment(36.245, 10.720, 36.230, 10.730, 50); // Ksar Helal to Moknine
        addRouteSegment(36.230, 10.730, 36.215, 10.740, 50); // Moknine to Téboulba
        addRouteSegment(36.215, 10.740, 36.200, 10.750, 50); // Téboulba to Bekalta
        addRouteSegment(36.200, 10.750, 36.185, 10.760, 50); // Bekalta to Zone Touristique
        addRouteSegment(36.185, 10.760, 36.170, 10.770, 50); // Zone Touristique to Mahdia
    }
    
    private void addRouteSegment(double startLat, double startLng, double endLat, double endLng, int points) {
        // Divides a line segment into the specified number of points
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
    
    // For simulation purposes - makes trains follow the blue line
    public void simulateTrainMovements() {
        for (MetroTrain train : trains.values()) {
            if (train.isInMotion()) {
                int trainId = train.getId();
                int currentIndex = trainPositionIndices.get(trainId);
                
                // Move to the next point on the route
                currentIndex = (currentIndex + 1) % routePoints.size();
                RoutePoint nextPoint = routePoints.get(currentIndex);
                
                // Update train position
                train.setCurrentLat(nextPoint.lat);
                train.setCurrentLng(nextPoint.lng);
                
                // Save the new position index
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