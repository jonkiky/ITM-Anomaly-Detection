package edu.albany.util.websocket;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


@Component
public class MyWebSocketHandler implements WebSocketHandler {
	
	public static final Map<String, WebSocketSession> SocketSessionMap;
	
	static {
		SocketSessionMap = new HashMap<String, WebSocketSession>();
	}

	
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		String uid = (String) session.getAttributes().get("uid");
			if (SocketSessionMap.get(uid) == null) {
				SocketSessionMap.put(uid, session);
			}
	}




	public void handleTransportError(WebSocketSession session,
			Throwable exception) throws Exception {
		if (session.isOpen()) {
			session.close();
		}
		removeSession(session,SocketSessionMap);
	}



	public void afterConnectionClosed(WebSocketSession session,
			CloseStatus closeStatus) throws Exception {
		System.out.println("Websocket:" + session.getId() + "closed");
		removeSession(session,SocketSessionMap);
		
	}
	
	private void removeSession(WebSocketSession session,Map<String, WebSocketSession> map){
		Iterator<Entry<String, WebSocketSession>> it = map
				.entrySet().iterator();
		while (it.hasNext()) {
			Entry<String, WebSocketSession> entry = it.next();
			if (entry.getValue().getId().equals(session.getId())) {
				map.remove(entry.getKey());
				System.out.println("Socket session disconnect: ID" + entry.getKey());
				break;
			}
		}
	}

	public boolean supportsPartialMessages() {
		return false;
	}

	
	public void broadcast(final TextMessage message) throws IOException {
		
		Iterator<Entry<String, WebSocketSession>> it = null;
		
			it = SocketSessionMap
					.entrySet().iterator();
		
		

		while (it.hasNext()) {

			final Entry<String, WebSocketSession> entry = it.next();

			if (entry.getValue().isOpen()) {
				// entry.getValue().sendMessage(message);
				new Thread(new Runnable() {

					public void run() {
						try {
							if (entry.getValue().isOpen()) {
								entry.getValue().sendMessage(message);
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}

				}).start();
			}

		}
	}


	public void sendMessageToUser(String uid, TextMessage message)
			throws IOException {
		WebSocketSession session =null;
			 session = SocketSessionMap.get(uid);
		
		if (session != null && session.isOpen()) {
			session.sendMessage(message);
		}
	}




	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		if(message.getPayloadLength()==0)return;
		System.out.print(message.getPayload().toString());
		Message msg=new Gson().fromJson(message.getPayload().toString(),Message.class);
		sendMessageToUser(msg.getTo(), new TextMessage(new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(msg)));
	}


}
