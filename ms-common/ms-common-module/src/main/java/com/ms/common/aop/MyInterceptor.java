package com.ms.common.aop;

import com.ms.common.config.IgnoreUrlsConfig;
import com.ms.common.core.constant.AuthConstant;
import com.ms.common.core.domain.UserDto;
import com.ms.common.domain.AdminRedisUserVo;
import com.ms.common.utils.CommonRequestHolder;
import com.ms.common.utils.JWTUtil;
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
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;
import org.springframework.util.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.lang.annotation.Annotation;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * 拦截器
 *
 * @author 小兵
 */
@Service
public class MyInterceptor implements HandlerInterceptor {


    private final RedisTemplate<String, String> redisCacheTemplate;
    private final RedisTemplate<String, Object> objRedisTemplate;
    private final  IgnoreUrlsConfig ignoreUrlsConfig;

    public MyInterceptor(RedisTemplate<String, String> redisCacheTemplate, RedisTemplate<String, Object> objRedisTemplate,IgnoreUrlsConfig ignoreUrlsConfig) {
        this.redisCacheTemplate = redisCacheTemplate;
        this.objRedisTemplate = objRedisTemplate;
        this.ignoreUrlsConfig = ignoreUrlsConfig;
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
        //白名单路径直接放行
        PathMatcher pathMatcher = new AntPathMatcher();
        /*
        swagger不需要进行拦截
         */
        String uri = request.getRequestURI();

        List<String> ignoreUrls = ignoreUrlsConfig.getUrls();
        for (String ignoreUrl : ignoreUrls) {
            if (pathMatcher.match(ignoreUrl, uri)) {
                return true;
            }
        }

        //如果请求为 OPTIONS 请求，则不需要任何校验
        String requestMethod = request.getMethod();
        if ((!StringUtils.isEmpty(requestMethod)) && requestMethod.equals(Constants.OPTIONS)) {
            response.setStatus(HttpServletResponse.SC_OK);
            return true;
        }

        //登录的客户端
        String headerType = request.getHeader(CacheConstants.TOKEN_TYPE);

        //如果获取不到。则认定为非法调用
        if (headerType == null || "".equals(headerType)) {
            return responseWrite(response, ResultCode.NO_AUTH_CODE);
        }

        String header = request.getHeader("Authorization");


        //获取登录类型
        UserType secret = UserType.getByCode(headerType);
        if (UserType.ADMIN.getCode().equals(headerType)) {
            adminCheckToken(response, header, uri);
        }
        if (UserType.USER.getCode().equals(headerType)) {
            userCheckToken(response, header);
        }
        //验证重复点击与接口权限等
        Boolean checkFlag = checkUri(response, handler, uri, secret);
        if (checkFlag) {
            return Boolean.TRUE;
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
            if (tokenTypeAnnotation != null) {
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
            if (tokenTypeAnnotation != null && redisCacheTemplate.hasKey(CommonRequestHolder.getCurrentUserId() + uri)) {
                return responseWrite(response, ResultCode.REPEAT_REQUEST);
            } else {
                //将接口+用户信息存储到缓存中。进行重复点击校验
                redisCacheTemplate.opsForValue().set(CommonRequestHolder.getCurrentUserId() + uri, "", 30, TimeUnit.SECONDS);
            }
        }
        //权限校验 start
        if (handler instanceof HandlerMethod) {
            //查看接口头部是否规定用户类型
            TokenTypeAnnotation tokenTypeAnnotation = findAnnotation((HandlerMethod) handler, TokenTypeAnnotation.class);
            //声明需要权限,并且与登录用户类型不符合，则返回权限不足
            if (tokenTypeAnnotation != null) {
                if ((!secret.getCode().equals(tokenTypeAnnotation.tokenTypeCan().getCode()))) {

                    return responseWrite(response, ResultCode.INSUFFICIENT_PERMISSIONS);
                }
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

    private void adminCheckToken(HttpServletResponse response, String header, String uri) throws Exception {

        JWTUtil.JWTResult jwtResult;

        //解析 TOKEN
        jwtResult = JWTUtil.getInstance().checkToken(header.replace("Bearer ", ""), UserType.ADMIN.getCode());
        if (jwtResult.isStatus()) {
            String userId = jwtResult.getUserId();
            String phone = jwtResult.getPhone();
            String userName = jwtResult.getUserName();

            String s = userId + phone + userName + UserType.ADMIN.getCode();
            System.out.println(s);
            String userStr = redisCacheTemplate.opsForValue().get("mall:ums:admin:" + userId + userName + phone + UserType.ADMIN.getCode());
            if (StringUtils.isEmpty(userStr)) {
                response.setContentType("application/json;charset=utf-8");
                PrintWriter out = response.getWriter();
                R rvl = R.setToCode(ResultCode.NO_AUTH_CODE);
                out.write(GsonUtil.getJson(rvl));
                out.flush();
                out.close();
            }

            //将用户信息 JSON 串转换为对象
            AdminRedisUserVo userVo = (AdminRedisUserVo) GsonUtil.getObject(userStr, AdminRedisUserVo.class);

            this.adminCheckUrl(response, uri, userVo.getRole());

            //初始化当前线程登陆用户状态
            CommonRequestHolder.init(userVo.getId(), userVo.getUsername());
        }
    }

    private void userCheckToken(HttpServletResponse response, String header) throws Exception {

        JWTUtil.JWTResult jwtResult;
        String replace = header.replace(AuthConstant.MALL_TOKEN_PREFIX, "");
        String userStr = redisCacheTemplate.opsForValue().get("mall:ums:member:" + replace);
        if (StringUtils.isEmpty(userStr)) {
            response.setContentType("application/json;charset=utf-8");
            PrintWriter out = response.getWriter();
            R rvl = R.setToCode(ResultCode.NO_AUTH_CODE);
            out.write(GsonUtil.getJson(rvl));
            out.flush();
            out.close();
        }
        UserDto userVo = (UserDto) GsonUtil.getObject(userStr, UserDto.class);
        //初始化当前线程登陆用户状态
        CommonRequestHolder.init(userVo.getId(), userVo.getUsername());
    }

    /**
     * 管理端验证权限
     */
    private void adminCheckUrl(HttpServletResponse response, String uri, List<Long> userRoleIdList) throws Exception {
        PathMatcher pathMatcher = new AntPathMatcher();

        //管理端路径需校验权限
        Map<Object, Object> resourceRolesMap = objRedisTemplate.opsForHash().entries(AuthConstant.RESOURCE_ROLES_MAP_KEY);
        for (Long userRoleId : userRoleIdList) {
            for (Object o : resourceRolesMap.keySet()) {
                String pattern = (String) o;
                if (pathMatcher.match(pattern, uri)) {
                    Object o1 = resourceRolesMap.get(o);
                    String roleIdStr = (String) o1;
                    List list = (List) GsonUtil.getObject(roleIdStr, List.class);
                    for (Object o2 : list) {
                        String roleId = (String) o2;
                        if (roleId.equals(userRoleId + "")) {
                            return;
                        }
                    }
                }
            }
        }
        System.out.println("权限不足");
        responseWrite(response, ResultCode.INSUFFICIENT_PERMISSIONS);

    }

}
