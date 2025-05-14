package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DB.UserDAO;
import model.User;

/**
 * Servlet implementation class wariLcarta
 */
@WebServlet("/wariLcarta")
public class wariLcarta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public wariLcarta() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the user from the database or session
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user == null) {
		    // If no user in session, try to get from database
		    user = UserDAO.getLoginUser();
		}
		
		if (user != null) {
		    // Set the user object as a request attribute
		    request.setAttribute("user", user);
		    
		    // Forward to displayCard.jsp
		    RequestDispatcher rd = request.getRequestDispatcher("/displayCard.jsp");
		    rd.forward(request, response);
		} else {
		    // If no user found, redirect to login page
		    response.sendRedirect("login");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}