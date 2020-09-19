package com.ms.auth.service.impl;

import com.ms.auth.mapper.UserMapper;
import com.ms.auth.service.SmsService;
import com.ms.common.core.domain.R;
import com.ms.common.redis.RedisService;
import com.ms.common.utils.SecurityUtils;
import com.ms.common.utils.SmsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * SmsServiceImpl -- 短信发送业务
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
public class SmsServiceImpl  implements SmsService {


    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisService redisService;
    @Autowired
    private SmsUtil smsUtil;
    /**
     * 发送登录验证码
     * @param phone 手机号
     * @return 发送是否成功
     */
    @Override
    public R sendLoginCode(String phone) {

//        Integer userCount = userMapper.selectCount(new QueryWrapper<TbUser>().eq("phone", phone));

//
//        if (userCount > 0) {
//            return smsUtil.saveCodeToRedis(phone, SmsTemplateEnum.LOG_IN.getType());
//        } else {
//            return smsUtil.saveCodeToRedis(phone, SmsTemplateEnum.REGISTERED.getType());
//        }


        redisService.setCacheObject(phone + "code", SecurityUtils.encryptPassword("123456"), 15L, TimeUnit.MINUTES);
        return R.ok();

    }
}
