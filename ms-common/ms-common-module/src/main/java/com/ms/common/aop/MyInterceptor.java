package com.ms.common.aop;

import com.ms.common.utils.SecurityUtils;
import com.ms.common.core.annotation.SameUrlData;
import com.ms.common.core.annotation.TokenTypeAnnotation;
import com.ms.common.core.constant.CacheConstants;
import com.ms.common.core.constant.Constants;
import com.ms.common.core.domain.R;
import com.ms.common.core.domain.ResultCode;
import com.ms.common.core.enums.UserType;
import com.ms.common.core.utils.GsonUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.lang.annotation.Annotation;
import java.util.concurrent.TimeUnit;

/**
 * 拦截器
 *
 * @author 小兵
 */
@Service
public class MyInterceptor implements HandlerInterceptor {


    private final RedisTemplate<String, String> redisCacheTemplate;

    public MyInterceptor(RedisTemplate<String, String> redisCacheTemplate) {
        this.redisCacheTemplate = redisCacheTemplate;
    }


    /**
     * 用于拦截 Request Header 中的用户基础信息
     *
     * @param request  请求数据
     * @param response 返回数据
     * @param handler  请求头
     * @return 是否通过
     * @throws Exception 异常
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        /*
        swagger不需要进行拦截
         */
        String uri = request.getRequestURI();
        //如果请求为 OPTIONS 请求，则不需要任何校验
        String requestMethod = request.getMethod();
        if ((!StringUtils.isEmpty(requestMethod)) && requestMethod.equals(Constants.OPTIONS)) {
            response.setStatus(HttpServletResponse.SC_OK);
            return true;
        }
        //登录 不需要验证权限
        if (uri.contains("login")) {
            return Boolean.TRUE;
        }
        //重置密码不需要验证权限
        if (uri.contains("/forget/password")) {
            return Boolean.TRUE;
        }
        //swagger 不需要验证权限
        if (uri.contains("swagger")) {
            return Boolean.TRUE;
        }
        //swagger 不需要验证权限
        if (uri.contains("api-docs")) {
            return Boolean.TRUE;
        }

        //发送验证码
        if (uri.contains("/send/code")) {
            return Boolean.TRUE;
        }
        //登录的客户端
        String headerType = request.getHeader(CacheConstants.TOKEN_TYPE);

        //如果获取不到。则认定为非法调用
        if (headerType == null || "".equals(headerType)) {
            return responseWrite(response, ResultCode.NO_AUTH_CODE);
        }
        //获取登录类型
        UserType secret = UserType.getByCode(headerType);
        //验证重复点击与接口权限等
        Boolean checkFlag = checkUri(response, handler, uri, secret);
        if (checkFlag) {
            return true;
        }
        return responseWrite(response, ResultCode.NO_AUTH_CODE);
    }

    /**
     * 获取接口上的注解
     *
     * @param handler        请求方法
     * @param annotationType 想要获取的注解
     * @param <T>            想要获取的注解类型
     * @return 注解
     */
    private <T extends Annotation> T findAnnotation(HandlerMethod handler, Class<T> annotationType) {
        T annotation = handler.getBeanType().getAnnotation(annotationType);
        if (annotation != null) {
            return annotation;
        }
        return handler.getMethodAnnotation(annotationType);
    }

    /**
     * 请求结束后进行的操作
     *
     * @param request  请求信息
     * @param response 返回信息
     * @param handler  请求头
     * @param ex       异常情况
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable
            Exception ex) {
        String uri = request.getRequestURI();
        if (handler instanceof HandlerMethod) {
            SameUrlData tokenTypeAnnotation = findAnnotation((HandlerMethod) handler, SameUrlData.class);
            //没有声明需要权限,或者声明不验证权限
            if (tokenTypeAnnotation == null) {
                return;
            } else {
                redisCacheTemplate.delete(SecurityUtils.getUserId() + uri);
            }
        }

    }

    /**
     * token验证
     *
     * @param response 返回
     * @param handler  请求头
     * @param secret   登录类型
     * @return R 的统一返回，并拦截
     * @throws Exception 异常情况，则为服务异常
     */
    private Boolean checkUri(HttpServletResponse response, Object handler, String uri, UserType secret) throws Exception {
        //判断连续请求的情况
        if (handler instanceof HandlerMethod) {
            SameUrlData tokenTypeAnnotation = findAnnotation((HandlerMethod) handler, SameUrlData.class);
            //判断石佛需要验证连续点击
            if (tokenTypeAnnotation != null && redisCacheTemplate.hasKey(SecurityUtils.getUserId() + uri)) {
                return responseWrite(response, ResultCode.REPEAT_REQUEST);
            } else {
                //将接口+用户信息存储到缓存中。进行重复点击校验
                redisCacheTemplate.opsForValue().set(SecurityUtils.getUserId() + uri, "", 30, TimeUnit.SECONDS);
            }
        }
        //权限校验 start
        if (handler instanceof HandlerMethod) {
            //查看接口头部是否规定用户类型
            TokenTypeAnnotation tokenTypeAnnotation = findAnnotation((HandlerMethod) handler, TokenTypeAnnotation.class);
            //声明需要权限,并且与登录用户类型不符合，则返回权限不足
            if (tokenTypeAnnotation != null && (!secret.getCode().equals(tokenTypeAnnotation.tokenTypeCan().getCode()))) {
                return responseWrite(response, ResultCode.INSUFFICIENT_PERMISSIONS);
            }
        }
        return true;
    }

    /**
     * 如若出现鉴权失败情况。则手动写response返回 通知客户端
     *
     * @param response 返回
     * @return R 的统一返回，并拦截
     * @throws Exception 异常情况，则为服务异常
     */
    private Boolean responseWrite(HttpServletResponse response, ResultCode resultCode) throws Exception {
        //定义返回类型为JSON
        response.setContentType(Constants.JSON_CONTENT_TYPE);
        //获取PrintWriter
        PrintWriter out = response.getWriter();
        //将异常类型写入
        out.write(GsonUtil.getJson(R.setToCode(resultCode)));
        //输出流
        out.flush();
        //关闭请求
        out.close();
        return false;
    }
}
