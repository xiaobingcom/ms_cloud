package com.ms.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ms.admin.mapper.UmsAdminRoleRelationMapper;
import com.ms.admin.pojo.po.UmsAdminRoleRelation;
import com.ms.admin.pojo.po.UmsResource;
import com.ms.admin.pojo.po.UmsRole;
import com.ms.admin.service.UmsAdminRoleRelationService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * UmsAdminRoleRelationServiceImpl --
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/10/19
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/10/19             XiaoBing          v1.0.0           Created
 */
@Service
public class UmsAdminRoleRelationServiceImpl extends ServiceImpl<UmsAdminRoleRelationMapper, UmsAdminRoleRelation> implements UmsAdminRoleRelationService {



    @Override
    public List<UmsRole> getRoleList(Long adminId) {
        return this.baseMapper.selectRoleList(adminId);
    }

    @Override
    public List<UmsResource> getResourceList(Long adminId) {
        return this.baseMapper.getResourceList(adminId);

    }
}
