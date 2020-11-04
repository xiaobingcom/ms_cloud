package com.ms.admin.pojo.po;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serializable;

@Data
public class UmsAdminPermissionRelation implements Serializable {
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    @JsonSerialize(using = ToStringSerializer.class)
    private Long adminId;

    @JsonSerialize(using = ToStringSerializer.class)
    private Long permissionId;

    private Integer type;

    private static final long serialVersionUID = 1L;


}