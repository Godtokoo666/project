<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
</head>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background: #f5f5f5;
    }

    .box-lo {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 300px;
        height: 300px;
        border-radius: 50px;
        background: #e0e0e0;
        box-shadow: 20px 20px 60px #bebebe, -20px -20px 60px #ffffff;
    }

    .centered-form {
        text-align: center;
    }

    .form-title {
        font-size: 18px;
        margin-bottom: 10px;
    }
</style>
<body>
<div class="box-lo">
    <div class="centered-form">
        <div class="form-title">用户注册</div>
        <form name="frmregister" method="post" action="doRegister">
            用户名：<input name="username" type="text"/><br/>
            密码：<input name="password" type="password"/><br/>
            确认密码：<input name="confirmpassword" type="password"/><br/>
            <input name="resetbtn" type="reset" value="重置"/>
            <input name="loginbtn" type="submit" value="注册"/>
            <button onclick="window.location.href='login.jsp'" type="button">登录</button>
        </form>
    </div>
</div>
</body>
</html>
