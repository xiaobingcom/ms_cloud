package com.ms.job.task;


import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * 定时任务
 *
 * @author xiaobing
 * @version v1.0.0
 * @date 2020/4/28
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/4/28              xiaobing          v1.0.0           Created
 */


@Configuration      //1.主要用于标记配置类，兼备Component的效果。
public class ScheduledTasks {


    private static final org.slf4j.Logger Logger = LoggerFactory.getLogger(ScheduledTasks.class);

    private SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

    @Scheduled(cron = "0 0 1 * * ?")
    public void reportCurrentTime() {
//        this.summaryService.daySum(-1);
        System.out.println("当前时间: " + dateFormat.format(new Date()));
        Logger.info("打印当前时间: {}.", dateFormat.format(new Date()));
    }


}
