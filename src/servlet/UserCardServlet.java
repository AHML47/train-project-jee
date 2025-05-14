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

    // On GET /user → show the form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("/carteutilisateur.jsp");
        rd.forward(req, resp);
    }

    // On POST /user → collect inputs, then show the card
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
    	User u= UserDAO.getLoginUser();
    	RequestDispatcher rd = req.getRequestDispatcher("/displayCard.jsp");
        // copy each form field into a request attribute
        for (String field : new String[]{
                "nom","prenom","email","tel","cin",
                "direction","adresse","dob","cardNumber","password"
        }) {
            req.setAttribute(field, req.getParameter(field));
           
        }
       
        req.setAttribute("param", u);
        // forward to displayUser.jsp
        
        rd.forward(req, resp);
    }
}
