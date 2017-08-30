package detectionserver.service;


import detectionserver.dao.UserDao;
import detectionserver.model.StoreUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by hubai on 2017/6/19.
 */
@Service
public class AdminService {
    @Autowired
    private UserDao userDao;

    public List<StoreUser> getAllUser(){
        System.out.print("admin service call admin dao");
        List<StoreUser> list = userDao.getAllUser();
        System.out.print("admin service get all users");
        return  list;
    }


    @Transactional
    public int updateStoreUser(int userId, String userName, String loginType) throws Exception{

        int updateUserCount = userDao.updateStoreUserById(userName,loginType,userId);

        if (updateUserCount<1)
            throw new Exception(String.format("更新%s对应的StoreUser信息失败",userId));

        return  updateUserCount;
    }

    @Transactional
    public int addStoreUser(StoreUser user) {

        //int addUserCount = userDao.addStoreUser(userId,userName,pwd,loginType);
        int addUserCount = userDao.addStoreUser(user);

        return  addUserCount;
    }

    @Transactional
    public int deleteUserById(int userId) throws Exception{
        int deleteUserCount = userDao.deleteUserById(userId);
        if (deleteUserCount<0){
            throw new Exception(String.format("删除%d对应的Application信息失败",userId));
        }
        return  deleteUserCount;
    }
}
