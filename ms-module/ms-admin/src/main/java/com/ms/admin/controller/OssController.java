package com.ms.admin.controller;


import com.ms.admin.pojo.vo.OssCallbackResult;
import com.ms.admin.pojo.vo.OssPolicyResult;
import com.ms.admin.service.impl.OssServiceImpl;
import com.ms.common.core.annotation.TokenTypeAnnotation;
import com.ms.common.core.domain.R;
import com.ms.common.core.enums.UserType;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Oss相关操作接口
 * Created by macro on 2018/4/26.
 */
@Controller
@Api(tags = "OssController", description = "Oss管理")
@RequestMapping("/aliyun/oss")
@TokenTypeAnnotation(tokenTypeCan = UserType.ADMIN)
public class OssController {
    @Autowired
    private OssServiceImpl ossService;

    @ApiOperation(value = "oss上传签名生成")
    @RequestMapping(value = "/policy", method = RequestMethod.GET)
    @ResponseBody
    public R<OssPolicyResult> policy() {
        OssPolicyResult result = ossService.policy();
        return R.success(result);
    }

    @ApiOperation(value = "oss上传成功回调")
    @RequestMapping(value = "callback")
    @ResponseBody
    public R<OssCallbackResult> callback(HttpServletRequest request) {
        OssCallbackResult ossCallbackResult = ossService.callback(request);
        return R.success(ossCallbackResult);
    }

}
