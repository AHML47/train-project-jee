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

    /** Authentifie par email & mot de passe, retourne User complet ou null */
    public static User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);
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
                    // mot de passe non remis en objet pour raisons de s�curit�
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Alias pour loginUser(), afin de respecter l�appel findByEmailAndPassword()
     */
    public static User findByEmailAndPassword(String email, String password) {
        return loginUser(email, password);
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