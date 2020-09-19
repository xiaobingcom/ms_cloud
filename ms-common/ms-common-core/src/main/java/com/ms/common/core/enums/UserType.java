package com.ms.common.core.enums;

/**
 * 用户类型
 *
 * @author XIAOBING
 */
public enum UserType {
    ADMIN("ADMIN", "总后台", 0),
    USER("USER", "用户", 1),
    FEIGN("FEIGN", "内部调用", 2);

    private final String code;
    private final Integer type;
    private final String info;

    UserType(String code, String info, Integer type) {
        this.code = code;
        this.info = info;
        this.type = type;
    }

    public String getCode() {
        return code;
    }

    public String getInfo() {
        return info;
    }

    public Integer getType() {
        return type;
    }

    public static UserType getByCode(String code) {

        UserType[] values = UserType.values();

        for (UserType value : values) {
            if (value.getCode().equals(code)) {
                return value;
            }
        }

        return null;
    }
}
