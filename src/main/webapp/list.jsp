<%@ page import="Bean.Word" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 40248
  Date: 2023/6/11
  Time: 20:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>单词列表</title>
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
} else {}
%>
</body>
<body>
<h1 style="text-align: ">单词列表WordList     <a href="index.jsp" class="btn btn-primary"> 返回主页</a></h1>

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
<script src="js/jquery-1.11.0.js"></script>
　<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>