package detectionserver.controller;



import detectionserver.model.Product;
import detectionserver.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hubai on 2017/6/15.
 */
@Controller
public class ProductController {
    @Resource
    private ProductService productService;

    //根据商品的pid查询商品
    @RequestMapping(value = "findByPid/{itemId}", method = RequestMethod.GET)
    public String findByPid(@PathVariable("itemId") Integer itemId, Model model) {
        //		map.put("product", productService.findByPid(itemId));
        Product product = productService.findByPid(itemId);
        model.addAttribute("product", product);    //put product

        return "pages/product";
    }

    @RequestMapping(value = "Search", method = RequestMethod.GET)
    public String getSearchProduct(@RequestParam("search")String searchValue, Model model){
        List<Product> productList = productService.findSearch(searchValue);
        model.addAttribute("sList",productList);

        return "pages/search";
    }

    //首页中点击一级分类查询商品
    @RequestMapping(value = "findByCid/{cid}",method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String findByCid(@PathVariable("cid") Integer cid, Model model) {
        List<Product> products = productService.findByCid(cid);
        model.addAttribute("sList",products);
        String cname = productService.findCnameByCid(cid);
        model.addAttribute("cname", cname);
        //  forword redirect
        return "pages/search";
    }


}
