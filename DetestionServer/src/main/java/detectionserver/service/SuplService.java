package detectionserver.service;


import detectionserver.dao.ProductDao;
import detectionserver.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by hubai on 2017/6/19.
 */
@Service
public class SuplService {
    @Autowired
    private ProductDao productDao;

    public List<Product> getProductsBySeller(int sellerId){
        return  productDao.getProductsBySeller(sellerId);
    }

    @Transactional
    public int addProduct(Product product){
        product.setCreateTime(new Date());
        int result = productDao.addProduct(product);
        return  result;
    }


}
