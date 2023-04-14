part of 'chat_bloc.dart';

@immutable
class ChatState {
  final List<Message>? messages;
  final bool isSendByMe;

  const ChatState({this.messages = const[], this.isSendByMe = false});

  ChatState copyWidth({List<Message>? messages, bool? isSendByMe}) {
    return ChatState(
        messages: messages ?? this.messages,
        isSendByMe: isSendByMe ?? this.isSendByMe);
  }
}
