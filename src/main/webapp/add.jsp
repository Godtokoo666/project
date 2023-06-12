<%--
  Created by IntelliJ IDEA.
  User: 40248
  Date: 2023/6/12
  Time: 2:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>单词添加页面</title>
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
  window.location.href = "index.jsp";
</script>
<%
  }
  else{}
%>
</body>
<body>
<h2>单词添加页面</h2>
<form action="add" method="post" class="form-inline">
  <div class="form-group">
    <label for="english">英文</label>
    <input type="text" class="form-control" id="english" name="english">
  </div>
  <div class="form-group">
    <label for="chinese">中文</label>
    <input type="text" class="form-control" id="chinese" name="chinese">
  </div>
  <button type="submit" class="btn btn-default">提交</button>

</form>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>
