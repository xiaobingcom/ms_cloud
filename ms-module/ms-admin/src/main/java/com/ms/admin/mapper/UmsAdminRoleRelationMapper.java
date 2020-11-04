package com.ms.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ms.admin.pojo.po.UmsAdminRoleRelation;
import com.ms.admin.pojo.po.UmsResource;
import com.ms.admin.pojo.po.UmsRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * UmsAdminRoleRelationMapper --
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/10/19
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/10/19             XiaoBing          v1.0.0           Created
 */
public interface UmsAdminRoleRelationMapper extends BaseMapper<UmsAdminRoleRelation> {
    List<UmsRole> selectRoleList(@Param("adminId") Long adminId);

    List<UmsResource> getResourceList(@Param("adminId") Long adminId);
}
