package com.ms.notice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

/**
 * 开启webSocket支持
 *
 * @author xiaobing
 * @version v1.0.0
 * @date 2020/4/22
 * @Description Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/4/22              xiaobing          v1.0.0           Created
 */
@Configuration
public class WebSocketConfig {

    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }

}