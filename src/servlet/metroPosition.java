package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MetroStation;
import model.MetroTrain;
import service.MetroService;

import org.json.*;
/**
 * Servlet implementation class metroPosition
 */
@WebServlet("/metroPosition")
public class metroPosition extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MetroService MS;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public metroPosition() {
        super();
        MS =MetroService.getInstance();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String type = request.getParameter("type");
    if ("stations".equals(type)) {
        List<MetroStation> stations = MetroService.getInstance().getAllStations();
        outputStationsAsJson(stations, response);
        return;
    }
    
    // Simulate train movements for demo purposes
    MS.simulateTrainMovements();
    
    // Get all trains
    List<MetroTrain> trains = MS.getAllTrains();
    
    // Manually create JSON format
    StringBuilder jsonBuilder = new StringBuilder();
    jsonBuilder.append("[");
    
    for (int i = 0; i < trains.size(); i++) {
        MetroTrain train = trains.get(i);
        jsonBuilder.append("{");
        jsonBuilder.append("\"id\":\"").append(escapeJson(String.valueOf(train.getId()))).append("\",");
        jsonBuilder.append("\"line\":\"").append(escapeJson(train.getLine())).append("\",");
        jsonBuilder.append("\"lat\":").append(train.getCurrentLat()).append(",");
        jsonBuilder.append("\"lng\":").append(train.getCurrentLng()).append(",");
        jsonBuilder.append("\"inMotion\":").append(train.isInMotion());
        jsonBuilder.append("}");
        
        if (i < trains.size() - 1) {
            jsonBuilder.append(",");
        }
    }
    
    jsonBuilder.append("]");
    
    // Send response
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    try (PrintWriter out = response.getWriter()) {
        out.print(jsonBuilder.toString());
    }
}

// Helper method to escape JSON strings
private String escapeJson(String input) {
    if (input == null) {
        return "";
    }
    
    return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
}

// Helper method for stations
private void outputStationsAsJson(List<MetroStation> stations, HttpServletResponse response) throws IOException {
    // Similar approach as above for stations
    // ...
	StringBuilder jsonBuilder = new StringBuilder();
    jsonBuilder.append("[");
    
    for (int i = 0; i < stations.size(); i++) {
        MetroStation station = stations.get(i);
        jsonBuilder.append("{");
        jsonBuilder.append("\"id\":").append(station.getId()).append(",");
        jsonBuilder.append("\"name\":\"").append(escapeJson(station.getName())).append("\",");
        jsonBuilder.append("\"lat\":").append(station.getLat()).append(",");
        jsonBuilder.append("\"lng\":").append(station.getLng());
        jsonBuilder.append("}");
        
        if (i < stations.size() - 1) {
            jsonBuilder.append(",");
        }
    }
    
    jsonBuilder.append("]");
    
    // Send response
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    try (PrintWriter out = response.getWriter()) {
        out.print(jsonBuilder.toString());
    }
}
    		

        
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	private void sendStationsData(HttpServletResponse response) throws IOException {
        // Get all stations
        List<MetroStation> stations = MetroService.getInstance().getAllStations();
        
        // Convert to JSON
        /*JSONArray jsonStations = new JSONArray();
        for (MetroStation station : stations) {
            JSONObject jsonStation = new JSONObject();
            
            try {
            	jsonStation.put("id", station.getId());
				jsonStation.put("name", station.getName());
				jsonStation.put("lat", station.getLat());
	            jsonStation.put("lng", station.getLng());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
            jsonStations.put(jsonStation);
        }
        
        // Send JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonStations.toString());
        }
    }*/
   //     request.setAttribute("trains", stations);
        

}
}
