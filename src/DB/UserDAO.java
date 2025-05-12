package DB;
import DB.DatabaseConnection;
import model.User;

import java.sql.*;
import java.io.IOException;

/**
 * Servlet implementation class UserDAO
 */

public class UserDAO  {
	 public static boolean registerUser(User user) {
	        String sql = "INSERT INTO users "
	                   + "(nom, prenom, email, tel, cin, direction, adresse, dob, card_number, password) "
	                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        
	        try (Connection conn = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            
	            pstmt.setString(1, user.getNom());
	            pstmt.setString(2, user.getPrenom());
	            pstmt.setString(3, user.getEmail());
	            pstmt.setString(4, user.getTel());
	            pstmt.setString(5, user.getCin());
	            pstmt.setString(6, user.getDirection());
	            pstmt.setString(7, user.getAdresse());
	            // Convert LocalDate to java.sql.Date
	            pstmt.setDate(8, Date.valueOf(user.getDob()));
	            pstmt.setString(9, user.getCardNumber());
	            pstmt.setString(10, user.getPassword());
	            
	            int rowsAffected = pstmt.executeUpdate();
	            return rowsAffected > 0;
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    
	    /**
	     * Authenticates by email & password, returns full User on success.
	     */
	    public static User loginUser(String email, String password) {
	        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
	        
	        try (Connection conn = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            
	            pstmt.setString(1, email);
	            pstmt.setString(2, password);
	            
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                User user = new User();
	                user.setId(rs.getInt("id"));
	                user.setNom(rs.getString("nom"));
	                user.setPrenom(rs.getString("prenom"));
	                user.setEmail(rs.getString("email"));
	                user.setTel(rs.getString("tel"));
	                user.setCin(rs.getString("cin"));
	                user.setDirection(rs.getString("direction"));
	                user.setAdresse(rs.getString("adresse"));
	                Date dobDate = rs.getDate("dob");
	                user.setDob(dobDate.toLocalDate());
	                user.setCardNumber(rs.getString("card_number"));
	                // password typically not set back into object for security
	                return user;
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        
	        return null;
	    }
	    
	    /**
	     * Checks whether the given email is already registered.
	     */
	    public static boolean isEmailExists(String email) {
	        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
	        
	        try (Connection conn = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            
	            pstmt.setString(1, email);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return rs.getInt(1) > 0;
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        
	        return false;
	    }
	    
	    /**
	     * (Optional) Check if a CIN is already registered.
	     */
	    public static boolean isCinExists(String cin) {
	        String sql = "SELECT COUNT(*) FROM users WHERE cin = ?";
	        
	        try (Connection conn = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            
	            pstmt.setString(1, cin);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return rs.getInt(1) > 0;
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        
	        return false;
	    }
}
