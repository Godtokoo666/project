package Bean;
public class User {

    private String username;
    private String password;
    private String category;
    private double mian_passrate;
    private double last_passrate;
    private  int number;
    private int pass_number;
   public User( String username, String password ,String category) {
        this.username = username;
        this.password = password;
        this.category=category;
    }
    // 无参构造函数必须得有
    public User(String username,double pass_rate,double last_passrate,int number,int pass_number){
       this.username=username;
       this.mian_passrate=pass_rate;
       this.last_passrate=last_passrate;
       this.number=number;
       this.pass_number=pass_number;
    }
    public User() {
        super();
    }
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
    public String getCategory(){
        return category;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public double getPassRate() {return mian_passrate;}
    public double getLast_passrate(){return last_passrate;}
    public int getNumber() {return number;}
    public int getPassNumber() {return pass_number;}


    @Override
    public String toString() {
        return "User{" +
                " username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", category'" + category + '\'' +
                '}';
    }
}

