package detectionserver.controller;

import detectionserver.enums.OptEnum;
import detectionserver.model.StoreUser;
import detectionserver.service.AdminService;
import detectionserver.service.UserService;
import detectionserver.utils.Messager;
import detectionserver.utils.RandomO;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created by hubai on 2017/6/19.
 */
@Controller
public class AdminController {
    private Logger log = Logger.getLogger(OrderController.class);
    @Autowired
    private AdminService adminService;

    @Autowired
    private UserService userService;


    @RequestMapping(value = "/admin",method = RequestMethod.GET)
    public String getAllUsers(Model model, HttpSession session) {
        if(session.getAttribute("storeUser")==null)
            return "pages/msg";

        StoreUser user = (StoreUser)session.getAttribute("storeUser");
        if(!user.getLoginType().equals("admin"))
            return "pages/msg";

        List<StoreUser> users = adminService.getAllUser();
        model.addAttribute("users", users);
        return "pages/admin";
    }


    @RequestMapping(value = "/administrator/{userId}/detail",method = RequestMethod.POST)
    @ResponseBody
    public Messager detail(@PathVariable("userId") int userId) {
        Messager result;
        try {
            StoreUser user = userService.getUserById(userId);
            result = new Messager(true, user);
            log.info(result.getMessage());

        } catch (Exception e) {
            result = new Messager(false, e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/administrator/{userId}/delete",method = RequestMethod.POST)
    @ResponseBody
    public Messager delete(@PathVariable("userId") int userId) {
        Messager result;
        try {
            int deleteCount = adminService.deleteUserById(userId);
            if(deleteCount>0){
                result = new Messager(true, OptEnum.DELETE_SUCCESS.getStateInfo());
            }else{
                result = new Messager(false,OptEnum.DELETE_FAIL.getStateInfo());
            }

        } catch (Exception e) {
            result = new Messager(false, e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/administrator/{userId}/update",method = RequestMethod.POST)
    @ResponseBody
    public Messager update(@PathVariable("userId") int userId, StoreUser user){
        if(user == null){
            return  new Messager(false, OptEnum.NULLABLE_ARGUMENT.getStateInfo());
        }

        Messager result;
        try {
            int updateStoreUserCount = adminService.updateStoreUser(userId,user.getUserName(),user.getLoginType());

            if (updateStoreUserCount>0){
                result = new Messager(true,OptEnum.UPDATE_SUCCESS.getStateInfo());
            }else {
                result = new Messager(true,OptEnum.UPDATE_FAIL.getStateInfo());
            }
        } catch (Exception e) {
            result = new Messager(false,e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/administrator/add",method = RequestMethod.POST)
    @ResponseBody
    public Messager add(StoreUser user){

        Messager result;
        Date date = new Date();
        user.setUserId(RandomO.getRandomID());

            int addUserCount = adminService.addStoreUser(user);
           result=null;


        return result;
    }

}
