package detectionserver.model;

/**
 * Created by hubai on 2017/6/16.
 */
public class OrderItem {
    private Integer itemId;

    private Integer count;

    private Float subtotal;

    private Integer orderId;

    private Integer pid;

    private Integer sellerId;

    // 商品外键:对象
    private Product product;

    // 订单外键:对象
    private Order order;

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Float subtotal) {
        this.subtotal = subtotal;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
        this.pid = product.getItemId();
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public void setSellerId(Integer sellerId){
        this.sellerId =sellerId;
    }

    public Integer getSellerId(){
        return sellerId;
    }
}
