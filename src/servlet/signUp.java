package servlet;

import java.io.IOException;
import java.time.LocalDate;

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
 * Servlet implementation class signUp
 */
@WebServlet("/signUp")
public class signUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public signUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher dispatcher = request.getRequestDispatcher("carteutilisateur.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

		String nom         = request.getParameter("nom");
		String prenom      = request.getParameter("prenom");
		String email       = request.getParameter("email");
		String tel         = request.getParameter("tel");
		String cin         = request.getParameter("cin");
		String direction   = request.getParameter("direction");
		String adresse     = request.getParameter("adresse");
		String dobParam    = request.getParameter("dob");         // "YYYY-MM-DD"
		String cardNumber  = request.getParameter("cardNumber");
		String password    = request.getParameter("password");

		try {
			// Check if email already exists
			if (UserDAO.isEmailExists(email)) {
				request.setAttribute("error", "Cette adresse e-mail est déjà utilisée.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("carteutilisateur.jsp");
				dispatcher.forward(request, response);
				return;
			}

			// Create user object
			User user = new User();
			user.setNom(nom);
			user.setPrenom(prenom);
			user.setEmail(email);
			user.setTel(tel);
			user.setCin(cin);
			user.setDirection(direction);
			user.setAdresse(adresse);
			LocalDate dob = LocalDate.parse(dobParam);
			user.setDob(dob);
			user.setCardNumber(cardNumber);
			user.setPassword(password);

			// Register the user
			if (UserDAO.registerUser(user)) {
				// Login the user (store email in logedinuser table)
				if (UserDAO.loginUser(user.getEmail(), user.getPassword())) {
					// Create session
					HttpSession session = request.getSession();
					session.setAttribute("user", user);
					
					// Redirect to the saveUser servlet to display the user card
					response.sendRedirect("saveUser");
					return;
				}
			}
			
			// If we get here, something went wrong with registration or login
			request.setAttribute("error", "Échec de l'enregistrement. Veuillez réessayer.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("carteutilisateur.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Une erreur est survenue, veuillez réessayer.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("carteutilisateur.jsp");
			dispatcher.forward(request, response);
		}
	}
}

