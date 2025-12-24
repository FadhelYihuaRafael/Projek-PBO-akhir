package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    
    private UserDAO userDAO;
    
    public LoginController() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("user");
        String password = request.getParameter("pass");
        String role = request.getParameter("role");
        
        if (email != null) {
            email = email.trim();
        }
        if (password != null) {
            password = password.trim();
        }
        if (role != null) {
            role = role.trim();
        }
        
        if (email == null || email.isEmpty() || 
            password == null || password.isEmpty() || 
            role == null || role.isEmpty()) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }
        
        boolean loginBerhasil = userDAO.cekLogin(email, password, role);
        
        if (loginBerhasil) {
            User user = userDAO.cariUserByEmail(email);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("username", user.getEmail());
                session.setAttribute("role", user.getRole());
                session.setAttribute("userId", user.getId());
                session.setAttribute("nama", user.getNama());
                response.sendRedirect("layouts/dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}

