package detectionserver.controller;


import detectionserver.model.Cart;
import detectionserver.model.CartItem;
import detectionserver.model.Product;
import detectionserver.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Created by hubai on 2017/6/16.
 */
@Controller
public class CartController {
    @Autowired
    private ProductService productService;

    @RequestMapping(value = "/myCart",method = RequestMethod.GET)
    public String myCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        return "pages/cart";
    }

    //添加到购物车
    @RequestMapping(value = "/addCart")
    public String addCart(Integer pid, Integer count, HttpSession session, Map<String, Object> map) {
        Product product = productService.findByPid(pid);
        int pcount = product.getCount();
        if(count>pcount){
            map.put("cartFail","no enough products");
            return "pages/product";
        }

        CartItem cartItem = new CartItem();
        cartItem.setCount(count);
        cartItem.setProduct(product);
        cartItem.setPrice(Float.valueOf(product.getPrize()));

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        // 将购物项添加到购物车.
        cart.addCart(cartItem);
        return "pages/cart";

    }

    //删除购物车中的商品
    @RequestMapping(value = "/removeCart/{itemId}",method = RequestMethod.GET)
    public String removeCart(@PathVariable("itemId") Integer pid, HttpSession session) {
        //获得购物车对象
        Cart cart = (Cart) session.getAttribute("cart");
        //根据商品的pid从购物车中移除商品
        cart.removeCart(pid);
        return "pages/cart";
    }

    //清空购物车
    @RequestMapping(value = "/clearCart",method = RequestMethod.GET)
    public String clearCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        cart.clearCart();
        return "pages/cart";
    }
}
