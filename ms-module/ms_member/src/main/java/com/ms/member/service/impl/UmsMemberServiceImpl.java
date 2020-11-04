package com.ms.member.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ms.common.core.constant.AuthConstant;
import com.ms.common.core.domain.R;
import com.ms.common.core.domain.UserDto;
import com.ms.common.core.enums.UserType;
import com.ms.common.core.utils.GsonUtil;
import com.ms.common.domain.UmsMember;
import com.ms.common.utils.JWTUtil;
import com.ms.member.mapper.UmsMemberMapper;
import com.ms.member.service.UmsMemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 会员管理Service实现类
 * Created by macro on 2018/8/3.
 */
@Service
public class UmsMemberServiceImpl implements UmsMemberService {
    @Autowired
    private UmsMemberMapper memberMapper;

    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    @Override
    public UmsMember getByUsername(String username) {
        List<UmsMember> memberList = memberMapper.selectList(new QueryWrapper<UmsMember>().eq("username",username));
        if (!CollectionUtils.isEmpty(memberList)) {
            return memberList.get(0);
        }
        return null;
    }

    @Override
    public UmsMember getById(Long id) {
        return memberMapper.selectById(id);
    }






    @Override
    public UserDto loadUserByUsername(String username) {
        UmsMember member = getByUsername(username);
        if(member!=null){
            UserDto userDto = new UserDto();
            BeanUtil.copyProperties(member,userDto);
            userDto.setRoles(CollUtil.toList("前台会员"));
            return userDto;
        }
        return null;
    }

    @Override
    public R login(Long uid) {

        UmsMember umsMember = memberMapper.selectById(uid);


        // 登录token
        String token = JWTUtil.getInstance().generateToken(umsMember.getId() + "", umsMember.getUsername(), umsMember.getPhone(), 604800, UserType.ADMIN.getCode(), null);
        Map<String, String> tokenMap = new HashMap<>();
        tokenMap.put("token", token);
        //新建redis记录值
        UserDto userDto = new UserDto();
        userDto.setId(umsMember.getId());
        userDto.setClientId(AuthConstant.PORTAL_CLIENT_ID);
        userDto.setUsername(umsMember.getUsername());
        redisTemplate.opsForValue().set("mall:ums:member:"+token, GsonUtil.getJson(userDto));
        return R.success(umsMember.getToken(),"");
    }


}
