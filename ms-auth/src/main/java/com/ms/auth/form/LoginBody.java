package com.ms.auth.form;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 用户登录对象
 *
 * @author xiaobing
 */
@Data
public class LoginBody {
    /**
     * 用户名
     */
    @ApiModelProperty(value = "账号/手机号/用户名")
    private String username;

    /**
     * 用户密码
     */
    @ApiModelProperty(value = "用户密码")
    private String password;

    /**
     * 用户类型
     */
    @ApiModelProperty(value = "用户类型（USER）")
    private String userType;

    /**
     * 唯一标识(安卓等设备号)
     */
    private String uuid = "";


}
