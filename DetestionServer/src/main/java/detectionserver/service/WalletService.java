package detectionserver.service;


import detectionserver.dao.WalletDao;
import detectionserver.model.Wallet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by hubai on 2017/6/16.
 */
@Service
public class WalletService {
    @Autowired
    private WalletDao walletDao;

    public Wallet getWalletByUser(int userId){
        return walletDao.getWalletByUser(userId);
    }
    @Transactional
    public void update(Wallet wallet){
        walletDao.update(wallet);
    }

    public Wallet userLogin(int userId,String pwd){
        return  walletDao.userLogin(userId,pwd);
    }

}
