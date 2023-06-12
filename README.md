# 1.Preface前言
This a page for the Course Design Project of OOPJava
# 2.Git地址
<https://github.com/Godtokoo666/projectx>
由于本项目是使用Maven构建和管理的，所以Git中并不提供jar包，因此您看不到属于jar包的lib文件夹。但除jdk11所提供的所有jar包外，所需的所有文件都可以借由Maven的配置文件pom.xml看到，包括但不限于MySQL Connector/J、JavaServer Pages(TM) API
# 3.项目概览
### 整体介绍
本着面向对象程序设计“高内聚，低耦合”的思想，本项目借鉴了MVC模式中的内容，即三个基本部分：**模型（Model）**、**视图（View）**和**控制器（Controller）**。在MVC中，存在三层架构，即**表示层（USL，User Show Layer）**、**业务逻辑层（BLL，Business Logic Layer）**、**数据访问层（DAL，Data Access Layer）**。
### 结构解释
在IntelliJ IDEA中，截得的项目源代码结构图如下

![图1-项目源代码结构图](/image/2023-6-13/1.png)

如您所见，src文件夹中存在着Bean、Dao、Servlet三个包以及一个webapp文件夹，其中Bean包内的类作为实体类将各种数据进行封装，以便使数据在三层架构间进行流通。

![图2-三层架构图](/image/2023-6-13/2.png)

webapp中的内容作为表示层部分，用于处理用户请求。在本项目中，webapp主要处理注册登录、单词测试数据的表单提交、个人数据的查询以及管理员页面的全局数据查询和单词的添加操作。Servlet包中的类作为业务逻辑层，承上启下，通过HttpServlet接受request，并通过具体代码与Dao包中的内容进行交互或通过session把请求直接实现。Dao包中的类作为数据访问层，由于该层直接通过JDBC与数据库交互，因此也起着最底层的数据访问作用。
对于数据的储存，本项目使用MySQL数据库，其表结构如下：

![图3-MySQL表结构](/image/2023-6-13/3.png)

其中，出于轻量化的目的，本项目user表同时存储用户名和明文密码以及单词测试产生的数据。但我们并不建议您这么错，更为安全的做法是将password转码加密或者使用其他方式储存。word表存储单词的英文和中文属性。此外，为了拓展功能，后续可添加词性或其他属性对单词进行分类。test表用于存储测试数据，但在此项目的第一版中，我们并未投入使用，后续将考虑进行延申。
# 4.功能实现
## 前端主页面

![图4-前端主页面](/image/2023-6-13/4.png)	

## 登录与注册
#### 前端页面：	

![图5-登录界面](/image/2023-6-13/5.png)	

![图6-注册界面](/image/2023-6-13/6.png)

#### 具体实现：
1.对于登录操作，在前端jsp页面中，我们使用表单form将username以及password提交到doLoginServlet，Servlet将request处理，通过UserDao与数据库交互，判断账号密码是否正确，此后设置session“user”的值，并用于前端展示。
2.对于注册操作，同样获取表单数据后，提交到doRegisterServlet，Servlet将request处理，通过UserDao与数据库交互，将注册数据导入数据库，然后将页面重定向到登录页面。
```java
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

```
```java
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
```
## 单词测试
#### 前端页面：

![图7-单词测试界面](/image/2023-6-13/7.png)

![图8-测试完成界面](/image/2023-6-13/8.png)

### 具体实现
在前端jsp页面中，出于轻量化的目的，我们直接嵌入了Java代码，来将后端获取的List<Word>对象直接打印在前端页面，并为各个单词附上提交框，最后一并以表单方式提交到WordServlet。servlet为前端获取到的request数据转移至List对象中，然后调用WordsDao类中的方法，将前端获取到的List对象与数据库中获取到的List进行比较，输出错误单词、正确单词和正确率。同时，servlet调用UserDao类中的doTest方法，对数据库中的用户测试数据进行更新。
```java
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
```
## 数据查询
### 前端页面：
                                               
![图9-用户个人中心页面](/image/2023-6-13/9.png)
                                               
![图10-管理后台页面](/image/2023-6-13/10.png)
                                               
