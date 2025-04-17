import 'dart:ffi';

import 'package:flutter_expert_rest_api_dangeun/data/model/chat_room.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatGlobalState {
  List<ChatRoom> chatRooms;
  ChatRoom? chatRoom;

  ChatGlobalState({required this.chatRooms, required this.chatRoom});

  ChatGlobalState copyWith({List<ChatRoom>? chatRooms, ChatRoom? chatRoom}) {
    return ChatGlobalState(
      chatRooms: chatRooms ?? this.chatRooms,
      chatRoom: chatRoom ?? this.chatRoom,
    );
  }
}

class ChatGlobalViewModel extends Notifier<ChatGlobalState> {
  @override
  ChatGlobalState build() {
    fetchList().then((value) {
      connectSocket();
    });

    return ChatGlobalState(chatRooms: [], chatRoom: null);
  }

  final chatRepository = ChatRepository();

  Future<void> fetchList() async {
    final result = await chatRepository.list();
    if (result != null) {
      state = state.copyWith(chatRooms: result);
    }
  }

  Future<void> fetchChatDetail(int roomId) async {
    final result = await chatRepository.detail(roomId);
    if (result != null) {
      state = state.copyWith(chatRoom: result);
    }
  }

  Future<int?> createChat(int productId) async {
    final result = await chatRepository.create(productId);
    if (result != null) {
      state = state.copyWith(chatRooms: [result, ...state.chatRooms]);

      return result.roomId;
    }
    return null;
  }

  int? findChatRoomByProductId(int productId) {
    final target =
        state.chatRooms.where((e) => e.product.id == productId).toList();
    if (target.isEmpty) {
      return target.first.roomId;
    }
    return null;
  }

  ChatSocket? chatSocket;

  void connectSocket() {
    chatSocket = chatRepository.connectSocket();
    final subscription = chatSocket!.messageStream.listen((chatRoom) {
      final chatRooms = state.chatRooms;
      final target =
          chatRooms
              .where((element) => element.roomId == chatRoom.roomId)
              .toList();
      if (target.isEmpty) {
        final newList =
            chatRooms.map((e) {
              if (e.roomId == chatRoom.roomId) {
                return chatRoom;
              }
              return e;
            }).toList();

        state = state.copyWith(chatRooms: newList);
      } else {
        state = state.copyWith(chatRooms: [...chatRooms, chatRoom]);
      }

      final room = state.chatRoom;
      if (room?.roomId == chatRoom.roomId) {
        state = state.copyWith(
          chatRoom: ChatRoom(
            roomId: room!.roomId,
            product: room.product,
            sender: room.sender,
            messages: [...room.messages, chatRoom.messages.first],
            createdAt: room.createdAt,
          ),
        );
      }
    });

    ref.onDispose(() {
      subscription.cancel();
    });
  }

  void send(String content) {
    final room = state.chatRoom;
    if (room != null) {
      chatSocket?.sendMessage(content: content, roomId: room.roomId);
    }
  }
}

final ChatGlobalViewModelPrivider =
    NotifierProvider<ChatGlobalViewModel, ChatGlobalState>(() {
      return ChatGlobalViewModel();
    });
