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
		// TODO Auto-generated method stub
		String type = request.getParameter("type");
        if ("stations".equals(type)) {
            sendStationsData(response);
            return;
        }
        
        // Otherwise, send train positions
        
        // Simulate train movements for demo purposes
        
        MS.simulateTrainMovements();
        
        // Get all trains
        List<MetroTrain> trains = MS.getAllTrains();
        
        // Convert to JSON
        JSONArray jsonTrains = new JSONArray();
        for (MetroTrain train : trains) {
            JSONObject jsonTrain = new JSONObject();
            try {
				jsonTrain.put("id", train.getId());
				jsonTrain.put("line", train.getLine());
	            jsonTrain.put("lat", train.getCurrentLat());
	            jsonTrain.put("lng", train.getCurrentLng());
	            jsonTrain.put("inMotion", train.isInMotion());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
            jsonTrains.put(jsonTrain);
        }
        
        // Send JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonTrains.toString());
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
        JSONArray jsonStations = new JSONArray();
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
    }

}
