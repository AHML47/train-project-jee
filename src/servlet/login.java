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

        User user = UserDAO.findByEmailAndPassword(email, password);

        if (user != null) {
            request.getSession().setAttribute("user", user);
            response.sendRedirect("carteutilisateur.jsp");
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("metroInterfaceS").forward(request, response);
        }
    }
}