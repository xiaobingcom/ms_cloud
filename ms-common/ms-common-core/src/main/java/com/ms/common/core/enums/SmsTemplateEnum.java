package com.ms.common.core.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 短信模板
 *@author  xiao bing
 */
@Getter
@AllArgsConstructor
public enum SmsTemplateEnum {

    /**
     * 登录
     */
    LOG_IN(0, "SMS_196260256"),

    /**
     * 注册
     */
    REGISTERED(1, "SMS_196260254"),

    /**
     * 忘记密码
     */
    FORGET_PASSWORD(2, "SMS_196260257"),


    /**
     * 数据变更
     */
    UPDATE_DATA(3, "SMS_196260252");




    private final int type;

    private final String template;


    public static String getTemplateByType(int type) {

        SmsTemplateEnum[] values = SmsTemplateEnum.values();

        for (SmsTemplateEnum value : values) {
            if (value.type == type) {
                return value.template;
            }
        }

        return null;
    }


}
