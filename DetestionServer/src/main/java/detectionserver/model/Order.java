package detectionserver.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by hubai on 2017/6/16.
 */
public class Order {
    private Integer orderId;
    private Float total;
    private Date orderTime;
    private Integer state;// 1:未付款   2:订单已经付款   3:已经发货   4:订单结束
    private String userName;
    private String phone;
    private String address;
    private Integer userId;

    // 用户的外键:对象
    private StoreUser user;
    // 配置订单项的集合
    //mappedBy="order"指明order为双向关系维护端是由哪个属性来维护
    //cascade级联操作级别,refresh:级联刷新,remove级联删除

    private Set<OrderItem> orderItems = new HashSet<OrderItem>();

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Float getTotal() {
        return total;
    }

    public void setTotal(Float total) {
        this.total = total;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
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

    public StoreUser getUser() {
        return user;
    }

    public void setUser(StoreUser user) {
        this.user = user;
        setUserName(user.getUserName());
    }

    public Set<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(Set<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
