package Dao;

import Bean.Result;
import Bean.Word;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WordsDao {
    private Connection connection;
    public void wordInsert(String English,String Chinese) throws SQLException, ClassNotFoundException {
        Connection connection = DBUtil.con();
        String sql="insert into words(English,Chinese) values(?,?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        {
            preparedStatement.setString(1,English);
            preparedStatement.setString(2,Chinese);
            preparedStatement.executeUpdate();
        }
        preparedStatement.close();
        connection.close();
    }
    public String getChinese(String English) throws SQLException, ClassNotFoundException {
        Connection connection = DBUtil.con();
        String sql = "select * from words where English = '"+English+"'";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        connection.close();
        if(resultSet.next())
        {
            return (String) resultSet.getObject("Chinese");
        }
        return null ;
    }
    public List<Word> getList() throws SQLException, ClassNotFoundException {
        Connection connection=DBUtil.con();
        List<Word> list  = new ArrayList<>();
        String sql = "select * from words";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while(resultSet.next())
        {
            list.add(new Word((String)resultSet.getString("English"),(String) resultSet.getObject("Chinese")));
        }
        return list;
    }
    public Result judge(List<Word> words) throws ClassNotFoundException, SQLException {
        List<String> right = new ArrayList<>();
        List<String> wrong = new ArrayList<>();
        Connection connection = DBUtil.con();
        List<Word> list  = new ArrayList<>();
        String sql = "select * from words";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while(resultSet.next())
        {
            list.add(new Word((String)resultSet.getString("English"),(String) resultSet.getObject("Chinese")));
        }
        for(int i=0;i<words.size();i++)
        {
            if(words.get(i).getChinese().equals(list.get(i).getChinese()))
            {
                right.add(words.get(i).getEnglish());
            }
            else
            {
                wrong.add(words.get(i).getEnglish());
            }
        }
        return new Result(right,wrong);
    }
}
