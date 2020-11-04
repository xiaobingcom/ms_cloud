package com.ms.admin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ms.admin.pojo.po.UmsResource;
import com.ms.admin.service.UmsResourceService;
import com.ms.common.core.annotation.TokenTypeAnnotation;
import com.ms.common.core.domain.R;
import com.ms.common.core.enums.UserType;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 后台资源管理Controller
 * Created by macro on 2020/2/4.
 */
@Controller
@Api(tags = "UmsResourceController", description = "后台资源管理")
@RequestMapping("/resource")
@TokenTypeAnnotation(tokenTypeCan = UserType.ADMIN)
public class UmsResourceController {

    @Autowired
    private UmsResourceService resourceService;

    @ApiOperation("添加后台资源")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public R create(@RequestBody UmsResource umsResource) {
        int count = resourceService.create(umsResource);
        if (count > 0) {
            return R.success(count);
        } else {
            return R.failed();
        }
    }

    @ApiOperation("修改后台资源")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R update(@PathVariable Long id,
                               @RequestBody UmsResource umsResource) {
        int count = resourceService.update(id, umsResource);
        if (count > 0) {
            return R.success(count);
        } else {
            return R.failed();
        }
    }

    @ApiOperation("根据ID获取资源详情")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public R<UmsResource> getItem(@PathVariable Long id) {
        UmsResource umsResource = resourceService.getItem(id);
        return R.success(umsResource);
    }

    @ApiOperation("根据ID删除后台资源")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R delete(@PathVariable Long id) {
        int count = resourceService.delete(id);
        if (count > 0) {
            return R.success(count);
        } else {
            return R.failed();
        }
    }

    @ApiOperation("分页模糊查询后台资源")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public R<IPage<UmsResource>> list(@RequestParam(required = false) Long categoryId,
                                      @RequestParam(required = false) String nameKeyword,
                                      @RequestParam(required = false) String urlKeyword,
                                      @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                      @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        IPage<UmsResource> list = resourceService.list(categoryId, nameKeyword, urlKeyword, pageSize, pageNum);
        return R.success(list);
    }

    @ApiOperation("查询所有后台资源")
    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    @ResponseBody
    public R<List<UmsResource>> listAll() {
        List<UmsResource> resourceList = resourceService.listAll();
        return R.success(resourceList);
    }

    @ApiOperation("初始化资源角色关联数据")
    @RequestMapping(value = "/initResourceRolesMap", method = RequestMethod.GET)
    @ResponseBody
    public R initResourceRolesMap() {
        Map<String,String> resourceRolesMap = resourceService.initResourceRolesMap();
        return R.success(resourceRolesMap);
    }
}
