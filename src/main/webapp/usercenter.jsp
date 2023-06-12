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