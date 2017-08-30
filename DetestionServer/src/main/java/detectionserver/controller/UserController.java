package detectionserver.controller;


import detectionserver.enums.OptEnum;
import detectionserver.model.StoreUser;
import detectionserver.service.UserService;
import detectionserver.utils.Messager;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by hubai on 2017/6/16.
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;
    private Logger log = Logger.getLogger(UserController.class);

    @RequestMapping(value = "/user/getName",method = RequestMethod.GET)
    @ResponseBody
    public boolean getNameById(@RequestParam("userId")int id){
        System.out.println(id);
        String name = userService.selectNameById(id);
        if(name == null){
            System.out.println("there is no name");
            return  false;
        }
        System.out.println("The name is : "+name);
        return true;
    }


    @RequestMapping(value = "/user/login",method=RequestMethod.GET)
    @ResponseBody
    public Messager login(HttpServletResponse response, HttpServletRequest request, HttpSession session,
                          @RequestParam("username")String userName, @RequestParam("password")String passWord){

        Messager result = new Messager();

        try{

            StoreUser storeUser = userService.userLogin(userName, passWord);

            if(storeUser!=null){
                String userType = storeUser.getLoginType().trim();
                if(userType.equals("admin")||userType.equals("normal")||userType.equals("supplier")){
                    session.setAttribute("storeUser", storeUser);
                    //session.setMaxInactiveInterval(10);
                    result.setFlag(true);
                    result.setMessage("success");

                }else {
                    result.setFlag(false);
                    result.setMessage("Invalid userName or password.");

                }
            }else {
                result.setFlag(false);
                result.setMessage("Invalid userName or password.");

            }

        } catch (Exception e){
            e.printStackTrace();
            result.setMessage(e.getMessage());
        }
       log.info(result.getMessage());
        return result;
    }


    @RequestMapping(value="/user/{userId}/settings",method = RequestMethod.GET)
    public String getUserInfo(HttpSession session, @PathVariable("userId")int userId, Model model){

        if(session.getAttribute("storeUser")==null)
            return "pages/msg";

        StoreUser user = (StoreUser)session.getAttribute("storeUser");
        if (user.getUserId()==userId){
            StoreUser mUser = userService.getUserById(userId);
            model.addAttribute("me",mUser);
            return "pages/setUserInfo";
        }

        return "pages/msg";
    }

    @RequestMapping(value="/user/{userId}/setInfo",method = RequestMethod.POST)
    @ResponseBody
    public Messager setUserInfo(@PathVariable("userId") int userId, @Param("userName")String userName,
                                @Param("phone")String phone, @Param("address")String address,
                                @Param("email")String email, HttpSession session){
        Messager result = null;
        StoreUser user = (StoreUser) session.getAttribute("storeUser");
        if(user.getUserId()!=userId){
            return new Messager(false, OptEnum.UPDATE_FAIL.getStateInfo());
        }
        user.setUserName(userName.trim());
        user.setAddress(address.trim());
        user.setEmail(email.trim());
        user.setPhone(phone.trim());
        int count = userService.updateUser(user);
        if(count<1){
            result = new Messager(false,OptEnum.UPDATE_FAIL.getStateInfo());
        }else {
            result = new Messager(true,OptEnum.UPDATE_SUCCESS.getStateInfo());
        }
        return result;
    }

    @RequestMapping(value="/user/{userId}/setPwd",method = RequestMethod.POST)
    @ResponseBody
    public Messager setUserPwd(@PathVariable("userId") int userId,@Param("pwd")String pwd){
        Messager result = null;
        int count = 0;
        try {
            count = userService.updateUserPwd(userId, pwd.trim());
        } catch (Exception e) {
            e.printStackTrace();
            return new Messager(false, OptEnum.UPDATE_FAIL.getStateInfo());
        }
        if(count<1){
            result = new Messager(false,OptEnum.UPDATE_FAIL.getStateInfo());
        }else {
            result = new Messager(true,OptEnum.UPDATE_SUCCESS.getStateInfo());
        }
        return  result;
    }

}
