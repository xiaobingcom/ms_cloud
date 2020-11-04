package com.ms.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ms.admin.pojo.po.UmsMenu;
import com.ms.admin.pojo.po.UmsResource;
import com.ms.admin.pojo.po.UmsRole;

import java.util.List;

/**
 * UmsRoleMapper --
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/10/19
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/10/19             XiaoBing          v1.0.0           Created
 */
public interface UmsRoleMapper extends BaseMapper<UmsRole> {
    /**
     * 根据管理员ID获取目录
     * @param adminId 管理员用户ID
     * @return 资源
     */
    List<UmsMenu> getMenuList(Long adminId);

    /**根据角色ID获取目录
     * @param roleId 角色ID
     * @return 资源列表
     */
    List<UmsMenu> getMenuListByRoleId(Long roleId);

    /**
     * 根据角色ID获取资源
     * @param roleId 角色ID
     * @return 资源ID
     */
    List<UmsResource> getResourceListByRoleId(Long roleId);
}
