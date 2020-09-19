package com.ms.notice.controller;

import com.ms.notice.server.WebSocketServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

/**
 * 消息推送
 *
 * @author 肖兵
 * @version v1.0.0
 * @date 2020/7/24
 * 历史版本 Modification History:
 * Date                 Author          Version          Description
 * ---------------------------------------------------------------------------------*
 * 2020/7/24              肖兵             v1.0.0           Created
 */
@RestController
@RequestMapping("/notice")
public class NoticeController {


    @Autowired
    private WebSocketServer webSocketServer;
//    /**
//     * app发送通知
//     */
//    @GetMapping("/send/app")
//    public void sendApp(@RequestParam(value = "registrationId") String registrationId, @RequestParam(value = "title") String title, @RequestParam(value = "msg") String msg, @RequestParam(value = "msgContent") String msgContent,@RequestParam(value = "orderId") Long orderId) {
//
//        HashMap<String, String> objectObjectHashMap = new HashMap<>();
//        objectObjectHashMap.put("orderId",orderId+"");
//
////        JpushUtil.sendToRegistrationId(registrationId, title, msg, msgContent, objectObjectHashMap);
//    }


    /**
     * web发送通知
     */
    @GetMapping("/send/web")
    public void sendWeb(@RequestParam String committeeName, @RequestParam Long userId, @RequestParam String userType, @RequestParam String title, @RequestParam String message) {
        try {
            webSocketServer.sendInfo(committeeName, title, message, userType, userId + "");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


//    /**
//     * 获取未读消息数量
//     */
//    @GetMapping("/get/count")
//    public Integer getCount(@RequestParam Long userId, @RequestParam String userType) {
//            return informService.getCount(userId, userType);
//
//    }


}
