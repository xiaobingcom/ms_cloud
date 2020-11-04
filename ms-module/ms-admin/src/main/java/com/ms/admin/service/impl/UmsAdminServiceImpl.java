package com.ms.admin.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.BCrypt;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ms.admin.mapper.UmsAdminLoginLogMapper;
import com.ms.admin.mapper.UmsAdminMapper;
import com.ms.admin.mapper.UmsAdminRoleRelationMapper;
import com.ms.admin.pojo.dto.UmsAdminParam;
import com.ms.admin.pojo.po.*;
import com.ms.admin.service.UmsAdminRoleRelationService;
import com.ms.admin.service.UmsAdminService;
import com.ms.common.core.domain.R;
import com.ms.common.core.domain.UserDto;
import com.ms.common.core.enums.UserType;
import com.ms.common.core.utils.GsonUtil;
import com.ms.common.core.utils.StringUtils;
import com.ms.common.domain.AdminRedisUserVo;
import com.ms.common.utils.JWTUtil;
import com.ms.common.utils.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * UmsAdminService实现类
 * Created by macro on 2018/4/26.
 */
@Service
public class UmsAdminServiceImpl extends ServiceImpl<UmsAdminMapper, UmsAdmin> implements UmsAdminService {
    @Autowired
    private UmsAdminMapper adminMapper;
    @Autowired
    private UmsAdminRoleRelationMapper adminRoleRelationMapper;
    @Autowired
    private UmsAdminLoginLogMapper loginLogMapper;

    @Autowired
    private UmsAdminRoleRelationService adminRoleRelationService;
    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    /**
     * 根据用户名获取后台管理员
     * @param username 用户名
     * @return 后台管理员
     */
    @Override
    public UmsAdmin getAdminByUsername(String username) {

        List<UmsAdmin> adminList = adminMapper.selectList(new QueryWrapper<UmsAdmin>().eq("username", username));
        if (adminList != null && adminList.size() > 0) {
            return adminList.get(0);
        }
        return null;
    }

    /**
     * 注册
     * @param umsAdminParam 新增用户需要的参数
     * @return 后台用户
     */
    @Override
    public UmsAdmin register(UmsAdminParam umsAdminParam) {
        UmsAdmin umsAdmin = new UmsAdmin();
        BeanUtils.copyProperties(umsAdminParam, umsAdmin);
        umsAdmin.setCreateTime(new Date());
        umsAdmin.setStatus(1);
        //查询是否有相同用户名的用户
        List<UmsAdmin> adminList = adminMapper.selectList(new QueryWrapper<UmsAdmin>().eq("username", umsAdminParam.getUsername()));

        if (adminList.size() > 0) {
            return null;
        }
        //将密码进行加密操作
        String encodePassword = BCrypt.hashpw(umsAdmin.getPassword());
        umsAdmin.setPassword(encodePassword);
        adminMapper.insert(umsAdmin);
        return umsAdmin;
    }

    /**
     * 后台用户登录
     * @param username 用户名
     * @param password 密码
     * @return token
     */
    @Override
    public R login(String username, String password) {
        if (StrUtil.isEmpty(username) || StrUtil.isEmpty(password)) {
            return R.failed("用户名或密码不能为空！");
        }
        UmsAdmin admin = this.getAdminByUsername(username);
        if (admin!=null&&SecurityUtils.matchesPassword(password, admin.getPassword())) {
            AdminRedisUserVo adminRedisUserVo = new AdminRedisUserVo();

            adminRedisUserVo.setId(admin.getId());
            List<UmsRole> umsRoles = adminRoleRelationMapper.selectRoleList(admin.getId());
            List<Long> roleIds = new ArrayList<>();
            for (UmsRole umsRole : umsRoles) {
                roleIds.add(umsRole.getId());
            }
            adminRedisUserVo.setRole(roleIds);
            adminRedisUserVo.setUsername(admin.getNickName());

            redisTemplate.opsForValue().set("mall:ums:admin:"+admin.getId()+ admin.getNickName()+admin.getUsername()+ UserType.ADMIN.getCode(), GsonUtil.getJson(adminRedisUserVo));
            // 登录token
            String token = JWTUtil.getInstance().generateToken(admin.getId() + "", admin.getNickName(), admin.getUsername(), 604800, UserType.ADMIN.getCode(), null);
            Map<String, String> tokenMap = new HashMap<>();
            tokenMap.put("token", token);
            insertLoginLog(admin);
            return R.success(tokenMap);
        } else {
            return R.failed("用户名或密码错误");
        }
    }

    /**
     * 添加登录记录
     *
     * @param admin 用户
     */
    private void insertLoginLog(UmsAdmin admin) {
        if (admin == null) {
            return;
        }
        UmsAdminLoginLog loginLog = new UmsAdminLoginLog();
        loginLog.setAdminId(admin.getId());
        loginLog.setCreateTime(new Date());
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        loginLog.setIp(request.getRemoteAddr());
        loginLogMapper.insert(loginLog);
    }

