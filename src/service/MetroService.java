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
    
    private MetroService() {
        // Initialize with sample data
        initSampleData();
    }
    
    public static MetroService getInstance() {
        return instance;
    }
    
    private void initSampleData() {
        // Initialize stations
        stations = new HashMap<>();
        stations.put(1, new MetroStation(1, "Gare du Nord", 48.8809, 2.3553));
        stations.put(2, new MetroStation(2, "Châtelet", 48.8586, 2.3491));
        stations.put(3, new MetroStation(3, "Montparnasse", 48.8421, 2.3219));
        stations.put(4, new MetroStation(4, "Nation", 48.8484, 2.3965));
        stations.put(5, new MetroStation(5, "La Défense", 48.8918, 2.2362));
        
        // Initialize trains
        trains = new HashMap<>();
        trains.put(101, new MetroTrain(101, "Line 1", 48.8809, 2.3553, 2, true));
        trains.put(102, new MetroTrain(102, "Line 4", 48.8421, 2.3219, 2, false));
        trains.put(103, new MetroTrain(103, "Line 6", 48.8484, 2.3965, 3, true));
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
    
    // For simulation purposes
    public void simulateTrainMovements() {
        // In a real app, this would update based on actual data
        for (MetroTrain train : trains.values()) {
            if (train.isInMotion()) {
                // Simulate small movement in random direction
                double latChange = (Math.random() - 0.5) * 0.001;
                double lngChange = (Math.random() - 0.5) * 0.001;
                train.setCurrentLat(train.getCurrentLat() + latChange);
                train.setCurrentLng(train.getCurrentLng() + lngChange);
            }
        }
    }
}