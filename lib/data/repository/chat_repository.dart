import 'dart:async';
import 'dart:convert';

import 'package:flutter_expert_rest_api_dangeun/data/model/chat_room.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/base_remote_repository.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatRepository extends BaseRemoteRepository {
  Future<List<ChatRoom>?> list() async {
    final response = await client.get('/api/chat/room/list');
    if (response.statusCode == 200) {
      final content = response.data['content'];
      return List.from(content).map((e) => ChatRoom.fromJson(e)).toList();
    }
    return null;
  }

  Future<ChatRoom?> detail(int roomId) async {
    final response = await client.get('/api/chat/room/$roomId');
    if (response.statusCode == 200) {
      return ChatRoom.fromJson(response.data['content']);
    }
    return null;
  }

  Future<ChatRoom?> create(int productId) async {
    final response = await client.post('/api/chat/room/make/$productId');
    if (response.statusCode == 201) {
      return ChatRoom.fromJson(response.data['content']);
    }
    return null;
  }

  ChatSocket connectSocket() {
    StompClient? stompClient;
    final chatRoomStream = StreamController<ChatRoom>(
      onListen: () {
        stompClient?.activate();
      },
      onCancel: () {
        stompClient?.deactivate();
      },
    );

    stompClient = StompClient(
      config: StompConfig(
        url: '${client.options.baseUrl}/ws',
        webSocketConnectHeaders: {
          'transports': ["websocket"],
          'content-type': "application/octet-stream",
          'Authorization': bearerToken,
        },
        onConnect: (frame) {
          stompClient?.subscribe(
            destination: '/user/queue/pub',
            callback: (frame) {
              if (frame.body != null) {
                chatRoomStream.add(ChatRoom.fromJson(jsonDecode(frame.body!)));
              }
              frame.body;
            },
          );
        },
      ),
    );

    return ChatSocket(
      messageStream: chatRoomStream.stream,
      sendMessage: ({required content, required roomId}) {
        stompClient?.send(
          destination: '/chat-socket/chat.send',
          body: jsonEncode({'content': content, 'roomId': roomId}),
        );
      },
    );
  }
}

class ChatSocket {
  final Stream<ChatRoom> messageStream;
  final void Function({required int roomId, required String content})
  sendMessage;

  ChatSocket({required this.messageStream, required this.sendMessage});
}
