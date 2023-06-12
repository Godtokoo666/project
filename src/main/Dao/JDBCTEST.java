package Dao;
import Bean.User;
import Bean.Word;

import java.sql.*;
import java.util.List;

public class JDBCTEST {

    public static void main(String args[]) throws ClassNotFoundException, SQLException {
        UserDao userDao = new UserDao();
        userDao.DoTest("test",10,6);

//        List<Word> list=null;
//        WordsDao wordsDao = new WordsDao();
//        try {
//            list = wordsDao.getList();
//        } catch (Exception e) {
//        }
//        for(int i=0;i<list.size();i++)
//            System.out.println(list.get(i).getChinese());
//        AdminDataDao adminDataDao = new AdminDataDao();
//        List<User> users= adminDataDao.rate();
//        for(User user : users)
//        {
//            System.out.println("username="+user.getUsername());
//            System.out.println("pass_rate="+user.getPassRate());
//            System.out.println("las_passrate="+user.getLast_passrate());
//            System.out.println("=================");
//        }
        //System.out.println(userDao.UserLogin("admin","ad"));
//        Class.forName("com.mysql.cj.jdbc.Driver");
//        String url="jdbc:mysql://localhost:3306/javaweb?useUnicode=true&characterEncoding=UTF8&useSSL=true&serverTimezone=GMT";
//        String user="root";
//        String pass="jDQqt<=tU012";
//        Connection connection=DriverManager.getConnection(url,user,pass);
//        Statement statement=connection.createStatement();
//        String sql="SELECT * FROM words";
//        ResultSet resultSet = statement.executeQuery(sql);
//        while(resultSet.next())
//        {
//            System.out.println("wordid="+resultSet.getObject("WordsId"));
//            System.out.println("wordEn="+resultSet.getObject("English"));
//            System.out.println("wordCh="+resultSet.getObject("Chinese"));
//            System.out.println("========================");
//        }
//
//        resultSet.close();
//        statement.close();
//        connection.close();
    }

}