    /**
     * 根据用户名修改登录时间
     */
    private void updateLoginTimeByUsername(String username) {
        UmsAdmin record = new UmsAdmin();
        record.setLoginTime(new Date());
        adminMapper.update(record, new QueryWrapper<UmsAdmin>().eq("username", username));
    }

    @Override
    public UmsAdmin getItem(Long id) {
        return adminMapper.selectById(id);
    }

    @Override
    public IPage<UmsAdmin> list(String keyword, Integer pageSize, Integer pageNum) {
        IPage<UmsAdmin> page = new Page<>(pageNum, pageSize);
        QueryWrapper<UmsAdmin> wrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty(keyword)){
            wrapper.like("username", keyword);
            wrapper.like("nick_name", keyword);
        }
        return adminMapper.selectPage(page, wrapper);

    }

    @Override
    public int update(Long id, UmsAdmin admin) {
        admin.setId(id);
        UmsAdmin rawAdmin = adminMapper.selectById(id);
        if (rawAdmin.getPassword().equals(admin.getPassword())) {
            //与原加密密码相同的不需要修改
            admin.setPassword(null);
        } else {
            //与原加密密码不同的需要加密修改
            if (StrUtil.isEmpty(admin.getPassword())) {
                admin.setPassword(null);
            } else {
                admin.setPassword(BCrypt.hashpw(admin.getPassword()));
            }
        }
        int count = adminMapper.updateById(admin);
        redisTemplate.delete("mall:ums:member:"+rawAdmin.getId()+ rawAdmin.getNickName()+rawAdmin.getUsername()+ UserType.ADMIN.getCode());
        return count;
    }

    @Override
    public int delete(Long id) {
        UmsAdmin rawAdmin = adminMapper.selectById(id);
        int count = adminMapper.deleteById(id);
        redisTemplate.delete("mall:ums:member:"+rawAdmin.getId()+ rawAdmin.getNickName()+rawAdmin.getUsername()+ UserType.ADMIN.getCode());

        return count;
    }

    @Override
    public int updateRole(Long adminId, List<Long> roleIds) {
        int count = roleIds == null ? 0 : roleIds.size();
        //先删除原来的关系
        adminRoleRelationMapper.delete(new QueryWrapper<UmsAdminRoleRelation>().eq("admin_id", adminId));
        //建立新关系
        if (!CollectionUtils.isEmpty(roleIds)) {
            List<UmsAdminRoleRelation> list = new ArrayList<>();
            for (Long roleId : roleIds) {
                UmsAdminRoleRelation roleRelation = new UmsAdminRoleRelation();
                roleRelation.setAdminId(adminId);
                roleRelation.setRoleId(roleId);
                list.add(roleRelation);
            }
            adminRoleRelationService.saveBatch(list);
        }
        return count;
    }

    @Override
    public List<UmsRole> getRoleList(Long adminId) {
        return adminRoleRelationService.getRoleList(adminId);
    }

    @Override
    public List<UmsResource> getResourceList(Long adminId) {
        return adminRoleRelationService.getResourceList(adminId);
    }


    @Override
    public int updatePassword(UpdateAdminPasswordParam param) {
        if (StrUtil.isEmpty(param.getUsername())
                || StrUtil.isEmpty(param.getOldPassword())
                || StrUtil.isEmpty(param.getNewPassword())) {
            return -1;
        }
        List<UmsAdmin> adminList = adminMapper.selectList(new QueryWrapper<UmsAdmin>().eq("username", param.getUsername()));
        if (CollUtil.isEmpty(adminList)) {
            return -2;
        }
        UmsAdmin umsAdmin = adminList.get(0);
        if (!BCrypt.checkpw(param.getOldPassword(), umsAdmin.getPassword())) {
            return -3;
        }
        umsAdmin.setPassword(BCrypt.hashpw(param.getNewPassword()));
        adminMapper.updateById(umsAdmin);
        redisTemplate.delete("mall:ums:member:"+umsAdmin.getId()+ umsAdmin.getNickName()+umsAdmin.getUsername()+ UserType.ADMIN.getCode());

        return 1;
    }

    @Override
    public UserDto loadUserByUsername(String username) {
        //获取用户信息
        UmsAdmin admin = getAdminByUsername(username);
        if (admin != null) {
            List<UmsRole> roleList = getRoleList(admin.getId());
            UserDto userDTO = new UserDto();
            BeanUtils.copyProperties(admin, userDTO);
            if (CollUtil.isNotEmpty(roleList)) {
                List<String> roleStrList = roleList.stream().map(item -> item.getId() + "_" + item.getName()).collect(Collectors.toList());
                userDTO.setRoles(roleStrList);
            }
            return userDTO;
        }
        return null;
    }

}
