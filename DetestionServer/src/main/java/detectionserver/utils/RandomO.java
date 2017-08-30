package detectionserver.utils;

import java.util.Random;

/**
 * Created by hubai on 2017/6/20.
 */
public class RandomO {

     int  max=10000000;
    public static int getRandomID(){
        int  max=10000000;
        Random random = new Random();
        int s = random.nextInt(max);
        return s;
    }
}
