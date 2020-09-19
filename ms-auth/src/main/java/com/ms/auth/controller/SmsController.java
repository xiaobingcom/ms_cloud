package com.ms.auth.controller;

import com.ms.auth.service.SmsService;
import com.ms.common.core.domain.R;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * SmsController -- 短信发送类
 *
 * @author XiaoBing
 * @version v1.0.0
 * @date 2020/9/17
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/9/17             XiaoBing          v1.0.0           Created
 */
@RestController
@RequestMapping("/sms")
public class SmsController {

    @Autowired
    private SmsService smsService;

    /**
     * 发送验证码
     */
    @ApiOperation(value = "获取登录验证码", notes = "获取登录验证码")
    @GetMapping("/send/code/{phone}")
    @ResponseBody
    public R registryCode(@PathVariable("phone") String phone) {
        //手机号格式验证
        String regex = "^((13[0-9])|(14[5,7,9])|(15([0-3]|[5-9]))|(17[0,1,3,5,6,7,8])|(18[0-9])|(19[8|9])|(16[6]))\\d{8}$";
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(phone);
        boolean isMatch = m.matches();
        if (!isMatch) {
            return R.fail(400, "手机号格式不正确");
        }
        return smsService.sendLoginCode(phone);
    }
}
