package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User u= UserDAO.getLoginUser();
    	RequestDispatcher rd = request.getRequestDispatcher("/displayCard.jsp");
        // copy each form field into a request attribute
        for (String field : new String[]{
                "nom","prenom","email","tel","cin",
                "direction","adresse","dob","cardNumber","password"
        }) {
        	request.setAttribute(field, request.getParameter(field));
           
        }
       
        request.setAttribute("param", u);
        // forward to displayUser.jsp
        
        rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
