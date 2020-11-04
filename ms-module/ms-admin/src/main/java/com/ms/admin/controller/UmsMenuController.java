package com.ms.admin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ms.admin.pojo.po.UmsMenu;
import com.ms.admin.pojo.po.UmsMenuNode;
import com.ms.admin.service.UmsMenuService;
import com.ms.common.core.annotation.TokenTypeAnnotation;
import com.ms.common.core.domain.R;
import com.ms.common.core.enums.UserType;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 后台菜单管理Controller
 * Created by macro on 2020/2/4.
 */
@Controller
@Api(tags = "UmsMenuController", description = "后台菜单管理")
@RequestMapping("/menu")
@TokenTypeAnnotation(tokenTypeCan = UserType.ADMIN)
public class UmsMenuController {

    @Autowired
    private UmsMenuService menuService;

    @ApiOperation("添加后台菜单")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public R create(@RequestBody UmsMenu umsMenu) {
        int count = menuService.create(umsMenu);
        if (count > 0) {
            return R.success(count);
        } else {
            return R.failed();
        }
    }

    @ApiOperation("修改后台菜单")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R update(@PathVariable Long id,
                               @RequestBody UmsMenu umsMenu) {
        int count = menuService.update(id, umsMenu);
        if (count > 0) {
            return R.success(count);
        } else {
            return R.failed();
        }
    }

    @ApiOperation("根据ID获取菜单详情")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public R<UmsMenu> getItem(@PathVariable Long id) {
        UmsMenu umsMenu = menuService.getItem(id);
        return R.success(umsMenu);
    }

    @ApiOperation("根据ID删除后台菜单")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R delete(@PathVariable Long id) {
        int count = menuService.delete(id);
        if (count > 0) {
            return R.success(count);
        } else {
            return R.failed();
        }
    }

    @ApiOperation("分页查询后台菜单")
    @RequestMapping(value = "/list/{parentId}", method = RequestMethod.GET)
    @ResponseBody
    public R<IPage<UmsMenu>> list(@PathVariable Long parentId,
                                  @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                  @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        IPage<UmsMenu> list = menuService.list(parentId, pageSize, pageNum);
        return R.success(list);
    }

    @ApiOperation("树形结构返回所有菜单列表")
    @RequestMapping(value = "/treeList", method = RequestMethod.GET)
    @ResponseBody
    public R<List<UmsMenuNode>> treeList() {
        List<UmsMenuNode> list = menuService.treeList();
        return R.success(list);
    }

    @ApiOperation("修改菜单显示状态")
    @RequestMapping(value = "/updateHidden/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R updateHidden(@PathVariable Long id, @RequestParam("hidden") Integer hidden) {
        int count = menuService.updateHidden(id, hidden);
        if (count > 0) {
            return R.success(count);
        } else {
            return R.failed();
        }
    }
}
