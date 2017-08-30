package detectionserver.service;


import detectionserver.dao.OrderDao;
import detectionserver.dao.ProductDao;
import detectionserver.dao.UserDao;
import detectionserver.model.Order;
import detectionserver.model.OrderItem;
import detectionserver.model.Product;
import detectionserver.model.StoreUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Created by hubai on 2017/6/16.
 */
@Service
public class OrderService {
    @Resource
    private ProductDao productDao;

    @Resource
    private UserDao userDao;

    @Resource
    private OrderDao orderDao;

    @Transactional
    public void save(Order order){
        String userName = order.getUserName();
        String phone = order.getPhone();
        String address = order.getAddress();
        int orderId = order.getOrderId();
        float total = order.getTotal();
        int userId = order.getUserId();
        int state = order.getState();
        Date orderTime = order.getOrderTime();
        int res = orderDao.save(orderId,userName,phone,address,orderTime,total,userId,state);
        if (res == 1){
            order.setOrderId(orderId);
            for (OrderItem item :order.getOrderItems()){
                item.setOrderId(orderId);
                orderDao.saveOrderItem(item);
            }
        }
    }
    public Order findOrderById(int id){
        Order result = orderDao.findOrderById(id);
        int userId = result.getUserId();
        StoreUser user = userDao.getUserById(userId);
        result.setUser(user);

        Set<OrderItem> orderItems = orderDao.findOrderItems(id);
        for (OrderItem orderItem:orderItems){
            Product product = productDao.findByPid(orderItem.getPid());
            orderItem.setProduct(product);
        }
        result.setOrderItems(orderItems);
        return result;
    }
    public Integer findCountByUid(Integer uid){
        Integer count = orderDao.findCountByUid(uid);
        return (count %5 ==0?(count/5) :(count/5+1));

    }
    public List<Order> findByUid(Integer uid,Integer page){
        int rows = 5;
        List<Order> result = orderDao.findPageByUid(uid,(page-1)*5,rows);
        for (Order order: result){
            Set<OrderItem> items = orderDao.findOrderItems(order.getOrderId());
            for (OrderItem orderItem:items){
                int pid = orderItem.getPid();
                Product product = productDao.findByPid(pid);
                orderItem.setProduct(product);
            }
            order.setOrderItems(items);
        }
        return result;
    }
    @Transactional
    public void updateOrder(Order order){
        orderDao.update(order);
    }
    public List<Order> findSearch(int searchValue){
        //searchValue = "%"+searchValue+"%";

        List<Order> orders= orderDao.findSearch(searchValue);
        for (Order order:orders){
            int  id = order.getOrderId();
            Set<OrderItem> orderItems = orderDao.findOrderItems(id);
            for (OrderItem orderItem:orderItems){
                Product product = productDao.findByPid(orderItem.getPid());
                orderItem.setProduct(product);
            }
            order.setOrderItems(orderItems);
        }
        return orders;
    }
    public List<OrderItem> getOrderItemsBySeller(int sellerId){
        return  orderDao.getOrderItemsBySeller(sellerId);
    }
}
