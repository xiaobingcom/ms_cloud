package com.ms.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ms.admin.mapper.UmsRoleMapper;
import com.ms.admin.mapper.UmsRoleMenuRelationMapper;
import com.ms.admin.mapper.UmsRoleResourceRelationMapper;
import com.ms.admin.pojo.po.*;
import com.ms.admin.service.UmsMenuService;
import com.ms.admin.service.UmsResourceService;
import com.ms.admin.service.UmsRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * 后台角色管理Service实现类
 * Created by macro on 2018/9/30.
 */
@Service
public class UmsRoleServiceImpl implements UmsRoleService {
    @Autowired
    private UmsRoleMapper roleMapper;
    @Autowired
    private UmsRoleMenuRelationMapper roleMenuRelationMapper;
    @Autowired
    private UmsRoleResourceRelationMapper roleResourceRelationMapper;
    @Autowired
    private UmsResourceService resourceService;


    @Override
    public int create(UmsRole role) {
        role.setCreateTime(new Date());
        role.setAdminCount(0);
        role.setSort(0);
        return roleMapper.insert(role);
    }

    @Override
    public int update(Long id, UmsRole role) {
        role.setId(id);
        return roleMapper.updateById(role);
    }

    @Override
    public int delete(List<Long> ids) {
        int count = roleMapper.delete(new QueryWrapper<UmsRole>().in("id",ids));
        resourceService.initResourceRolesMap();
        return count;
    }

    @Override
    public List<UmsRole> list() {
        return roleMapper.selectList(new QueryWrapper<>());
    }

    @Override
    public IPage<UmsRole> list(String keyword, Integer pageSize, Integer pageNum) {
        IPage<UmsRole> page = new Page<>(pageNum, pageSize);
        QueryWrapper<UmsRole> wrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(keyword)) {
            wrapper.like("name",keyword);
        }

        return roleMapper.selectPage(page, wrapper);

    }

    @Override
    public List<UmsMenu> getMenuList(Long adminId) {
        return roleMapper.getMenuList(adminId);
    }

    @Override
    public List<UmsMenu> listMenu(Long roleId) {
        return roleMapper.getMenuListByRoleId(roleId);
    }

    @Override
    public List<UmsResource> listResource(Long roleId) {
        return roleMapper.getResourceListByRoleId(roleId);
    }

    @Override
    public int allocMenu(Long roleId, List<Long> menuIds) {
        //先删除原有关系
        roleResourceRelationMapper.delete(new QueryWrapper<UmsRoleResourceRelation>().eq("role_id",roleId));
        //批量插入新关系
        for (Long menuId : menuIds) {
            UmsRoleMenuRelation relation = new UmsRoleMenuRelation();
            relation.setRoleId(roleId);
            relation.setMenuId(menuId);
            roleMenuRelationMapper.insert(relation);
        }
        return menuIds.size();
    }

    @Override
    public int allocResource(Long roleId, List<Long> resourceIds) {
        //先删除原有关系
        roleResourceRelationMapper.delete(new QueryWrapper<UmsRoleResourceRelation>().eq("role_id",roleId));
        //批量插入新关系
        for (Long resourceId : resourceIds) {
            UmsRoleResourceRelation relation = new UmsRoleResourceRelation();
            relation.setRoleId(roleId);
            relation.setResourceId(resourceId);
            roleResourceRelationMapper.insert(relation);
        }
        resourceService.initResourceRolesMap();
        return resourceIds.size();
    }
}
