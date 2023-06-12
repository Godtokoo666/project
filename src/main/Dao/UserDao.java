package Dao;
import Bean.*;
import java.sql.*;
public class UserDao{

    private Connection connection;
    public void UserRegister(User us) throws ClassNotFoundException, SQLException {
        Connection connection=DBUtil.con();
        String sql="insert into user(username,password,category) values(?,?,?)";
        PreparedStatement preparedStatement=connection.prepareStatement(sql);{
            preparedStatement.setString(1,us.getUsername());
            preparedStatement.setString(2,us.getPassword());
            preparedStatement.setString(3,us.getCategory());
            preparedStatement.executeUpdate();
        }
        preparedStatement.close();
        connection.close();
    }
    public User UserLogin(String username,String password) throws ClassNotFoundException, SQLException {
        Connection connection = DBUtil.con();
        Statement statement = connection.createStatement();
        String sql="SELECT * FROM user WHERE username = '"+username+"'" ;
        ResultSet resultSet = statement.executeQuery(sql);
        while(resultSet.next()) {
            String realPassWord = (String) resultSet.getObject("password");
            String realCategory = (String) resultSet.getObject("category");
            resultSet.close();
            connection.close();
            if (realPassWord.equals(password)) {
                return new User(username,realPassWord,realCategory);
            } else {
                return null;
            }
        }
        return null;
    }
    public void DoTest(String username,int number,int pass_number) throws ClassNotFoundException, SQLException {
        Connection connection=DBUtil.con();
        String sql1="SELECT * FROM user WHERE username = '"+username+"'" ;
        Statement statement =connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql1);
        int num=0,pass_num=0;
        if(resultSet.next())
        {
            num=(int)resultSet.getObject("number")+number;
            pass_num=(int)resultSet.getObject("pass_number")+pass_number;
        }
        double main_passrate = pass_num/(double)num;
        double last_passrate = pass_number/(double)number;
        String sql="update user set main_passrate = ?, last_passrate = ? ,number = ? ,pass_number = ? where username ='"+username+"'";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        {
            preparedStatement.setDouble(1,main_passrate);
            preparedStatement.setDouble(2,last_passrate);
            preparedStatement.setInt(3,num);
            preparedStatement.setInt(4,pass_num);
            preparedStatement.executeUpdate();
        }
    }
}
