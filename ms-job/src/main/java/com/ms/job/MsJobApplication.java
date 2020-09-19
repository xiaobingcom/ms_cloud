package com.ms.job;

import com.ms.common.swagger.annotation.EnableCustomSwagger2;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * 定时任务
 *
 * @author xiaobing
 */
@EnableCustomSwagger2
@EnableScheduling
@SpringCloudApplication
@MapperScan(basePackages = { "com.ms.job.mapper" ,"com.baomidou.mybatisplus.samples.quickstart.mapper"}, sqlSessionFactoryRef = "sqlSessionFactory")
@ComponentScan(basePackages = {"com.ms"})
public class MsJobApplication {
    public static void main(String[] args) {
        SpringApplication.run(MsJobApplication.class, args);

    }
}
