<%@ page import="Bean.User" %>
<%@ page import="Dao.UserDataDao" %>
<%@ page contentType="text/html; charset=gb2312"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        ��������
    </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
<%-- ����û��Ự --%>
<%
    String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
%>
<script type="text/javascript">
    alert("����Ҫ�ȵ�¼���ܷ��ʴ�ҳ��");
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
<h1 style="text-align: center">�û����� <a href="index.jsp" class="btn btn-primary"> ������ҳ</a></h1>
<table class="table">
    <tr>
        <td>�û���</td>
        <td>��ͨ����</td>
        <td>�ϴβ���ͨ����</td>
        <td>�ܲ�����</td>
        <td>ͨ����</td>
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
��<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- ���µ� Bootstrap ���� JavaScript �ļ� -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
<body>
<div style="text-align: center">
���ã�<%=(String) request.getSession().getAttribute("user")%>
<br>
<a href="logout">logout</a>
</div>
</body>
</html>