package detectionserver.controller;

import detectionserver.model.Param;
import detectionserver.service.ParamService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by hubai on 2017/7/27.
 */
@Controller
public class testcontroller {
    @Resource
    ParamService paramService;
    @RequestMapping(value = "/test",method = RequestMethod.POST)
    public void test(HttpServletRequest request, HttpServletResponse response) throws Exception{
        /**
         * 防止乱码
         */
        Param param = new Param();
        response.setContentType("text/html;charset=utf-8");
        response. setCharacterEncoding("UTF-8");
        request. setCharacterEncoding("UTF-8");

        System.out.println("Post请求成功");
        String name=request.getParameter("name");
        param.setUser(name);
        String dis = request.getParameter("district");
        String lat = request.getParameter("lat");
        String lon = request.getParameter("lon");
        String tm = request.getParameter("tm");
        String rh = request.getParameter("rh");
        String param1 = request.getParameter("param1");
        String param2 = request.getParameter("param2");
        String time = request.getParameter("time");
        param.setLocation(dis);
        param.setLat(Double.valueOf(lat));
        param.setLon(Double.valueOf(lon));
        param.setTm(Double.valueOf(tm));
        param.setRh(Double.valueOf(rh));
        param.setAqi(Double.valueOf(param1));
        param.setPm25(Double.valueOf(param2));
        param.setTime(time);

        paramService.save(param);

        System.out.println(name);
        System.out.print("\n");
        System.out.println(dis);
        System.out.print("\n");
        System.out.println(lat);
        System.out.print("\n");
        System.out.println(lon);
        System.out.print("\n");
        System.out.println(tm);
        System.out.print("\n");
        System.out.println(rh);
        System.out.print("\n");
        System.out.println(param1);
        System.out.print("\n");
        System.out.println(param2);
        System.out.print("\n");
        response.getWriter().append("Post请求成功");
    }
}
