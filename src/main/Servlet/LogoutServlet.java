package Servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException {

        req.getSession().invalidate();

        res.sendRedirect("./");

    }
}
