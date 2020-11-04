package com.ms.common.domain;

import lombok.Data;

import java.math.BigDecimal;

/**
 * DragonBeadReturnVo --
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/10/12
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/10/12             XiaoBing          v1.0.0           Created
 */
@Data
public class DragonBeadPutVo {
    /**
     * 用户ID
     */
    private Long uid;

    /**
     * 金额
     */
    private BigDecimal amount;
    /**
     * 订单ID
     */
    private Long orderId;

    /**
     * 商户ID
     */
    private Long mid;

    /**
     * 加密
     */
    private String sign;

    /**
     * 请求服务时间
     */
    private int time;
}
