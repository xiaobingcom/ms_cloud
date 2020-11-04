package com.ms.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ms.admin.mapper.OmsCompanyAddressMapper;
import com.ms.admin.pojo.po.OmsCompanyAddress;
import com.ms.admin.service.OmsCompanyAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 收货地址管理Service实现类
 * Created by macro on 2018/10/18.
 */
@Service
public class OmsCompanyAddressServiceImpl implements OmsCompanyAddressService {
    @Autowired
    private OmsCompanyAddressMapper companyAddressMapper;
    @Override
    public List<OmsCompanyAddress> list() {
        return companyAddressMapper.selectList(new QueryWrapper<>());
    }

    @Override
    public int put(OmsCompanyAddress address) {
        if (address.getId()!=null) {
          return   companyAddressMapper.updateById(address);
        }
        return companyAddressMapper.insert(address);
    }

    @Override
    public int delete(List<Long> ids) {
        return companyAddressMapper.deleteBatchIds(ids);
    }

    @Override
    public OmsCompanyAddress get(Long orderId) {
        return companyAddressMapper.selectById(orderId);

    }
}
