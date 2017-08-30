package detectionserver.model;

/**
 * Created by hubai on 2017/6/16.
 */
public class Wallet {
    private Integer wid;
    private Float money;
    private Integer userId;
    private StoreUser user;
    private String pwd;

    public StoreUser getUser() {
        return user;
    }

    public void setUser(StoreUser user) {
        this.user = user;
    }

    public Integer getWid() {
        return wid;
    }

    public void setWid(Integer wid) {
        this.wid = wid;
    }

    public Float getMoney() {
        return money;
    }

    public void setMoney(Float money) {
        this.money = money;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public  String getPwd(){
        return pwd;
    }
}
