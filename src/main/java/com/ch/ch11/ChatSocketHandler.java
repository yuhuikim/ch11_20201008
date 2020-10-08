package com.ch.ch11;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatSocketHandler extends TextWebSocketHandler {

	// String은 WebSocketSession은 각각 유저의 아이디와 연결 정보가 담겨있다.
	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();

	// 채팅에 연결 됐을 때 : 접속한 클라이언트 users에 session저장
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.put(session.getId(), session); // 누가 접근을 하면 그 사람의 아이디와 연결정보를 넣는다.
		super.afterConnectionEstablished(session);
	}

	// 연결이 종료 됐을 때 : users에서 제거
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session.getId());
	}

	// 클라이언트에서 문자로 메세지가 왔을 때 : 메세지를 연결된 모든 클라이언트 들에게 전송
	protected void handleTextmessage(WebSocketSession session, TextMessage message) throws Exception {
		Collection<WebSocketSession> sessions = users.values();
		for (WebSocketSession ws : sessions) {
			ws.sendMessage(message);
		}
	}
}