package com.ms.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ms.admin.pojo.po.UmsAdminRoleRelation;
import com.ms.admin.pojo.po.UmsResource;
import com.ms.admin.pojo.po.UmsRole;

import java.util.List;

/**
 * UmsAdminRoleRelationService --
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/10/19
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/10/19             XiaoBing          v1.0.0           Created
 */
public interface UmsAdminRoleRelationService extends IService<UmsAdminRoleRelation> {

    List<UmsRole> getRoleList(Long adminId);

    List<UmsResource> getResourceList(Long adminId);
}
