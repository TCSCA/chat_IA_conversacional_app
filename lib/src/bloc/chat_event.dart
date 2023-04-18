part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

///Estado Inicial
class OnInitialState extends ChatEvent {}

/// evento del TypingIdentificator
class OnChangeTypingIdentificator extends ChatEvent {}

/// evento de menssages
class OnChangeMessages extends ChatEvent {}

///
class OnSendMessage extends ChatEvent {
  final String message;

  OnSendMessage({required this.message});
}

class OnRecivedMessage extends ChatEvent {
  final String message;

  OnRecivedMessage({required this.message});
}
