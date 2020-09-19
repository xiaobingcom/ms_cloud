package com.ms.auth;

import com.ms.common.swagger.annotation.EnableCustomSwagger2;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

/**
 * 认证授权中心
 *
 * @author xiaobing
 */
@SpringCloudApplication
@EnableCustomSwagger2
@ComponentScan(basePackages = {"com.ms"})
@EnableFeignClients("com.ms.auth.feign")
@MapperScan(basePackages = { "com.ms.auth.mapper" ,"com.baomidou.mybatisplus.samples.quickstart.mapper"}, sqlSessionFactoryRef = "sqlSessionFactory")
public class MsAuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(MsAuthApplication.class, args);
    }
}
