package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DB.UserDAO;
import model.User;

@WebServlet("/saveUser")
public class UserCardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // On GET /user → show the user card if logged in
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // Get the logged-in user information from the database
        User user = UserDAO.getLoginUser();
        
        if (user != null) {
            // Set the user object as an attribute
            req.setAttribute("user", user);
            
            // Forward to displayCard.jsp
            RequestDispatcher rd = req.getRequestDispatcher("/displayCard.jsp");
            rd.forward(req, resp);
        } else {
            // If no user is logged in, redirect to login page
            resp.sendRedirect("carteutilisateur.jsp");
        }
    }

    // Handle POST requests the same way as GET
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        doGet(req, resp);
    }
}
