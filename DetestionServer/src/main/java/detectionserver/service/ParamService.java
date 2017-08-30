package detectionserver.service;

import detectionserver.dao.ParamDao;
import detectionserver.model.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hubai on 2017/7/31.
 */
@Service
public class ParamService {
    @Resource
    ParamDao paramDao;
    public List<Param> getParam(){
        return paramDao.getParam();
    }
    public void save(Param param){
        paramDao.saveParam(param);
    }
}
