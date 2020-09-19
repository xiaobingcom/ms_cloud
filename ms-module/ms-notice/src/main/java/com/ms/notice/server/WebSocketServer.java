package com.ms.notice.server;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;


/**
 * webSocket 服务
 *
 * @author xiaobing
 */
@ServerEndpoint("/imserver/{userType}/{userId}")
@Service
public class WebSocketServer {

    /**
     * 静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
     */
    private static int onlineCount = 0;
    /**
     * concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。
     */
    private static ConcurrentHashMap<String, WebSocketServer> webSocketMap = new ConcurrentHashMap<>();
    /**
     * 与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    private Session session;
    /**
     * 接收userId
     */
    private String userId = "";


    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("userType") String userType, @PathParam("userId") String userId) {

        System.out.println(userType);
        this.session = session;
        this.userId = userId + userType;
        if (webSocketMap.containsKey(userId + userType)) {
            webSocketMap.remove(userId + userType);
            webSocketMap.put(userId + userType, this);
            //加入set中
        } else {
            webSocketMap.put(userId + userType, this);
            //加入set中
            addOnlineCount();
            //在线数加1
        }

        System.out.println("用户连接:" + userId + userType + ",当前在线人数为:" + getOnlineCount());

        try {
            sendMessage("连接成功");
        } catch (IOException e) {
            System.out.println("用户:" + userId + userType + ",网络异常!!!!!!");
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {
        if (webSocketMap.containsKey(userId)) {
            webSocketMap.remove(userId);
            //从set中删除
            subOnlineCount();
        }
        System.out.println("用户退出:" + userId + ",当前在线人数为:" + getOnlineCount());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("用户消息:" + userId + ",报文:" + message);
        //可以群发消息
        //消息保存到数据库、redis
        if (StringUtils.isNotBlank(message)) {
            try {
                //解析发送的报文
                JSONObject jsonObject = JSON.parseObject(message);
                //追加发送人(防止串改)
                jsonObject.put("fromUserId", this.userId);
                String toUserId = jsonObject.getString("toUserId");
                //传送给对应toUserId用户的websocket
                if (StringUtils.isNotBlank(toUserId) && webSocketMap.containsKey(toUserId)) {
                    webSocketMap.get(toUserId).sendMessage(jsonObject.toJSONString());
                } else {
                    System.out.println("请求的userId:" + toUserId + "不在该服务器上");
                    //否则不在这个服务器上，发送到mysql或者redis
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("用户错误:" + this.userId + ",原因:" + error.getMessage());
        error.printStackTrace();
    }

    /**
     * 实现服务器主动推送
     */
    public void sendMessage(String message) throws IOException {
        this.session.getBasicRemote().sendText(message);
    }


    /**
     * 发送自定义消息
     */
    public void sendInfo(String committeeName, String title, String message, @PathParam("userType") String userType, @PathParam("userId") String userId) throws IOException {

//        //新建消息类型
//        TbInform tbInform = new TbInform();
//        tbInform.setMessage(message);
//        tbInform.setTitle(title);
//        tbInform.setCommitteeName(committeeName);
//        tbInform.setUserId(Long.parseLong(userId));
//        tbInform.setCreateDate(new Date());
//        tbInform.setUpdateDate(new Date());
//        tbInform.setUserType(userType);
//        tbInform.setStatus(0);
//        System.out.println("发送消息到:"+userId+userType+"，报文:"+ GsonUtil.getJson(tbInform));
        if (StringUtils.isNotBlank(userId + userType) && webSocketMap.containsKey(userId + userType)) {
//            webSocketMap.get(userId+userType).sendMessage(GsonUtil.getJson(tbInform));
        }
//        informMapper.insert(tbInform);
    }

    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        WebSocketServer.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        WebSocketServer.onlineCount--;
    }
}