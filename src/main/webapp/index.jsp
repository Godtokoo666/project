<%@ page import="Dao.WordsDao" %>
<%@ page import="Bean.Word" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page  language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>
    单词测试系统
</title>
   <link href="css/main.css" rel="stylesheet" media="screen">
</head>
<body>
<div style="display: flex;margin: 5vh;justify-content: center;height: 20vh;font-size: 30px;font-family: FangSong">
    <h1 >基于Java的单词测试系统<br><p style="text-align: center;font-size: 30px">Word Testing System Based on Java </p></h1>
</div>
<div class="container-mi">
    <div class="box">
        <h2 style="text-align: center">
            单词测试：根据您所在的组进行测试
        </h2>
        <div style="text-align: center">
            <a href="wordstest.jsp" target="_blank">
        <button type="button" class="btn btn-large btn-primary" data-toggle="button">点击进入单词测试</button>
            </a>
        </div>
    </div>
    <div class="box">
        <h2 style="text-align: center">
            单词列表：输出单词列表
        </h2>
        <div style="text-align: center">
            <a href="list.jsp" target="_blank">
            <button type="button" class="btn btn-large btn-primary" data-toggle="button">点击进入单词列表</button>
            </a>
        </div>
    </div>
    <div class="box">
        <h2 style="text-align: center">
            个人中心：您的测试及练习数据中心
        </h2>
        <div style="text-align: center">
            <a href="usercenter.jsp" target="_blank">
            <button type="button" class="btn btn-large btn-primary" data-toggle="button">点击进入个人中心</button>
            </a>
        </div>
    </div>
</div>
<% String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
    %>
<div style="text-align: center">
    您好，请登录
    <br>
    <a href="login.jsp">login</a>
</div>
    <% }
    else {
        %>
<div style="text-align: center">
    您好，<%=(String) request.getSession().getAttribute("user")%>
    <br>
    <a href="logout">logout</a>
</div>
<% }%>
</form>
</body>
<body>
<%--预加载List资源--%>
<%
    WordsDao wordsDao = new WordsDao();
    List<Word> list =new ArrayList<>();
    try {
        list = wordsDao.getList();
    } catch (Exception e) {
    }
    request.getSession().setAttribute("list",list);
%>
</body>
</html>