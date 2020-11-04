package com.ms.admin.pojo.vo;

import lombok.Data;

/**
 * @author xd
 * @Title: MallUserVo
 * @Package com.zsb.vo
 * @Description: 商场所需user 信息
 * @date 2020/9/23 15:12
 */
@Data
public class MallUserVo {

    /** 20 用户id*/
    private Long userId;

    /**  3 用户类型;1:admin;2:会员 */
    private Byte userType;

    /**  3 性别;0:保密,1:男,2:女 */
    private Byte sex;

    /**  10 生日 */
    private Integer birthday;

    /**  255 用户头像 */
    private String avatar;

    /**  20 用户手机号 */
    private String mobile;

    /**  100 token值 */
    private String token;

    /**  10 级别id */
    private Integer level;

    /**  30 身份证号1 */
    private String idcardNumber;

    /**  30 姓名 */
    private String name;
}
