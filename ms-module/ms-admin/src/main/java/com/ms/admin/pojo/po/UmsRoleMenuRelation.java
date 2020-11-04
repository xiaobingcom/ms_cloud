package com.ms.admin.pojo.po;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
public class UmsRoleMenuRelation implements Serializable {
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    @JsonSerialize(using = ToStringSerializer.class)
    @ApiModelProperty(value = "角色ID")
    private Long roleId;

    @JsonSerialize(using = ToStringSerializer.class)
    @ApiModelProperty(value = "菜单ID")
    private Long menuId;

    private static final long serialVersionUID = 1L;

}