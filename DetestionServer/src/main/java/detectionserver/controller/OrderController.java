package detectionserver.controller;


import detectionserver.enums.OptEnum;
import detectionserver.model.*;
import detectionserver.service.OrderService;
import detectionserver.service.ProductService;
import detectionserver.service.WalletService;
import detectionserver.utils.Messager;
import detectionserver.utils.RandomO;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Created by hubai on 2017/6/16.
 */
@Controller
public class OrderController {
    private Logger log = Logger.getLogger(OrderController.class);
    @Resource
    private OrderService orderService;

    @Resource
    private WalletService walletService;

    @Resource
    private ProductService productService;

    //保存订单
    @RequestMapping(value = "/saveOrder", method = RequestMethod.GET)
    public String saveOrder(HttpSession session, Map<String, Object> map) {
        //判断用户是否登陆,
        StoreUser user = (StoreUser) session.getAttribute("storeUser");
        if (user == null) {
            map.put("notLogin", "noLogin");
            return "pages/msg";
        }
        //从session获取购物车对象
        Cart cart = (Cart) session.getAttribute("cart");
        //如果购物车为空，则返回到我的购物车页面
        if (cart == null) {
            return "pages/cart";
        }
        //订单对象
        Order order = new Order();
        order.setTotal(cart.getTotal());

        // 1:未付款. 2.已经付款，没有发货 3.发货，没有确认发货 4.交易完成 5.商家取消订单
        order.setState(1);
        // 设置订单时间
        Date date = new Date();
        order.setOrderTime(date);
        // 设置订单关联的客户:
        order.setUser(user);
        order.setUserId(user.getUserId());
        order.setAddress(user.getAddress());
        order.setPhone(user.getPhone());
        int oid = RandomO.getRandomID();
        //设置随机生成的订单ID

        order.setOrderId(oid);
        log.info(String.valueOf(oid));
        //log.info(String.valueOf(oid));
        // 设置订单项集合:
        Set<OrderItem> sets = new HashSet<OrderItem>();
        for (CartItem cartItem : cart.getCartItems()) {
            // 订单项的信息从购物项获得的.
            OrderItem orderItem = new OrderItem();
            orderItem.setCount(cartItem.getCount());

            orderItem.setSubtotal(cartItem.getSubtotal());
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setSellerId(cartItem.getProduct().getSellerId());
            //双向关联时在多的一方设置一的一方的属性
            orderItem.setOrder(order);
            //把orderItem对象添加到集合中
            sets.add(orderItem);
        }
        //双向关联时在一的一方设置多的一方的属性
        order.setOrderItems(sets);


        orderService.save(order);
        //清除购物车
        cart.clearCart();

        map.put("order", order);
        map.put("me",user);
        return "pages/order";
    }

    //根据订单id查询订单
    @RequestMapping(value = "findByOid/{oid}", method = RequestMethod.GET)
    public String findByOid(@PathVariable("oid") Integer oid,
                            Map<String, Object> map) {
        Order order = orderService.findOrderById(oid);
        map.put("order", order);
        return "pages/order";
    }
    //订单用户确认收货
    @RequestMapping(value = "updateState/{oid}",method = RequestMethod.GET)
    public  String updateState(@PathVariable("oid") Integer oid,Map<String,Object> map){
        Order order = orderService.findOrderById(oid);
        order.setState(4);
        orderService.updateOrder(order);
        map.put("order",order);
        return  "pages/comment";
    }
    //订单评价，数据库未完成
    @RequestMapping(value = "/comment",method = RequestMethod.POST)
    public String comment(String comment){
        log.info(comment);
        return "pages/commentsuccess";
    }

    /* 确认订单的操作,为订单付款:
 * addr:收货人地址 name:收货人 phone:联系电话  oid:订单的oid
 * pd_FrpId:接收支付通道编码
 */
    @RequestMapping(value = "/payOrder", method = RequestMethod.POST)
    public String payOrder(Integer oid, String address, String name, String phone, String total, HttpSession session,
                           Map<String, Object> map) {
        Order order = orderService.findOrderById(oid);
        order.setAddress(address);
        order.setUserName(name);
        order.setPhone(phone);
        orderService.updateOrder(order);

        Wallet wallet = walletService.getWalletByUser(order.getUser().getUserId());

        if (wallet == null) {
            map.put("paymentFalse", "no wallet");
            return "pages/orderList";
        }

        Float money = wallet.getMoney();
        Float total_paid = Float.parseFloat(total);

        if (money >= total_paid) {
            for (OrderItem orderItem : order.getOrderItems()) {
                Integer pid = orderItem.getPid();
                Product product = productService.findByPid(pid);
                orderItem.setItemId(RandomO.getRandomID());
                orderItem.setProduct(product);
                Integer count = product.getCount();
                product.setCount(count - orderItem.getCount());
                productService.updateProduct(product);
            }
        } else {
            map.put("paymentFalse", "no enough money");
            return "pages/orderList";
        }
        wallet.setMoney(money - total_paid);
        walletService.update(wallet);
        order.setState(2);
        orderService.updateOrder(order);
        log.info("nowsuccess");
        map.put("paymentSuccess", "下单成功！");
        return "pages/success";
    }

