package Servlet;
import Bean.*;
import Dao.*;
import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/doLogin")
public class doLoginServlet extends HttpServlet{
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        ServletContext application = req.getServletContext();
        application.setAttribute("username", username);

        //利用session储存异常信息
        HttpSession session = req.getSession();
        //利用session检查是否登录
        HttpSession check = req.getSession();
        //去除空格导致的错误
        if (username == null || "".equals(username.trim())) {
            session.setAttribute("error", "用户名输入错误");
            //能使用请求转发和重定向，优先使用重定向，防止恶意占用资源
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        if (password == null || "".equals(password.trim())) {
            session.setAttribute("error", "密码输入错误");
            //能使用请求转发和重定向，优先使用重定向，防止恶意占用资源
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        UserDao userDao = new UserDao();
        User user = null;
        try {
            user = userDao.UserLogin(username,password);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (user == null || user.equals("")) {
            session.setAttribute("error", "用户名或密码错误");
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        } else if (user.getCategory().equals("admin")) {
            session.setAttribute("user", "admin");
            req.getRequestDispatcher("/index.jsp").forward(req, res);

        } else {
            session.setAttribute("user", username);
            req.getRequestDispatcher("/index.jsp").forward(req, res);
        }
    }
}
