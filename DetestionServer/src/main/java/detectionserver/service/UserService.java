package detectionserver.service;


import detectionserver.dao.UserDao;
import detectionserver.model.StoreUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by hubai on 2017/6/16.
 */
@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public String selectNameById(int userId){
        return  userDao.selectNameById(userId);
    }

    public StoreUser userLogin(String userName, String pwd){
        return  userDao.userLogin(userName, pwd);
    }

    public StoreUser getUserById(int userId){
        return userDao.getUserById(userId);
    }

    @Transactional
    public  int updateUser(StoreUser user){return userDao.updateStoreUser(user);}

    @Transactional
    public int updateUserPwd(int userId, String pwd){
        return userDao.updateUserPwd(userId,pwd);
    }
}
