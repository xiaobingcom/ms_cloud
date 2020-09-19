package com.ms.auth.domain;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * 用户对象 tb_user
 *
 * @author xiaobing
 * @date 2020-07-14
 */
@Data
public class TbUser {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @JsonSerialize(using = ToStringSerializer.class)
    @TableId(value = "id", type = IdType.ID_WORKER)
    @ApiModelProperty(value = "主键")
    private Long id;

    /**
     * 昵称
     */
    @TableField(value = "nike_name", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "昵称")
    private String nikeName;

    /**
     * 手机号
     */
    @TableField(value = "phone", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "手机号")
    private String phone;

    /**
     * 创建时间
     */
    @TableField(value = "create_date", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "创建时间")
    private Date createDate;

    /**
     * 修改时间
     */
    @TableField(value = "update_date", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "修改时间")
    private Date updateDate;

    /**
     * 修改人
     */
    @JsonSerialize(using = ToStringSerializer.class)
    @TableField(value = "update_pid", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "修改时间")
    private Long updatePid;

    /**
     * 创建人
     */
    @JsonSerialize(using = ToStringSerializer.class)
    @TableField(value = "create_pid", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "修改时间")
    private Long createPid;

    /**
     * 头像
     */
    @TableField(value = "icon", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "头像")
    private String icon;
    /**
     * 性别
     */
    @TableField(value = "sex", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    @ApiModelProperty(value = "性别")
    private Integer sex;


    /**
     * 设备唯一编号
     */
    @ApiModelProperty("设备唯一编号")
    @TableField(value = "registration_id", updateStrategy = FieldStrategy.NOT_EMPTY, insertStrategy = FieldStrategy.NOT_EMPTY)
    private String registrationId;



}
