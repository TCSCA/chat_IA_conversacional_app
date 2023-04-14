import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integrate_chat_app/src/models/message_models.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<OnInitialState>((_onInitialState));
    on<OnChangeTypingIdentificator>((_onChangeTypingIdentificator));
    on<OnChangeMessages>((_onChangeMessages));
    on<OnSendMessage>((_onSendMessage));
  }

  Future<void> _onInitialState(
      OnInitialState event, Emitter<ChatState> emit) async {}

  Future<void> _onChangeTypingIdentificator(
      OnChangeTypingIdentificator event, Emitter<ChatState> emit) async {}

  Future<void> _onChangeMessages(
      OnChangeMessages event, Emitter<ChatState> emit) async {}

  Future<void> _onSendMessage(
      OnSendMessage event, Emitter<ChatState> emit) async {
    List<Message> casa = await copyMessage(state.messages!, event.message);

    emit(state.copyWidth(messages: casa, isSendByMe: true));
  }
}

Future<List<Message>> copyMessage(List<Message> vare, text) async {
  List<Message> variable = [];
  


  if(!vare.isEmpty) {

 /*   vare.map((e) => {
      variable.add(
        Message(
          isSendByMe: vare[e].isSendByMe,
          date: vare[i].date,
          text: vare[i].text,
        ),
      )
    });*/

    for (var i = 0; i < vare.length; i++) {
      variable.add(
        Message(
          isSendByMe: vare[i].isSendByMe,
          date: vare[i].date,
          text: vare[i].text,
        ),
      );
    }
  }


  variable.add(Message(text: text, date: DateTime.now(), isSendByMe: true));

  return variable;
}
