package com.ms.auth.service;

import com.ms.common.core.domain.R;

/**
 * SmsService -- 短信发送业务
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/9/17
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/9/17             XiaoBing          v1.0.0           Created
 */
public interface SmsService {

    /**
     * 发送登录验证码
     * @param phone 手机号
     * @return 发送是否成功
     */
    R sendLoginCode(String phone);

}
