package detectionserver.dao;


import detectionserver.model.Wallet;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by hubai on 2017/6/16.
 */
@Repository
public interface WalletDao {
    Wallet getWalletByUser(int userId);
    void update(Wallet wallet);
    Wallet userLogin(@Param("userId") int userId, @Param("pwd") String pwd);
}
