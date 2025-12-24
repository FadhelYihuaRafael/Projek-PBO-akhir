package Login;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("user");
        String pass = request.getParameter("pass"); // Mengambil input password
        String role = request.getParameter("role");

        // Di dalam method doPost LoginServlet.java
        // Cari bagian ini di LoginServlet.java Anda dan sesuaikan baris response.sendRedirect-nya
        if (role != null && role.equals("admin") && "admin@mail.com".equals(email) && "admin123".equals(pass)) {
            request.getSession().setAttribute("username", email);
            request.getSession().setAttribute("role", "admin");
            // TAMBAHKAN layouts/ sebelum nama file
            response.sendRedirect("layouts/dashboard.jsp");
        } else if (role != null && role.equals("staff") && "staff@mail.com".equals(email) && "staff123".equals(pass)) {
            request.getSession().setAttribute("username", email);
            request.getSession().setAttribute("role", "staff");
            // TAMBAHKAN layouts/ sebelum nama file
            response.sendRedirect("layouts/dashboard.jsp");
        } else {
            response.sendRedirect("login_1.jsp?error=invalid");
        }
    }
}
