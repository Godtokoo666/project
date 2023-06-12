package Servlet;
import Bean.*;
import Dao.UserDao;

import java.io.*;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import javax.servlet.*;
@WebServlet("/doRegister")

public class doRegisterServlet extends HttpServlet{
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String password1 = req.getParameter("confirmpassword");
        String message = null;
        if (password1.equals(password)) {
            User us = new User(username, password,"user");
            UserDao userDao = new UserDao();
            try {
                userDao.UserRegister(us);
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            resp.sendRedirect(req.getContextPath() + "/login.jsp");

        } else {
            message = "密码不一致！";
            req.setAttribute("Message", message);
            req.getRequestDispatcher("/Message.jsp").forward(req, resp);
        }
    }
}