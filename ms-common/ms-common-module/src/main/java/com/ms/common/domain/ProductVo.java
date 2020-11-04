package com.ms.common.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 移动端商品
 * @author 肖兵
 * @version v1.0.0
 * @date 2020/10/21
 * 历史版本 Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/10/21              肖兵             v1.0.0           Created
 */
@Data
public class ProductVo {

    @ApiModelProperty("商品ID")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    /**
     * 商品名称
     */
    @ApiModelProperty("商品名称")
    private String name;


    /**
     * 商品价格
     */
    @ApiModelProperty("商品价格")
    private BigDecimal price;

    /**
     * 商品龙珠价格
     */
    @ApiModelProperty("商品龙珠价格")
    private BigDecimal rmb;

    /**
     * 销量
     */
    @ApiModelProperty("销量")
    private Integer sale;

    /**
     * 市场价
     */
    @ApiModelProperty(value = "市场价")
    private BigDecimal originalPrice;

    private String pic;

}
