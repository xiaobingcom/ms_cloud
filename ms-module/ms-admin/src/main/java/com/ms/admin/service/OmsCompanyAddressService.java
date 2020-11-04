package com.ms.admin.service;


import com.ms.admin.pojo.po.OmsCompanyAddress;

import java.util.List;

/**
 * 收货地址管Service
 * Created by macro on 2018/10/18.
 */
public interface OmsCompanyAddressService {
    /**
     * 获取全部收货地址
     */
    List<OmsCompanyAddress> list();

    int put(OmsCompanyAddress address);

    int delete(List<Long> ids);

    OmsCompanyAddress get(Long orderId);

}
