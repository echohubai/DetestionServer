package detectionserver.model;

/**
 * Created by hubai on 2017/6/16.
 */
public class StoreUser {
    private int userId;
    private String userName;
    private String pwd;
    private String phone;
    private String address;
    private String email;
    private String loginType;

    public StoreUser(){
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public String getPwd() {
        return pwd;
    }

    public String getLoginType() {
        return loginType;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }

    @Override
    public  String toString(){
        return "Authentication{" +
                "userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", pwd='" + pwd + '\'' +
                '}';
    }
}
