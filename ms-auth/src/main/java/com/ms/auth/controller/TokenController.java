package com.ms.auth.controller;


import com.ms.auth.form.LoginBody;
import com.ms.auth.service.SysLoginService;
import com.ms.auth.service.TokenService;
import com.ms.common.core.domain.LoginUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ms.common.core.domain.R;
import com.ms.common.core.utils.StringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * token 控制
 *
 * @author xiaobing
 */
@RestController
public class TokenController {
    @Autowired
    private TokenService tokenService;

    @Autowired
    private SysLoginService sysLoginService;

    /**
     * 登录
     * @param form 登录类
     * @return token
     */
    @PostMapping("login")
    public R<?> login(@RequestBody LoginBody form) {
        // 用户登录
        LoginUserVo userInfo = sysLoginService.login(form.getUsername(), form.getPassword(), form.getUserType());
        // 获取登录token
        return R.ok(tokenService.createToken(userInfo));
    }

    /**
     * 退出登录
     * @param request 请求
     * @return 退出登录是否成功
     */
    @DeleteMapping("logout")
    public R<?> logout(HttpServletRequest request) {
        LoginUserVo loginUser = tokenService.getLoginUser(request);
        if (StringUtils.isNotNull(loginUser)) {
            String username = loginUser.getName();
            // 删除用户缓存记录
            tokenService.delLoginUser(loginUser.getToken());
            // 记录用户退出日志
            sysLoginService.logout(username);
        }
        return R.ok();
    }

    /**
     * 刷新token
     * @param request 请求
     * @return token
     */
    @PostMapping("refresh")
    public R<?> refresh(HttpServletRequest request) {
        LoginUserVo loginUser = tokenService.getLoginUser(request);
        if (StringUtils.isNotNull(loginUser)) {
            // 刷新令牌有效期
            return R.ok(tokenService.refreshToken(loginUser));
        }
        return R.ok();
    }
}
