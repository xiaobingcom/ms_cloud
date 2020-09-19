package com.ms.common.config;

import com.ms.common.utils.SecurityUtils;
import com.ms.common.core.constant.CacheConstants;
import com.ms.common.core.constant.Constants;
import com.ms.common.core.enums.UserType;
import feign.Logger;
import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.context.annotation.Bean;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * FEIGN请求配置
 *
 * @author xiaobing
 */
public class FeignConfig implements RequestInterceptor {

    @Override
    public void apply(RequestTemplate requestTemplate) {
        if (SecurityUtils.getUserId() != null) {
            // 添加token
            requestTemplate.header(CacheConstants.DETAILS_USER_ID, SecurityUtils.getUserId() + "");

            try {
                //用户名转码
                String source = URLEncoder.encode(SecurityUtils.getUsername(), Constants.UTF8);
                requestTemplate.header(CacheConstants.DETAILS_USERNAME, source);

            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            requestTemplate.header(CacheConstants.TOKEN_TYPE, UserType.FEIGN.getCode());
        }
    }

    @Bean
    Logger.Level feignLevel() {
        return Logger.Level.FULL;
    }
}
