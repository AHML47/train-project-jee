package service;


import model.MetroStation;
import model.MetroTrain;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

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
        stations = new HashMap<>();
        trains = new HashMap<>();
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM stations")) {
            while (rs.next()) {
                stations.put(rs.getInt("id"), new MetroStation(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getDouble("lat"),
                    rs.getDouble("lng")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM trains")) {
            while (rs.next()) {
                trains.put(rs.getInt("id"), new MetroTrain(
                    rs.getInt("id"),
                    rs.getString("line"),
                    rs.getDouble("lat"),
                    rs.getDouble("lng"),
                    rs.getInt("next_station"),
                    rs.getBoolean("in_motion")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
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
            
            try (Connection conn = getConnection();
                 PreparedStatement pstmt = conn.prepareStatement("UPDATE trains SET lat = ?, lng = ? WHERE id = ?")) {
                pstmt.setDouble(1, lat);
                pstmt.setDouble(2, lng);
                pstmt.setInt(3, trainId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
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

    public Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/metrodb";
        String user = "root";
        String password = "";
        return DriverManager.getConnection(url, user, password);
    }

    
}