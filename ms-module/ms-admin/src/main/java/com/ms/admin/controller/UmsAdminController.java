package com.ms.admin.controller;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.ms.admin.pojo.dto.UmsAdminLoginParam;
import com.ms.admin.pojo.dto.UmsAdminParam;
import com.ms.admin.pojo.po.UmsAdmin;
import com.ms.admin.pojo.po.UmsRole;
import com.ms.admin.pojo.po.UpdateAdminPasswordParam;
import com.ms.admin.service.UmsAdminService;
import com.ms.admin.service.UmsRoleService;
import com.ms.common.core.annotation.TokenTypeAnnotation;
import com.ms.common.core.domain.R;
import com.ms.common.core.domain.UserDto;
import com.ms.common.core.enums.UserType;
import com.ms.common.utils.CommonRequestHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 后台用户管理
 * Created by macro on 2018/4/26.
 */
@Controller
@Api(tags = "UmsAdminController", description = "后台用户管理")
@RequestMapping("/admin")
@TokenTypeAnnotation(tokenTypeCan = UserType.ADMIN)
public class UmsAdminController {
    @Autowired
    private UmsAdminService adminService;
    @Autowired
    private UmsRoleService roleService;

    @ApiOperation(value = "用户注册")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public R<UmsAdmin> register(@Validated @RequestBody UmsAdminParam umsAdminParam) {
        UmsAdmin umsAdmin = adminService.register(umsAdminParam);
        if (umsAdmin == null) {
            return R.failed();
        }
        return R.success(umsAdmin);
    }

    @ApiOperation(value = "登录以后返回token")
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public R login(@Validated @RequestBody UmsAdminLoginParam umsAdminLoginParam) {
        return adminService.login(umsAdminLoginParam.getUsername(), umsAdminLoginParam.getPassword());
    }

    @ApiOperation(value = "获取当前登录用户信息")
    @RequestMapping(value = "/info", method = RequestMethod.GET)
    @ResponseBody
    public R getAdminInfo() {
        UmsAdmin item = adminService.getItem(CommonRequestHolder.getCurrentUserId());
        Map<String, Object> data = new HashMap<>();
        data.put("username", CommonRequestHolder.getCurrentUserId());
        data.put("menus", roleService.getMenuList(CommonRequestHolder.getCurrentUserId()));
        data.put("icon", item.getIcon());
        List<UmsRole> roleList = adminService.getRoleList(item.getId());
        if (CollUtil.isNotEmpty(roleList)) {
            List<String> roles = roleList.stream().map(UmsRole::getName).collect(Collectors.toList());
            data.put("roles", roles);
        }
        return R.success(data);
    }

    @ApiOperation(value = "登出功能")
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    @ResponseBody
    public R logout() {
        return R.success(null);
    }

    @ApiOperation("根据用户名或姓名分页获取用户列表")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public R<IPage<UmsAdmin>> list(@RequestParam(value = "keyword", required = false) String keyword,
                                   @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                   @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        IPage<UmsAdmin> list = adminService.list(keyword, pageSize, pageNum);
        return R.success(list);
    }

    @ApiOperation("获取指定用户信息")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public R<UmsAdmin> getItem(@PathVariable Long id) {
        UmsAdmin admin = adminService.getItem(id);
        return R.success(admin);
    }

    @ApiOperation("修改指定用户信息")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R update(@PathVariable Long id, @RequestBody UmsAdmin admin) {
        int count = adminService.update(id, admin);
        if (count > 0) {
            return R.success(count);
        }
        return R.failed();
    }

    @ApiOperation("修改指定用户密码")
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public R updatePassword(@RequestBody UpdateAdminPasswordParam updatePasswordParam) {
        int status = adminService.updatePassword(updatePasswordParam);
        if (status > 0) {
            return R.success(status);
        } else if (status == -1) {
            return R.failed("提交参数不合法");
        } else if (status == -2) {
            return R.failed("找不到该用户");
        } else if (status == -3) {
            return R.failed("旧密码错误");
        } else {
            return R.failed();
        }
    }

    @ApiOperation("删除指定用户信息")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R delete(@PathVariable Long id) {
        int count = adminService.delete(id);
        if (count > 0) {
            return R.success(count);
        }
        return R.failed();
    }

    @ApiOperation("修改帐号状态")
    @RequestMapping(value = "/updateStatus/{id}", method = RequestMethod.POST)
    @ResponseBody
    public R updateStatus(@PathVariable Long id, @RequestParam(value = "status") Integer status) {
        UmsAdmin umsAdmin = new UmsAdmin();
        umsAdmin.setStatus(status);
        int count = adminService.update(id, umsAdmin);
        if (count > 0) {
            return R.success(count);
        }
        return R.failed();
    }

    @ApiOperation("给用户分配角色")
    @RequestMapping(value = "/role/update", method = RequestMethod.POST)
    @ResponseBody
    public R updateRole(@RequestParam("adminId") Long adminId,
                        @RequestParam("roleIds") List<Long> roleIds) {
        int count = adminService.updateRole(adminId, roleIds);
        if (count >= 0) {
            return R.success(count);
        }
        return R.failed();
    }

    @ApiOperation("获取指定用户的角色")
    @RequestMapping(value = "/role/{adminId}", method = RequestMethod.GET)
    @ResponseBody
    public R<List<UmsRole>> getRoleList(@PathVariable Long adminId) {
        List<UmsRole> roleList = adminService.getRoleList(adminId);
        return R.success(roleList);
    }

    @ApiOperation("根据用户名获取通用用户信息")
    @RequestMapping(value = "/loadByUsername", method = RequestMethod.GET)
    @ResponseBody
    public UserDto loadUserByUsername(@RequestParam String username) {
        UserDto userDTO = adminService.loadUserByUsername(username);
        return userDTO;
    }
}
