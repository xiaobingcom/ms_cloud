package com.ms.admin.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ms.admin.mapper.UmsResourceMapper;
import com.ms.admin.mapper.UmsRoleMapper;
import com.ms.admin.mapper.UmsRoleResourceRelationMapper;
import com.ms.admin.pojo.po.UmsResource;
import com.ms.admin.pojo.po.UmsRole;
import com.ms.admin.pojo.po.UmsRoleResourceRelation;
import com.ms.admin.service.UmsResourceService;
import com.ms.common.core.constant.AuthConstant;
import com.ms.common.core.utils.GsonUtil;
import com.ms.common.redis.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 后台资源管理Service实现类
 * Created by macro on 2020/2/2.
 */
@Service
public class UmsResourceServiceImpl implements UmsResourceService {
    @Autowired
    private UmsResourceMapper resourceMapper;
    @Autowired
    private UmsRoleMapper roleMapper;
    @Autowired
    private UmsRoleResourceRelationMapper roleResourceRelationMapper;
    @Autowired
    private RedisService redisService;
    @Value("${spring.application.name}")
    private String applicationName;

    @Override
    public int create(UmsResource umsResource) {
        umsResource.setCreateTime(new Date());
        int count = resourceMapper.insert(umsResource);
        initResourceRolesMap();
        return count;
    }

    @Override
    public int update(Long id, UmsResource umsResource) {
        umsResource.setId(id);
        int count = resourceMapper.updateById(umsResource);
        initResourceRolesMap();
        return count;
    }

    @Override
    public UmsResource getItem(Long id) {
        return resourceMapper.selectById(id);
    }

    @Override
    public int delete(Long id) {
        int count = resourceMapper.deleteById(id);
        initResourceRolesMap();
        return count;
    }

    @Override
    public IPage<UmsResource> list(Long categoryId, String nameKeyword, String urlKeyword, Integer pageSize, Integer pageNum) {
        IPage<UmsResource> page = new Page<>(pageNum, pageSize);
        QueryWrapper<UmsResource> wrapper = new QueryWrapper<>();
        if (categoryId != null) {
            wrapper.eq("category_id", categoryId);
        }
        if (StrUtil.isNotEmpty(nameKeyword)) {
            wrapper.like("name", nameKeyword);
        }
        if (StrUtil.isNotEmpty(urlKeyword)) {
            wrapper.like("url", urlKeyword);
        }
        return resourceMapper.selectPage(page, wrapper);
    }

    @Override
    public List<UmsResource> listAll() {
        return resourceMapper.selectList(new QueryWrapper<>());
    }

    @Override
    public Map<String, String> initResourceRolesMap() {
        Map<String, String> resourceRoleMap = new TreeMap<>();
        List<UmsResource> resourceList = resourceMapper.selectList(new QueryWrapper<>());
        List<UmsRole> roleList = roleMapper.selectList(new QueryWrapper<>());
        List<UmsRoleResourceRelation> relationList = roleResourceRelationMapper.selectList(new QueryWrapper<>());
        for (UmsResource resource : resourceList) {
            Set<Long> roleIds = relationList.stream().filter(item -> item.getResourceId().equals(resource.getId())).map(UmsRoleResourceRelation::getRoleId).collect(Collectors.toSet());
            List<String> roleNames = roleList.stream().filter(item -> roleIds.contains(item.getId())).map(item -> item.getId() + "").collect(Collectors.toList());

            String json = GsonUtil.getJson(roleNames);
            resourceRoleMap.put( resource.getUrl(), json);
        }
        redisService.deleteObject(AuthConstant.RESOURCE_ROLES_MAP_KEY);
        redisService.setCacheMap(AuthConstant.RESOURCE_ROLES_MAP_KEY, resourceRoleMap);
        return resourceRoleMap;
    }
}
