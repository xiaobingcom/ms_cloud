package com.ms.member;

import com.ms.common.swagger.annotation.EnableCustomSwagger2;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.context.annotation.ComponentScan;

/**
 * 考级系统-通知模块
 *
 * @author xiaobing
 */
@EnableCustomSwagger2
@SpringCloudApplication
@ComponentScan(basePackages = {"com.ms"})
@MapperScan(basePackages = { "com.ms.member.mapper" ,"com.baomidou.mybatisplus.samples.quickstart.mapper"}, sqlSessionFactoryRef = "sqlSessionFactory")
public class MsMemberApplication {
    public static void main(String[] args) {
        SpringApplication.run(MsMemberApplication.class, args);
    }
}
