package model;

public class MetroTrain {
	  private int id;
	    private String line;
	    private double currentLat;
	    private double currentLng;
	    private int nextStationId;
	    private boolean inMotion;
	    
	    public MetroTrain(int id, String line, double currentLat, double currentLng, int nextStationId, boolean inMotion) {
	        this.id = id;
	        this.line = line;
	        this.currentLat = currentLat;
	        this.currentLng = currentLng;
	        this.nextStationId = nextStationId;
	        this.inMotion = inMotion;
	    }
	    
	    // Getters and setters
	    public int getId() { return id; }
	    public void setId(int id) { this.id = id; }
	    
	    public String getLine() { return line; }
	    public void setLine(String line) { this.line = line; }
	    
	    public double getCurrentLat() { return currentLat; }
	    public void setCurrentLat(double currentLat) { this.currentLat = currentLat; }
	    
	    public double getCurrentLng() { return currentLng; }
	    public void setCurrentLng(double currentLng) { this.currentLng = currentLng; }
	    
	    public int getNextStationId() { return nextStationId; }
	    public void setNextStationId(int nextStationId) { this.nextStationId = nextStationId; }
	    
	    public boolean isInMotion() { return inMotion; }
	    public void setInMotion(boolean inMotion) { this.inMotion = inMotion; }
}
