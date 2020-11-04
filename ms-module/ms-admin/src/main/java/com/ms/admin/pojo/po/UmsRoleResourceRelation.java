package com.ms.admin.pojo.po;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
public class UmsRoleResourceRelation implements Serializable {
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    @JsonSerialize(using = ToStringSerializer.class)
    @ApiModelProperty(value = "角色ID")
    private Long roleId;

    @JsonSerialize(using = ToStringSerializer.class)
    @ApiModelProperty(value = "资源ID")
    private Long resourceId;

    private static final long serialVersionUID = 1L;


}