package com.ms.member.service;

import com.ms.common.core.domain.R;
import com.ms.common.core.domain.UserDto;
import com.ms.common.domain.UmsMember;

/**
 * 会员管理Service
 * Created by macro on 2018/8/3.
 */
public interface UmsMemberService {
    /**
     * 根据用户名获取会员
     */
    UmsMember getByUsername(String username);

    /**
     * 根据会员编号获取会员
     */
    UmsMember getById(Long id);



    /**
     * 获取用户信息
     */
    UserDto loadUserByUsername(String username);

    /**
     * 登录后获取token
     */
    R login(Long uid);
}
