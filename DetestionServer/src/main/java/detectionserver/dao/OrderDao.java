package detectionserver.dao;


import detectionserver.model.Order;
import detectionserver.model.OrderItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Created by hubai on 2017/6/16.
 */
@Repository
public interface OrderDao {
    int save(@Param("orderId") int orderId,
             @Param("userName") String userName, @Param("phone") String phone,
             @Param("address") String address, @Param("orderTime") Date orderTime,
             @Param("total") float total, @Param("userId") int userId, @Param("state") int state);

    Order findOrderById(@Param("id") int id);

    Integer findCountByUid(Integer userId);

    List<Order> findPageByUid(@Param("userId") Integer userId,
                              @Param("first") Integer first,
                              @Param("limit") Integer limit);

    void update(Order order);

    void saveOrderItem(OrderItem orderItem);

    Set<OrderItem> findOrderItems(int oid);

    int getOrderId();
    List<Order> findSearch(int searchValue);
    List<OrderItem> getOrderItemsBySeller(int sellerId);

}
