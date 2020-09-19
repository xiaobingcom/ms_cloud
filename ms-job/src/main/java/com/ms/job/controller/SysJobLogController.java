package com.ms.job.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ms.common.controller.BaseController;
import com.ms.common.core.domain.R;
import com.ms.job.domain.SysJobLog;
import com.ms.job.service.ISysJobLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 调度日志操作处理
 *
 * @author xiaobing
 */
@RestController
@RequestMapping("/job/log")
public class SysJobLogController extends BaseController {
    @Autowired
    private ISysJobLogService jobLogService;

    @Autowired
    private IService<SysJobLog> jobLogIService;

    /**
     * 查询定时任务调度日志列表
     */
    @GetMapping("/list")
    public R list(SysJobLog sysJobLog) {
        IPage<SysJobLog> iPage = startPage(SysJobLog.class);
        QueryWrapper<SysJobLog> sysJobQueryWrapper = new QueryWrapper<>();
        sysJobQueryWrapper.setEntity(sysJobLog);
        IPage<SysJobLog> page = jobLogIService.page(iPage, sysJobQueryWrapper);
        return R.ok(page);
    }

    /**
     * 根据调度编号获取详细信息
     */
    @GetMapping(value = "/{configId}")
    public R getInfo(@PathVariable Long jobLogId) {
        return R.ok(jobLogIService.getById(jobLogId));
    }

    /**
     * 删除定时任务调度日志
     */
    @DeleteMapping("/{jobLogIds}")
    public R remove(@PathVariable Long[] jobLogIds) {
        return R.ok(jobLogIService.removeById(jobLogIds));
    }

    /**
     * 清空定时任务调度日志
     */
    @DeleteMapping("/clean")
    public R clean() {
        jobLogService.cleanJobLog();
        return R.ok();
    }
}
