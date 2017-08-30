package detectionserver.controller;

import detectionserver.enums.OptEnum;
import detectionserver.model.Product;
import detectionserver.model.StoreUser;
import detectionserver.service.ProductService;
import detectionserver.service.SuplService;
import detectionserver.service.UserService;
import detectionserver.utils.Messager;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * Created by hubai on 2017/6/19.
 */
@Controller
public class SuplController {
    private Logger log = Logger.getLogger(SuplController.class);
    @Autowired
    private SuplService suplService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @RequestMapping(value = "/supplier",method = RequestMethod.GET)
    public String getAllUsers(Model model, @Param("userId") int userId, HttpSession session) {
        if(session.getAttribute("storeUser")==null)
            return "pages/msg";

        StoreUser user = (StoreUser)session.getAttribute("storeUser");
        if(!user.getLoginType().equals("supplier"))
            return "pages/msg";

        String userName = userService.selectNameById(userId);
        List<Product> products = suplService.getProductsBySeller(userId);
        model.addAttribute("products", products);
        model.addAttribute("userName", userName);
        return "pages/supplier";
    }

    @RequestMapping(value = "/product/{itemId}/detail",method = RequestMethod.GET)
    @ResponseBody
    public Messager detail(@PathVariable("itemId") int itemId) {
        Messager result;
        try {
            Product product = productService.findByPid(itemId);
            result = new Messager(true, product);
        } catch (Exception e) {
            result = new Messager(false, e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/product/{pid}/update",method = RequestMethod.POST)
    @ResponseBody
    public Messager update(@PathVariable("pid") int itemId, Product product){
//    public Messager update(@PathVariable("pid") int userId, @Param("itemName")String itemName,
//                           @Param("sellerName")String sellerName,@Param("price")Float price,
//                           @Param("desc")String desc, @Param("count")int count){
        if(product == null){
            return  new Messager(false, OptEnum.NULLABLE_ARGUMENT.getStateInfo());
        }

        Messager result;
        try {
            int updateProductCount = productService.updateProductById(product);

            if (updateProductCount>0){
                result = new Messager(true,OptEnum.UPDATE_SUCCESS.getStateInfo());
            }else {
                result = new Messager(true,OptEnum.UPDATE_FAIL.getStateInfo());
            }
        } catch (Exception e) {
            result = new Messager(false,e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/product/{itemId}/delete",method = RequestMethod.POST)
    @ResponseBody
    public Messager delete(@PathVariable("itemId") int itemId) {
        Messager result;
        try {
            int deleteCount = productService.deleteByItemId(itemId);
            if(deleteCount>0){
                result = new Messager(true,OptEnum.DELETE_SUCCESS.getStateInfo());
            }else{
                result = new Messager(false,OptEnum.DELETE_FAIL.getStateInfo());
            }

        } catch (Exception e) {
            result = new Messager(false, e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/product/add",method = RequestMethod.POST)
    @ResponseBody
    public Messager add(Product product){

        if(product == null){
            return new Messager(false, OptEnum.NULLABLE_ARGUMENT.getStateInfo());
        }
        Date date = new Date();
        product.setCreateTime(date);
        product.setItemId(date.getDate()+date.getMinutes());
        Messager result;
        int addProductCount = suplService.addProduct(product);
        if (addProductCount>0){
            result = new Messager(true,OptEnum.ADD_SUCCESS.getStateInfo());
        }else {
            result = new Messager(false,OptEnum.ADD_FAIL.getStateInfo());
        }
        return  result;
    }

   

    @RequestMapping(value = "/product/addProduct",method = RequestMethod.POST)
    //public Messager addProduct(Product product,HttpServletRequest rq){
    public Messager addProduct(@RequestParam("upload") MultipartFile upload,Product product){
        System.out.print("get request");
        if(product==null){
            System.out.println("there is no product");
        }

        Messager result = new Messager(true,"receive request");
        return  result;
    }
    @RequestMapping(value = "product/addP",method = RequestMethod.POST)
    public String upload(@RequestParam("uploadfile")MultipartFile user_pic,@RequestParam("pid") int pid){
        try {
            //图片原始名称
            String originalName = user_pic.getOriginalFilename();
            //上传文件处理
            if(user_pic != null && originalName != null && originalName.length()>0){
                //1、保存图片的物理路径
                String store = "F:\\DetestionServer\\src\\main\\webapp\\products\\";

                //2、新的图片名称
                String picNewName = String.valueOf(pid)+".jpg";

                //3、新图片产生
                File file = new File(store+picNewName);

                //4、将内存中的数据写入磁盘
                user_pic.transferTo(file);

                return "supplier";

            }

        } catch (Exception e) {
            log.info("upload failed");
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
       return null;
    }
}
