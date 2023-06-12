package Servlet;

import Dao.WordsDao;

import java.io.*;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/add")
public class WordAddServlet extends  HttpServlet{
    public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
        req.setCharacterEncoding("utf-8");
        res.setContentType("text/html;charset=utf-8") ;
        String English = req.getParameter("english");
        String Chinese = req.getParameter("chinese");
        WordsDao wordsDao = new WordsDao();
        try {
            wordsDao.wordInsert(English,Chinese);
        } catch (Exception e) {
            System.out.println(e);
        }
        PrintWriter out=res.getWriter();
        out.println("<html><h1>添加成功</h1><br><a href='add.jsp'>点击返回</a></html>");
    }
    public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException {
        super.doGet(req, res);
    }

}
