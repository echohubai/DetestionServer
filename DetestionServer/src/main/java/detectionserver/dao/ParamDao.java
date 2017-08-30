package detectionserver.dao;

import detectionserver.model.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by hubai on 2017/7/31.
 */
@Repository
public interface ParamDao {
    int saveParam(Param param);
    List<Param> getParam();
}
