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
        �����̨
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
    } else if(username != "admin")
    {
%>
<script type="text/javascript">
    alert("�ǹ���Ա�û���ֹ����");
    window.location.href = "usercenter.jsp";
</script>
<%
    }
    else{}
%>
</body>
<body>
<h1 style="text-align: center">�����̨</h1>
<h3 style="text-align: center">�û�����   <a href="index.jsp" class="btn btn-primary"> ������ҳ</a></h3>
<table class="table">
    <tr>
        <td>�û���</td>
        <td>��ͨ����</td>
        <td>�ϴβ���ͨ����</td>
        <td>�ܲ�����</td>
        <td>ͨ����</td>
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
<h3 style="text-align: center">�����б�WordList     <a href="add.jsp" target="_blank" class="btn btn-primary"> ��ӵ���</a></h3>
<table class="table">
    <tr>
        <td>Ӣ��</td>
        <td>����</td>
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