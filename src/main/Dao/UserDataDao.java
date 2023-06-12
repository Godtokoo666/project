package Dao;

import Bean.User;

import java.sql.*;

public class UserDataDao {
    private Connection connection;
    public User rate(String username) throws ClassNotFoundException, SQLException {
        User users = new User();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/javaweb?useUnicode=true&characterEncoding=UTF8&useSSL=true&serverTimezone=GMT";
        String user = "root";
        String pass = "jDQqt<=tU012";
        Connection connection = DriverManager.getConnection(url, user, pass);
        String sql = "select * from user where username = '" + username + "'";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            double pass_rate = (double) resultSet.getObject("main_passrate");
            double last_passrate = (double) resultSet.getObject("last_passrate");
            int number=(int)resultSet.getObject("number");
            int pass_number=(int)resultSet.getObject("pass_number");
            users = new User(username, pass_rate, last_passrate,number,pass_number);
        }
        return users;
    }
}
