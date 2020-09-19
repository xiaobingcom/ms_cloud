package com.ms.job.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ms.common.controller.BaseController;
import com.ms.common.core.domain.R;
import com.ms.common.core.exception.TaskException;
import com.ms.common.utils.SecurityUtils;
import com.ms.job.domain.SysJob;
import com.ms.job.service.ISysJobService;
import com.ms.job.util.CronUtils;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 调度任务信息操作处理
 *
 * @author xiaobing
 */
@RestController
@RequestMapping("/job")
public class SysJobController extends BaseController {
    @Autowired
    private ISysJobService jobService;

    @Autowired
    private IService<SysJob> sysJobIService;

    /**
     * 查询定时任务列表
     */
    @GetMapping("/list")
    public R list(SysJob sysJob) {
        IPage<SysJob> iPage = startPage(SysJob.class);
        QueryWrapper<SysJob> sysJobQueryWrapper = new QueryWrapper<>();
        sysJobQueryWrapper.setEntity(sysJob);
        IPage<SysJob> page = sysJobIService.page(iPage, sysJobQueryWrapper);
        return R.ok(page);
    }

    /**
     * 获取定时任务详细信息
     */
    @GetMapping(value = "/{jobId}")
    public R getInfo(@PathVariable("jobId") Long jobId) {
        return R.ok(sysJobIService.getById(jobId));
    }

    /**
     * 新增定时任务
     */
    @PostMapping
    public R add(@RequestBody SysJob sysJob) {
        if (!CronUtils.isValid(sysJob.getCronExpression())) {
            return R.fail("cron表达式不正确");
        }
        sysJob.setCreateBy(SecurityUtils.getUsername());
        return toAjax(sysJobIService.save(sysJob));
    }

    /**
     * 修改定时任务
     */
    @PutMapping
    public R edit(@RequestBody SysJob sysJob) {
        if (!CronUtils.isValid(sysJob.getCronExpression())) {
            return R.fail("cron表达式不正确");
        }
        sysJob.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(sysJobIService.updateById(sysJob));
    }

    /**
     * 定时任务状态修改
     */
    @PutMapping("/changeStatus")
    public R changeStatus(@RequestBody SysJob job) throws SchedulerException {
        SysJob newJob = sysJobIService.getById(job.getJobId());
        newJob.setStatus(job.getStatus());
        return toAjax(jobService.changeStatus(newJob));
    }

    /**
     * 定时任务立即执行一次
     */
    @PutMapping("/run")
    public R run(@RequestBody SysJob job) throws SchedulerException {
        jobService.run(job);
        return R.ok();
    }

    /**
     * 删除定时任务
     */
    @DeleteMapping("/{jobIds}")
    public R remove(@PathVariable Long[] jobIds) throws SchedulerException, TaskException
    {
        jobService.deleteJobByIds(jobIds);
        return R.ok();
    }
}
