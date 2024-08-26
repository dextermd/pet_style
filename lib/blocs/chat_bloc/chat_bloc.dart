import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style/core/services/socket_service.dart';
import 'package:pet_style/data/model/message/message.dart';
import 'package:pet_style/domain/repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository petRepository;
  final SocketService socketService;

  ChatBloc(this.petRepository, this.socketService) : super(ChatInitial()) {
    on<SendMessageEvent>((event, emit) async {
      if (state is ChatLoadedState) {
        final currentMessages =
            List<Message>.from((state as ChatLoadedState).messages ?? []);
        currentMessages.add(event.message);

        emit(ChatLoadedState(List<Message>.from(currentMessages)));

        await socketService.sendMessage(event.message);
      } else {
        emit(ChatLoadedState([event.message]));
        await socketService.sendMessage(event.message);
      }
    });

    on<ConnectToSocketEvent>((event, emit) {
      socketService.connect(event.senderId);

      socketService.socket.off('receiveMessage');
      socketService.socket.on('receiveMessage', (data) {
        final message = Message.fromJson(data);

        add(ReceiveMessageEvent(
            message));
      });

      add(GetChatMessagesEvent(event.senderId, event.receiverId));
    });

    on<ReceiveMessageEvent>((event, emit) {
      if (state is ChatLoadedState) {
        final currentMessages =
            List<Message>.from((state as ChatLoadedState).messages ?? []);
        currentMessages.add(event.message);

        emit(ChatLoadedState(List<Message>.from(currentMessages)));
      }
    });

    on<GetChatMessagesEvent>((event, emit) async {
      emit(ChatLoadingState());

      socketService.socket.emit('getChatHistory', {
        'senderId': event.senderId,
        'receiverId': event.receiverId,
      });

      final completer = Completer<void>();

      void handleChatHistory(data) {
        List<Message> messages =
            (data as List).map((message) => Message.fromJson(message)).toList();

        emit(ChatLoadedState(messages));

        completer.complete();
      }

      socketService.socket.on('chatHistory', handleChatHistory);

      await completer.future;

      socketService.socket.off('chatHistory', handleChatHistory);
    });
  }
}
