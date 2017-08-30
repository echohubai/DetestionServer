package detectionserver.enums;

/**
 * Created by hubai on 2017/6/16.
 */
public enum OptEnum {
    NULLABLE_ARGUMENT(0, "参数不能为空"),

    UPDATE_SUCCESS(1, "更新成功"),

    UPDATE_FAIL(-1, "更新失败"),

    ADD_SUCCESS(2, "添加成功"),

    ADD_FAIL(-2, "添加失败"),

    DELETE_SUCCESS(3, "删除成功"),

    DELETE_FAIL(-3, "删除失败");

    private int state;

    private String stateInfo;

    OptEnum(int state, String stateInfo) {
        this.state = state;
        this.stateInfo = stateInfo;
    }

    public int getState() {
        return state;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    public static OptEnum stateOf(int index) {
        for (OptEnum state : values()) {
            if (state.getState() == index) {
                return state;
            }
        }
        return null;
    }

}