    //查询订单分页
    @RequestMapping(value = "findOrderByUid/{page}", method = RequestMethod.GET)
    public String findOrderByUid(HttpSession session, Map<String, Object> map
            , @PathVariable("page") Integer page) {
        //从session获取user对象
        StoreUser user = (StoreUser) session.getAttribute("storeUser");
        if (user == null) {
            map.put("notLogin", "notLogin");
            return "pages/msg";
        }
        //查询总共有多少页的数据
        Integer PageCount = orderService.findCountByUid(user.getUserId());
        if (page > PageCount) {
            page = 1;
        }
        //根据用户分页查询订单
        List<Order> orders = orderService.findByUid(user.getUserId(), page);

        map.put("orders", orders);
        map.put("page", page);
        map.put("count", PageCount);
        return "pages/orderList";
    }

    //查询当前用户的订单
    @RequestMapping(value = "findOrderByUid/Search", method = RequestMethod.GET)
    public String getSearchOrder(@RequestParam("search") String searchValue, Model model) {
        List<Order> orders = orderService.findSearch(Integer.parseInt(searchValue));
        model.addAttribute("orders", orders);

        return "pages/ordersearch";
    }

    //商品供应商商品订单
    @RequestMapping(value = "/dealOrder", method = RequestMethod.GET)
    public String getOrderBySellerId(Model model, @Param("userId") int userId, HttpSession session) {
        if (session.getAttribute("storeUser") == null)
            return "pages/msg";

        StoreUser user = (StoreUser) session.getAttribute("storeUser");
        if (!user.getLoginType().equals("supplier"))
            return "pages/msg";
        List<OrderItem> orderItems = orderService.getOrderItemsBySeller(userId);
        Set<Order> orders = new HashSet<Order>();
        Set<Product> products = new HashSet<Product>();
        for (OrderItem orderItem : orderItems) {
            Order order = orderService.findOrderById(orderItem.getOrderId());
            orders.add(order);
            Product product = productService.findByPid(orderItem.getPid());
            products.add(product);
        }
        model.addAttribute("orders", orders);
        model.addAttribute("orderItems", orderItems);
        model.addAttribute("products", products);

        return "pages/orderdeal";
    }

    //商品订单处理
    @RequestMapping(value = "/dealOrder/{orderId}/send", method = RequestMethod.POST)
    @ResponseBody
    public Messager send(@PathVariable("orderId") int orderId) {
        Messager result;
        try {
            Order order = orderService.findOrderById(orderId);
            order.setState(3);
            orderService.updateOrder(order);
            result = new Messager(true, OptEnum.UPDATE_SUCCESS.getStateInfo());

        } catch (Exception e) {
            e.printStackTrace();
            result = new Messager(false, e.getMessage());
        }
        return result;
    }
    //商家取消订单
    @RequestMapping(value = "/dealOrder/{orderId}/cancel", method = RequestMethod.POST)
    @ResponseBody
    public Messager cancelOrder(@PathVariable("orderId") int orderId) {
        Messager result;
        try {
            Order order = orderService.findOrderById(orderId);
            order.setState(5);
            orderService.updateOrder(order);
            result = new Messager(true, OptEnum.UPDATE_SUCCESS.getStateInfo());

        } catch (Exception e) {
            e.printStackTrace();
            result = new Messager(false, e.getMessage());
        }
        return result;
    }
    //支付密码校验
    @RequestMapping(value="/Order/{userId}/confirmPay",method = RequestMethod.POST)
    @ResponseBody
    public Messager confirmPay(@PathVariable("userId" )int userId,@Param("pwd") String pwd,HttpSession session){
         Messager result= new Messager();
        StoreUser user = (StoreUser) session.getAttribute("storeUser");
        if(user.getUserId()!=userId){
            result.setFlag(false);
            result.setMessage("用户没有登录");
            return result;
        }
        //通过userId获得支付密码
           String mpwd = walletService.getWalletByUser(userId).getPwd().trim();
             log.info(pwd);
             log.info(mpwd);

        if (mpwd.equals(pwd)){
              result.setFlag(true);
              result.setMessage("支付成功");
               return result;

           }
           else {
             result.setFlag(false);
             result.setMessage("支付失败，密码错误！");
               return result ;
           }
    }
}