package com.ms.admin.controller;

import com.ms.admin.pojo.po.OmsCompanyAddress;
import com.ms.admin.service.OmsCompanyAddressService;
import com.ms.common.core.domain.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 收货地址管理Controller
 * Created by macro on 2018/10/18.
 */
@Controller
@Api(tags = "OmsCompanyAddressController", description = "收货地址管理")
@RequestMapping("/companyAddress")
public class OmsCompanyAddressController {
    @Autowired
    private OmsCompanyAddressService companyAddressService;

    @ApiOperation("获取所有收货地址")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public R<List<OmsCompanyAddress>> list() {
        List<OmsCompanyAddress> companyAddressList = companyAddressService.list();
        return R.success(companyAddressList);
    }

    @ApiOperation("获取所有收货地址")
    @RequestMapping(value = "/put", method = RequestMethod.POST)
    @ResponseBody
    public R put(@RequestBody OmsCompanyAddress address) {
        int i = companyAddressService.put(address);
        return R.success();
    }
    @ApiOperation("获取所有收货地址")
    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public R get(@PathVariable("id") Long orderId) {
        OmsCompanyAddress address = companyAddressService.get(orderId);
        return R.success(address);
    }

    @ApiOperation("批量删除")
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public R delete(@RequestParam List<Long> ids) {
        int i = companyAddressService.delete(ids);
        return R.success();
    }
}
