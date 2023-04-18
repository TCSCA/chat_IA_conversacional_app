import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integrate_chat_app/src/models/message_models.dart';
import 'package:meta/meta.dart';

import '../services/chat_sonic_service.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<OnInitialState>((_onInitialState));
    on<OnChangeTypingIdentificator>((_onChangeTypingIdentificator));
    on<OnChangeMessages>((_onChangeMessages));
    on<OnSendMessage>((_onSendMessage));
    on<OnRecivedMessage>((_onRecivedMessage));
  }

  Future<void> _onInitialState(
      OnInitialState event, Emitter<ChatState> emit) async {
    List<Message> variable = [];

    variable.add(
      Message(
        text: 'Buenos dias, ¿que sintomas presentas?',
        date: DateTime.now(),
        isSendByMe: false,
        question1: "Dolor de cabeza",
        question2: "Dolor abdominal",
        question3: "Dolor de espalda",
        question4: "Dolor articular",
      ),
    );

    emit(state.copyWidth(messages: variable));
  }

  Future<void> _onChangeTypingIdentificator(
      OnChangeTypingIdentificator event, Emitter<ChatState> emit) async {}

  Future<void> _onChangeMessages(
      OnChangeMessages event, Emitter<ChatState> emit) async {}

  Future<void> _onSendMessage(
      OnSendMessage event, Emitter<ChatState> emit) async {
    List<Message> casa =
        await copyMessage(state.messages!, event.message, null, true);

    emit(state.copyWidth(messages: casa, isSendByMe: true));
  }

  Future<void> _onRecivedMessage(
      OnRecivedMessage event, Emitter<ChatState> emit) async {
    List<Message> casa =
        await copyMessage(state.messages!, event.message, null, false);

    emit(state.copyWidth(messages: casa, isSendByMe: false));
  }
}

Future<List<Message>> copyMessage(
    List<Message> vare, String text, String? question1, bool isSend) async {
  List<Message> variable = [];

  if (!vare.isEmpty) {
    for (var i = 0; i < vare.length; i++) {
      variable.add(
        Message(
            isSendByMe: vare[i].isSendByMe,
            date: vare[i].date,
            text: vare[i].text,
            question1: vare[i].question1,
            question2: vare[i].question2,
            question3: vare[i].question3,
            question4: vare[i].question4,
            question5: vare[i].question5),
      );
    }
  }

  if (isSend) {
    variable.add(Message(text: text, date: DateTime.now(), isSendByMe: isSend));
  } else {
    final decodedResp = await sonciChatService(text);
    variable.add(Message(
        text: decodedResp!['data']['message'],
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSendByMe: false));
  }

  return variable;
}
