package Servlet;

import Bean.Result;
import Bean.Word;
import Dao.UserDao;
import Dao.WordsDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.*;

@WebServlet("/WordServlet")
public class WordServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        req.setCharacterEncoding("utf-8");
        res.setContentType("text/html;charset=utf-8");
        List<Word> list=new ArrayList<>(),answer=new ArrayList<>();
        UserDao userDao =new UserDao();
        WordsDao wordsDao = new WordsDao();
        try {
            list = wordsDao.getList();
        } catch (Exception e) {
        }
        for(int i=0;i<list.size();i++)
        {
            Word w=new Word(list.get(i).getEnglish(), req.getParameter(list.get(i).getEnglish()));
                answer.add(w);
        }
        Result result=null;
        try {
            result = wordsDao.judge(answer);
        } catch (Exception e) {
        }
        try {
            userDao.DoTest((String) req.getSession().getAttribute("user"),(result.right.size()+result.wrong.size()),result.right.size());
        } catch (Exception e) {
        }
        double passrate = result.right.size()/(double)(result.right.size()+result.wrong.size());
        PrintWriter out=res.getWriter();
        out.println("<html>");
        out.println("<h1 style='text-align: center'>提交完成，正确率为"+passrate+"</h1>");
        out.println("<div style = 'text-align:center'>");
        out.println("<h3>正确单词有</h3>");
        for(int i=0;i<result.right.size();i++)
        {
            out.println("<p>"+result.right.get(i)+"</p><br/>");
        }
        out.println("</div>");
        out.println("<div style = 'text-align:center'>");
        out.println("<h3>错误单词有</h3>");
        for(int i=0;i<result.wrong.size();i++)
        {
            out.println("<p>"+result.wrong.get(i)+"</p><br/>");
        }
        out.println("</div>");
        out.println("</html>");
    }
    public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException {
        super.doGet(req, res);
    }
}
