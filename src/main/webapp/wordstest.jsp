<%@ page import="Bean.Word" %>
<%@ page import="java.util.List" %>
<%@ page  language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        单词测试
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
    } else {}
%>
</body>
<body>
<h1 style="text-align: center">单词测试页面WordTest     <a href="index.jsp" class="btn btn-primary"> 返回主页</a></h1>
<form name="Word" method="post" action="WordServlet">
<table class="table">
    <tr>
        <td>英文</td>
        <td>中文</td>
    </tr>
        <%List<Word> list = (List<Word>)request.getSession().getAttribute("list");%>
        <%
            for(Word word : list)
            {
                out.write("<tr>");
                out.write("<td>"+word.getEnglish()+"</td>");
                out.write("<td><input name='"+word.getEnglish()+"' type='text'/><br/></td>");
                out.write("</tr>");
            }
        %>

</table>
    <div style="text-align: center">
    <input name="submitbtn" type="submit" value="提交" ></br>
    </div>
</form>
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