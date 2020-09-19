package com.ms.auth.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ms.auth.domain.TbUser;
import com.ms.auth.mapper.UserMapper;
import com.ms.auth.service.UserService;
import com.ms.common.core.domain.LoginUserVo;
import com.ms.common.core.domain.R;
import com.ms.common.core.domain.ResultCode;
import com.ms.common.core.enums.UserType;
import com.ms.common.core.exception.BaseException;
import com.ms.common.redis.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * UserServiceImpl -- 用户业务 （登录/基本信息等）
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/9/17
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/9/17             XiaoBing          v1.0.0           Created
 */
@Service
public class UserServiceImpl implements UserService {
   @Autowired
   private RedisService redisService;
   @Autowired
   private UserMapper userMapper;

    /**
     * 获取用户基本信息
     * @param username  用户名
     * @param loginType 用户类型
     * @return 用户基本信息
     */
    @Override
    public R<LoginUserVo> getUserInfo(String username, String loginType) {

        //查询用户信息
        TbUser user = userMapper.selectOne(new QueryWrapper<TbUser>().eq("phone", username));
        if (user==null){
           return R.setToCode(ResultCode.REGISTRY_NOTHAS);
        }

        LoginUserVo  loginUserVo = new LoginUserVo();
        loginUserVo.setId(user.getId());
        loginUserVo.setName(user.getNikeName());
        loginUserVo.setLoginType(UserType.USER.getCode());
        String code = redisService.getCacheObject(username + "code");
        loginUserVo.setPassword(code);
        return R.ok(loginUserVo);
    }
}
