package com.ms.job.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ms.job.mapper.SysJobLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ms.job.domain.SysJobLog;

/**
 * 定时任务调度日志信息 服务层
 *
 * @author xiaobing
 */
@Service
public class SysJobLogServiceImpl extends ServiceImpl<SysJobLogMapper, SysJobLog> implements ISysJobLogService {
    @Autowired
    private SysJobLogMapper jobLogMapper;

    /**
     * 清空任务日志
     */
    @Override
    public void cleanJobLog() {
        jobLogMapper.cleanJobLog();
    }

    @Override
    public void addJobLog(SysJobLog sysJobLog) {
        jobLogMapper.insertJobLog(sysJobLog);
    }
}
