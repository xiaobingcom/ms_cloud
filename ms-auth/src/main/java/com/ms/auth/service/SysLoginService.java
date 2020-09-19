package com.ms.auth.service;

import com.ms.common.utils.SecurityUtils;
import com.ms.auth.feign.RemoteLogService;
import com.ms.common.core.domain.LoginUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ms.common.core.constant.Constants;
import com.ms.common.core.constant.UserConstants;
import com.ms.common.core.domain.R;
import com.ms.common.core.exception.BaseException;
import com.ms.common.core.utils.StringUtils;

/**
 * 登录校验方法
 *
 * @author xiaobing
 */
@Component
public class SysLoginService {
    @Autowired
    private RemoteLogService remoteLogService;

    @Autowired
    private UserService userService;

    /**
     * 登录
     */
    public LoginUserVo login(String username, String password, String loginType) {
        // 用户名或密码为空 错误
        if (StringUtils.isAnyBlank(username, password)) {
            remoteLogService.saveLogininfor(username, Constants.LOGIN_FAIL, "用户/密码必须填写");
            throw new BaseException("用户/密码必须填写");
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH) {
            remoteLogService.saveLogininfor(username, Constants.LOGIN_FAIL, "用户密码不在指定范围");
            throw new BaseException("用户密码不在指定范围");
        }
        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH) {
            remoteLogService.saveLogininfor(username, Constants.LOGIN_FAIL, "用户名不在指定范围");
            throw new BaseException("用户名不在指定范围");
        }
        // 查询用户信息
        R<LoginUserVo> userInfo = userService.getUserInfo(username, loginType);
        if (StringUtils.isNull(userInfo) || StringUtils.isNull(userInfo.getData())) {
            remoteLogService.saveLogininfor(username, Constants.LOGIN_FAIL, "登录用户不存在");
            throw new BaseException("登录用户：" + username + " 不存在", "登录用户：" + username + " 不存在");
        }
        if (!SecurityUtils.matchesPassword(password, userInfo.getData().getPassword())) {
            throw new BaseException("验证码不正确", "验证码不正确");

        }
        remoteLogService.saveLogininfor(username, Constants.LOGIN_SUCCESS, "登录成功");
        return userInfo.getData();
    }

    /**
     * 退出登录
     *
     * @param loginName 用户名
     */
    public void logout(String loginName) {
        remoteLogService.saveLogininfor(loginName, Constants.LOGOUT, "退出成功");
    }
}