### 具体实现：
·对于用户，在前端jsp文件中，我们直接嵌入了Java代码，直接调用UserDataDao类中的	rate方法，输出对应用户名的各项数据，包括测试通过率，通过数等。
·对于管理员，在前端jsp文件中，我们同样直接嵌入了Java，直接调用AdminDataDao类中的rate方法，输出所有用户的各项数据。同单词测试页面，管理后台同样输出了单词的列表，但此时包含英文单词的中文释义。此外，管理后台提供了一个添加单词的按钮，用于跳转到单词添加页面。
```jsp
<%@ page import="Bean.User" %>
<%@ page import="Dao.UserDataDao" %>
<%@ page contentType="text/html; charset=gb2312"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        个人中心
    </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
<%-- 检查用户会话 --%>
<%
    String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
%>
<script type="text/javascript">
    alert("您需要先登录才能访问此页面");
    window.location.href = "login.jsp";
</script>
<%
} else if(username == "admin")
{
%>
<script type="text/javascript">
    window.location.href = "admin.jsp";
</script>
<%
    } else {}
%>
</body>
<body>
<h1 style="text-align: center">用户中心 <a href="index.jsp" class="btn btn-primary"> 返回主页</a></h1>
<table class="table">
    <tr>
        <td>用户名</td>
        <td>主通过率</td>
        <td>上次测试通过率</td>
        <td>总测试数</td>
        <td>通过数</td>
    </tr>
    <%
        UserDataDao userDataDao = new UserDataDao();
        User user = userDataDao.rate((String) request.getSession().getAttribute("user"));
        out.write("<tr>");
        out.write("<td>"+user.getUsername()+"</td>");
        out.write("<td>"+user.getPassRate()+"</td>");
        out.write("<td>"+user.getLast_passrate()+"</td>");
        out.write("<td>"+user.getNumber()+"</td>");
        out.write("<td>"+user.getPassNumber()+"</td>");
        out.write("</tr>");
    %>
</table>
<script src="js/jquery-1.11.0.js"></script>
　<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
<body>
<div style="text-align: center">
您好，<%=(String) request.getSession().getAttribute("user")%>
<br>
<a href="logout">logout</a>
</div>
</body>
</html>
```
```jsp
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dao.AdminDataDao" %>
<%@ page import="Bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.Word" %>
<%@ page contentType="text/html; charset=gb2312"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        管理后台
    </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
<%-- 检查用户会话 --%>
<%
    String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
%>
<script type="text/javascript">
    alert("您需要先登录才能访问此页面");
    window.location.href = "login.jsp";
</script>
<%
    } else if(username != "admin")
    {
%>
<script type="text/javascript">
    alert("非管理员用户禁止访问");
    window.location.href = "usercenter.jsp";
</script>
<%
    }
    else{}
%>
</body>
<body>
<h1 style="text-align: center">管理后台</h1>
<h3 style="text-align: center">用户数据   <a href="index.jsp" class="btn btn-primary"> 返回主页</a></h3>
<table class="table">
    <tr>
        <td>用户名</td>
        <td>主通过率</td>
        <td>上次测试通过率</td>
        <td>总测试数</td>
        <td>通过数</td>
    </tr>
<%
    AdminDataDao adminDataDao = new AdminDataDao();
    List<User> users= adminDataDao.rate();
    for(User user : users)
    {
        out.write("<tr>");
        out.write("<td>"+user.getUsername()+"</td>");
        out.write("<td>"+user.getPassRate()+"</td>");
        out.write("<td>"+user.getLast_passrate()+"</td>");
        out.write("<td>"+user.getNumber()+"</td>");
        out.write("<td>"+user.getPassNumber()+"</td>");
        out.write("</tr>");
    }
    %>
</table>
<h3 style="text-align: center">单词列表WordList     <a href="add.jsp" target="_blank" class="btn btn-primary"> 添加单词</a></h3>
<table class="table">
    <tr>
        <td>英文</td>
        <td>中文</td>
    </tr>
    <%
        List<Word> list = (List<Word>)request.getSession().getAttribute("list");
        for (Word word : list) {
            out.write("<tr>");
            out.write("<td>"+word.getEnglish()+"</td>");
            out.write("<td>"+word.getChinese()+"</td>");
            out.write("</tr>");

        }
    %>
</table>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
<body>
<div style="text-align: center">
您好，<%=(String) request.getSession().getAttribute("user")%>
<br>
<a href="logout">logout</a>
</div>
</body>
</html>
```
## 单词添加
### 前端页面：
![图11-单词添加界面](/image/2023-6-13/11.png)
```java
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

```
### 具体实现：
与注册类似，jsp页面发送表单数据给WordAddServlet，servlet调用WordDao类中的WordInsert方法，将数据提交到数据库，完成insert into操作。
## 单词列表List
同时，本项目实现了一个单词列表List页面，具体实现与管理后台的列表相同。
![图12-单词列表List](/image/2023-6-13/12.png)
# 5.场景化应用
1.可用于现代化教学与作业系统，提高课堂效率。
2.可用于模块化系统化练习，提升学习效率。
3.可用于竞赛与考试系统……
# 6.Demo 
-- 由于服务器资源昂贵，本项目暂不提供Demo
# 7.敬请期待（to do list）
1.实现单词限时测试（考试），后台为指定对象划定指定考试范围。
2.对单词分类，分词性，划分单元，划分学习阶段（高中，四级，六级）（数据库优化）。
3.创建单词练习功能，针对指定分类进行练习。
4.对每个用户记录每个单词错误的次数（数据库优化）
……
