package Bean;
/*
定义一个Bean，用来接收或传递Word表中的数据
 */
public class Word {
    private String english;
    private String chinese;

    public Word(String english,String chinese) {
        this.chinese=chinese;
        this.english=english;

    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getChinese() {
        return chinese;
    }

    public void setChinese(String chinese) {
        this.chinese = chinese;
    }

}