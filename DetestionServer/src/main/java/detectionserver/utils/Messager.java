package detectionserver.utils;

/**
 * Created by hubai on 2017/6/16.
 */
public class Messager<T> {
    private boolean flag;

    private T data;

    private String message;

    public Messager(){}

    public Messager(boolean flag, T data){
        this.flag = flag;
        this.data = data;
    }

    public Messager(boolean flag, String message){
        this.flag = flag;
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public boolean isFlag() {
        return flag;
    }

    public String getMessage() {
        return message;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    public Boolean getFlag(){
        return flag;
    }
}
