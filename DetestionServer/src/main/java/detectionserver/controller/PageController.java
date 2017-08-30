package detectionserver.controller;

import detectionserver.model.Param;
import detectionserver.service.ParamService;
import detectionserver.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by hubai on 2017/6/15.
 */
@Controller
public class PageController {
    @Resource
    ProductService productService;
    @Resource
    ParamService paramService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String showIndex(Model model) {


        model.addAttribute("hList", productService.findHot());

        model.addAttribute("nList", productService.findNew());

        return "index";
    }

    @RequestMapping("/userLogin")
    public String showLogin() {
        return "login";
    }

    //用户退出
    @RequestMapping(value = "/quit", method = RequestMethod.GET)
    public String quit(HttpSession session, HttpServletRequest request, Model model) {
        request.getSession().invalidate();
        return "login";
    }
    @RequestMapping(value = "/1", method = RequestMethod.GET)
    public String showIndextest1() {
        return "chart";
    }
    @RequestMapping(value = "/2", method = RequestMethod.GET)
    public String showIndextest2(Model model) {
        model.addAttribute("params",paramService.getParam());
        return "table";
    }
}