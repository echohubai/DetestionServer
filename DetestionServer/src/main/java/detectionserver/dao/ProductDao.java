package detectionserver.dao;


import detectionserver.model.Product;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hubai on 2017/6/15.
 */
@Repository
public interface ProductDao {
    int getSellerIdByPid(int pid);
    List<Product> getProductsBySeller(int sellerId);

    List<Product> findNew();

    List<Product> findHot();

    Product findByPid(int itemId);

    void updateProduct(Product product);

    List<Product> findSearch(String searchValue);

    int updateProductById(Product product);

    int addProduct(Product product);

    int deleteByItemId(int itemId);

    List<Product> findByCid(int cid);

    String findCnameByCid(int cid);
}
