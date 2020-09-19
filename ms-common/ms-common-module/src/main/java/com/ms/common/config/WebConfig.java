package com.ms.common.config;

import com.ms.common.aop.MyInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 拦截器注册
 *
 * @author xiaobing
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    //    /**
//     * 配置允许跨域访问
//     * @param registry
//     */
//    @Override
//    public void addCorsMappings(CorsRegistry registry) {
//        registry.addMapping("/**")
//                .allowedOrigins("*")
//                .allowedHeaders("*")
//                .allowedMethods("*")
//                .maxAge(3600)
//                .allowCredentials(true);
//    }
    //注册拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //SpringMVC下，拦截器的注册需要排除对静态资源的拦截(*.css,*.js)
        //SpringBoot已经做好了静态资源的映射，因此我们无需任何操作
        registry.addInterceptor(new MyInterceptor(redisTemplate)).addPathPatterns("/**")
                .excludePathPatterns("/index.html", "/", "/user/login");
    }
}
