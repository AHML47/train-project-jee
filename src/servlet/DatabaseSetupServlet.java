package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.DatabaseConnection;

/**
 * Servlet to initialize database tables
 */
@WebServlet("/setup-database")
public class DatabaseSetupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public DatabaseSetupServlet() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        StringBuilder result = new StringBuilder();
        result.append("<html><body><h1>Database Setup</h1>");
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Create users table if it doesn't exist
            try (Statement stmt = conn.createStatement()) {
                String sql = "CREATE TABLE IF NOT EXISTS users (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "nom VARCHAR(100) NOT NULL, " +
                        "prenom VARCHAR(100) NOT NULL, " +
                        "email VARCHAR(100) UNIQUE NOT NULL, " +
                        "tel VARCHAR(20) NOT NULL, " +
                        "cin VARCHAR(20) UNIQUE NOT NULL, " +
                        "direction VARCHAR(200) NOT NULL, " +
                        "adresse VARCHAR(200) NOT NULL, " +
                        "dob DATE NOT NULL, " +
                        "card_number VARCHAR(50) NOT NULL, " +
                        "password VARCHAR(100) NOT NULL" +
                        ")";
                stmt.executeUpdate(sql);
                result.append("<p>Users table created/verified successfully.</p>");
            }
            
            // Create logedinuser table if it doesn't exist
            try (Statement stmt = conn.createStatement()) {
                String sql = "CREATE TABLE IF NOT EXISTS logedinuser (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "email VARCHAR(100) NOT NULL" +
                        ")";
                stmt.executeUpdate(sql);
                result.append("<p>LogedinUser table created/verified successfully.</p>");
            }
            
            result.append("<p style='color:green;'>Database setup completed successfully!</p>");
            result.append("<p><a href='metroInterfaceS'>Go to Metro Interface</a></p>");
            
        } catch (SQLException e) {
            e.printStackTrace();
            result.append("<p style='color:red;'>Error setting up database: " + e.getMessage() + "</p>");
        }
        
        result.append("</body></html>");
        response.setContentType("text/html");
        response.getWriter().write(result.toString());
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}