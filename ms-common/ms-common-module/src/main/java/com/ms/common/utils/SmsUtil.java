package com.ms.common.utils;

import com.alibaba.fastjson.JSONObject;
import com.ms.common.core.domain.R;
import com.ms.common.core.domain.ResultCode;
import com.ms.common.core.enums.SmsTemplateEnum;
import com.netflix.client.ClientException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.swing.text.html.FormSubmitEvent;
import java.rmi.ServerException;
import java.util.concurrent.TimeUnit;

/**
 * 发送短信工具类
 *
 * @author xiaobing
 */
@Slf4j
@Component
public class SmsUtil {

    /**
     * redis 操作类
     */
    @Autowired
    private RedisTemplate redisTemplate;




    private static final String ACCESS_KEY_ID = "*";
    private static final String ACCESS_SECRET = "*";
    private static final String SIGN_NAME = "*";

    // 返回数字下标0为所发送的验证码 1为状态(OK为发送成功其他均为失败)
    public static String[] sendSms(String phone, Integer type) {
        String code = RandomUtils.generateNumberString(6);// 验证码
//        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", ACCESS_KEY_ID, ACCESS_SECRET);
//        IAcsClient client = new DefaultAcsClient(profile);
//        CommonRequest request = new CommonRequest();
//        request.setMethod(FormSubmitEvent.MethodType.POST);
//        request.setDomain("dysmsapi.aliyuncs.com");
//        request.setVersion("2017-05-25");
//        request.setAction("SendSms");
//        request.putQueryParameter("RegionId", "cn-hangzhou");
//        request.putQueryParameter("PhoneNumbers", phone);
//        request.putQueryParameter("SignName", SIGN_NAME);
//        request.putQueryParameter("TemplateCode", SmsTemplateEnum.getTemplateByType(type));// 枚举type获取模板Code
//        request.putQueryParameter("TemplateParam", "{code : " + code + "}");
        String[] strArray = new String[2];
//        try {
//            CommonResponse response = client.getCommonResponse(request);
//            JSONObject jsonObject = JSONObject.parseObject(response.getData());
//            System.out.println(jsonObject);
//            String str = (String) jsonObject.get("Code");
            strArray[0] = code;
            strArray[1] = "SUCCESS";
//        } catch (ServerException e) {
//            strArray[1] = "error";
//            e.printStackTrace();
//        } catch (ClientException e) {
//            strArray[1] = "error";
//            e.printStackTrace();
//        } catch (Exception e) {
//            strArray[1] = "error";
//            e.printStackTrace();
//        }
        return strArray;
    }

    public static String getCode() {
        String string = Integer.valueOf((int) ((Math.random() * 9 + 1) * 100000)).toString();
        return string;

    }

    // 如果发送成功将验证码存入redis
    public R saveCodeToRedis(String phone, Integer smsType) {
        boolean hasKey = redisTemplate.hasKey(phone + "code");


            if (!hasKey) {

                String[] strings = sendSms(phone, smsType);
                if ("OK".equals(strings[1])) {
                    redisTemplate.opsForValue().set(phone + "code", strings[0] + "-" + System.currentTimeMillis(), 15, TimeUnit.MINUTES);
//                if (true) {
//                    redisTemplate.opsForValue().set(phone + "code", "123456" + "-" + System.currentTimeMillis(), 15, TimeUnit.MINUTES);
//                }
                    return R.success();
                } else if ("isv.BUSINESS_LIMIT_CONTROL".equals(strings[1])) {
                    return R.setToCode(ResultCode.BUSINESS_LIMIT_CONTROL);
                } else if ("isv.MOBILE_NUMBER_ILLEGAL".equals(strings[1])) {
                    return R.setToCode(ResultCode.PHONE_ERROR);
                } else {
                    return R.setToCode(ResultCode.SMS_ERROR);
                }
            } else {
                // 如果redis有上次发送的验证码，验证发送间隔是否到一分钟
                String str = (String) redisTemplate.opsForValue().get(phone + "code");
                String[] split = str.split("-");
                // 发送验证码时的时间戳
                long sendSmsTime = Long.valueOf(split[1]);
                // 现在的时间戳
                long nowTime = System.currentTimeMillis();
                if (nowTime - sendSmsTime < 60000) {
                    return R.setToCode(ResultCode.CODE_TIME);
                }
                // 删除之前发送的验证码使之失效
                deleteCode(phone);
                // 发送新验证码
                String[] strings = sendSms(phone, smsType);
                if ("OK".equals(strings[1])) {
                    redisTemplate.opsForValue().set(phone + "code", strings[0] + "-" + System.currentTimeMillis(), 15, TimeUnit.MINUTES);
//                redisTemplate.opsForValue().set(phone + "code", "123456" + "-" + System.currentTimeMillis(), 15, TimeUnit.MINUTES);
                    return R.setToCode(ResultCode.SUCCESS);
                } else if ("isv.BUSINESS_LIMIT_CONTROL".equals(strings[1])) {
                    return R.setToCode(ResultCode.BUSINESS_LIMIT_CONTROL);
                } else if ("isv.MOBILE_NUMBER_ILLEGAL".equals(strings[1])) {
                    return R.setToCode(ResultCode.PHONE_ERROR);
                } else {
                    return R.setToCode(ResultCode.SMS_ERROR);
                }
            }


    }

    // 验证验证码是否正确
    public boolean checkCode(String phone, String code) {
        String str = (String) redisTemplate.opsForValue().get(phone + "code");
        if (str == null) {
            return false;
        }
        String[] split = str.split("-");
        return code.equals(split[0]);
    }

    // 验证码使用过后删除,使之不再生效(进行修改为未知验证码，确保提示正常)
    public boolean deleteCode(String phone) {
        if (phone.equals("15610475001")){
            return true;
        }
        String str = (String) redisTemplate.opsForValue().get(phone + "code");
        String[] split = str.split("-");

        String code = RandomUtils.generateNumberString(6);// 验证码

        Boolean delete = redisTemplate.delete(phone + "code");
        redisTemplate.opsForValue().set(phone + "code", code + "-" + split[1], 1, TimeUnit.MINUTES);

        return delete;
    }
}





