package com.ms.notice;

import com.ms.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 考级系统-通知模块
 *
 * @author xiaobing
 */
@EnableCustomSwagger2
@SpringCloudApplication
public class MsNoticeApplication {
    public static void main(String[] args) {
        SpringApplication.run(MsNoticeApplication.class, args);
    }
}
