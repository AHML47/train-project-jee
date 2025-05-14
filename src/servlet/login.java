package servlet;

import model.User;
import DB.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class login extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Attempt to authenticate and get user data in one step
        User user = UserDAO.findByEmailAndPassword(email, password);

        if (user != null) {
            // Set user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loggedIn", true);
            
            // Redirect to metro interface
            response.sendRedirect("metroInterfaceS");
        } else {
            // If login failed, show error message
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}