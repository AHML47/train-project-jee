package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class metroInterfaceS
 */
@WebServlet("/metroInterfaceS")
public class metroInterfaceS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public metroInterfaceS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher dispatcher = request.getRequestDispatcher("metro-interface.jsp");
		HttpSession session = request.getSession();
        String buttonText = "Sign Up or Login";
        String buttonLink = "signUp";

        // Check session attribute
        if (session.getAttribute("user") != null) {
            buttonText = "Generate Carte";
            buttonLink = "wariLcarta";
        }

        // Debug: Print Values in Console
        System.out.println("DEBUG: Button Text = " + buttonText);
        System.out.println("DEBUG: Button Link = " + buttonLink);

        // Store variables in request attributes
        request.setAttribute("buttonText", buttonText);
        request.setAttribute("buttonLink", buttonLink);

        // Forward to JSP
        request.getRequestDispatcher("metro-interface.jsp").forward(request, response);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
