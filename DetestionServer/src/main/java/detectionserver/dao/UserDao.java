package detectionserver.dao;


import detectionserver.model.StoreUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hubai on 2017/6/16.
 */
@Repository
public interface UserDao {
    String selectNameById(int userId);

    StoreUser userLogin(@Param("userName") String userName, @Param("pwd") String pwd);

    StoreUser getUserById(int userId);

    List<StoreUser> getAllUser();

    int updateStoreUserById(@Param("userName") String userName,
                            @Param("loginType") String loginType, @Param("userId") int userId);

    int addStoreUser(StoreUser user);

    int deleteUserById(int userId);

    int updateStoreUser(StoreUser user);

    int updateUserPwd(@Param("userId") int userId, @Param("pwd") String pwd);
}
