package com.ms.job.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ms.job.domain.SysJobLog;

/**
 * 定时任务调度日志信息信息 服务层
 *
 * @author xiaobing
 */
public interface ISysJobLogService extends IService<SysJobLog> {

    /**
     * 清空任务日志
     */
    public void cleanJobLog();

    void addJobLog(SysJobLog sysJobLog);

}
