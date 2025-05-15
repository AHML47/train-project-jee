// src/dao/UserDAO.java
package DB;

import DB.DatabaseConnection;
import model.User;

import java.sql.*;
import java.time.LocalDate;

public class UserDAO {

    /** Enregistre un nouvel utilisateur dans la base */
    public static boolean registerUser(User user) {
        String sql = "INSERT INTO users (nom, prenom, email, tel, cin, direction, adresse, dob, card_number, password) "
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
            pstmt.setDate(8, Date.valueOf(user.getDob()));
            pstmt.setString(9, user.getCardNumber());
            pstmt.setString(10, user.getPassword());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Authentifie par email & mot de passe, retourne User complet ou null 
     * @throws SQLException */
    public static User getLoginUser()  {
    	String email=null;
    	Connection conn=null;
		try {
			conn = DatabaseConnection.getConnection();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    	String sql = "SELECT * FROM logedinuser ";
        try (
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
        	try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                	email=rs.getString("email");
                }}} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
            
            
            
            
         sql = "SELECT * FROM users WHERE email = ? ";
        try (
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setNom(rs.getString("nom"));
                    u.setPrenom(rs.getString("prenom"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setTel(rs.getString("tel"));
                    u.setCin(rs.getString("cin"));
                    u.setDirection(rs.getString("direction"));
                    u.setAdresse(rs.getString("adresse"));
                    Date dobDate = rs.getDate("dob");
                    if (dobDate != null) u.setDob(dobDate.toLocalDate());
                    u.setCardNumber(rs.getString("card_number"));
                    
                    
                    
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static boolean loginUser(String email, String password) {
        // First, verify the user's credentials
        String checkSql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, email);
            checkStmt.setString(2, password);
            
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // Credentials are valid, now update or insert into logedinuser
                    
                    // First clear the table to ensure only one user is logged in at a time
                    String clearSql = "DELETE FROM logedinuser";
                    try (PreparedStatement clearStmt = conn.prepareStatement(clearSql)) {
                        clearStmt.executeUpdate();
                    }
                    
                    // Now insert the current user's email
                    String insertSql = "INSERT INTO logedinuser (email) VALUES (?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setString(1, email);
                        return insertStmt.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    

    /**
     * Alias pour loginUser(), afin de respecter lappel findByEmailAndPassword()
     */
    public static User findByEmailAndPassword(String email, String password) {
        // First attempt to login the user
        if (loginUser(email, password)) {
            // If login successful, retrieve and return the user data
            return getLoginUser();
        }
        // If login failed, return null
        return null;
    }
   // public static void setUserLogedin()
    public static User getLogedInUser() {
    	String sql = "SELECT * FROM logedinuser";
    	try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
               try (ResultSet rs = pstmt.executeQuery()) {
                   if (rs.next()) {
                       User u = new User();
                       u.setId(rs.getInt("id"));
                       u.setNom(rs.getString("nom"));
                       u.setPrenom(rs.getString("prenom"));
                       u.setEmail(rs.getString("email"));
                       u.setPassword(rs.getString("password"));
                       u.setTel(rs.getString("tel"));
                       u.setCin(rs.getString("cin"));
                       u.setDirection(rs.getString("direction"));
                       u.setAdresse(rs.getString("adresse"));
                       Date dobDate = rs.getDate("dob");
                       if (dobDate != null) u.setDob(dobDate.toLocalDate());
                       u.setCardNumber(rs.getString("card_number"));
                       
                       return u;
                   }
               }
           } catch (SQLException e) {
               e.printStackTrace();
           }
           return null;
    	
    	
    }

 
    public static boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public static boolean isCinExists(String cin) {
        String sql = "SELECT COUNT(*) FROM users WHERE cin = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cin);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}