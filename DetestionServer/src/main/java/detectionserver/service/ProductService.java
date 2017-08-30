package detectionserver.service;




import detectionserver.dao.ProductDao;
import detectionserver.model.Product;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hubai on 2017/6/15.
 */
@Service
public class ProductService {
    @Resource
    private ProductDao productDao;

    public List<Product> findHot(){
        return  productDao.findHot();
    }

    public List<Product> findNew(){
        return  productDao.findNew();
    }

    public Product findByPid(int itemId){
        return productDao.findByPid(itemId);
    }

    @Transactional
    public void updateProduct(Product product){
        productDao.updateProduct(product);
    }

    public List<Product> findSearch(String searchValue){
        searchValue = "%"+searchValue+"%";
        return productDao.findSearch(searchValue);
    }

    @Transactional
    public int deleteByItemId(int itemId)  {
        int deleteCount = productDao.deleteByItemId(itemId);
        return deleteCount;
    }
    @Transactional
    public int updateProductById(Product product){
        return productDao.updateProductById(product);
    }


    public List<Product> findByCid(int cid){
        return productDao.findByCid(cid);
    }

    public String findCnameByCid(int cid){
        return productDao.findCnameByCid(cid);
    }
    @Transactional
    public int getSellerByPid(int pid){
        return productDao.getSellerIdByPid(pid);
    }
}
