package com.ms.auth.service;

import com.ms.common.core.domain.LoginUserVo;
import com.ms.common.core.domain.R;

/**
 * UserService -- 用户业务
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/9/17
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/9/17             XiaoBing          v1.0.0           Created
 */
public interface UserService {
    /**
     * 获取用户基本信息
     * @param username 用户名
     * @param loginType 用户类型
     * @return 用户基本信息
     */
    R<LoginUserVo> getUserInfo(String username, String loginType);
}
