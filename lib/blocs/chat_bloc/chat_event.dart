// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ConnectToSocketEvent extends ChatEvent {
  final String senderId;
  final String receiverId;
  const ConnectToSocketEvent({
    required this.senderId,
    required this.receiverId,
  });

  @override
  List<Object> get props => [senderId];
}

class SendMessageEvent extends ChatEvent {
  final Message message;

  const SendMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}

class GetChatMessagesEvent extends ChatEvent {
  final String receiverId;
  final String senderId;

  const GetChatMessagesEvent(this.receiverId, this.senderId);

  @override
  List<Object> get props => [receiverId, senderId];
}

class ReceiveMessageEvent extends ChatEvent {
  final Message message;

  const ReceiveMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}