import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integrate_chat_app/src/bloc/chat_bloc.dart';


import '../models/message_models.dart';
import '../services/chat_sonic_service.dart';
import '../widgets/message_list_widget.dart';
import '../widgets/typing_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _msgUserCtrl = TextEditingController();

  //List<Message> messages = [];

  Map<String, String> body = {'message': ''};

  String myVar = '';

 // bool isTyping = true;

  @override
  void initState() {
    // TODO: implement initState
    //sonciChatService('quien eres?');




 /*   messages.add(Message(text: 'Buenos dias en que puedo ayudarte',
        date: DateTime.now(),
        isSendByMe: false,
        question1: "hola",
        question2: "hola 2"
    ));*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IA conversacional'),
        backgroundColor: Colors.indigo[400],
      ),
      body: BlocProvider(
        create: (context) => ChatBloc(),
        child: bodyChat(),
      ),
    );
  }

  Widget bodyChat() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Column(
          children: [

            /// Esta parte se asegura que la caja de texto se posicione hasta abajo de la pantalla
            Expanded(
              child: MessagesList(
                messages: state.messages!,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TypingIndicator(
                showIndicator: state.isSendByMe,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              color: Colors.indigo[400],
              child: Row(
                children: [

                  /// El Widget [Expanded] se asegura que el campo de texto ocupe
                  /// toda la pantalla menos el ancho del [IconButton]
                  Expanded(
                    child: TextField(
                      controller: _msgUserCtrl,
                      decoration: InputDecoration(
                        hintText: "¿que infomación desea solicitar?",
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.send),
                    onPressed: () async {

                      //context.read<ChatBloc>().add(OnChangeTypingIdentificator());

                      if (_msgUserCtrl.text != "") {

                        context.read<ChatBloc>().add(OnSendMessage(message: _msgUserCtrl.text));
                    /* messages.add(Message(
                            text: _msgUserCtrl.text,
                            date: DateTime.now(),
                            isSendByMe: true));*/
                        body['message'] = _msgUserCtrl.text;
                        myVar = _msgUserCtrl.text;
                        _msgUserCtrl.clear();
                       // isTyping = true;
                     /*   setState(() {});


                        final decodedResp = await sonciChatService(myVar);
                        messages.add(Message(
                            text: decodedResp!['data']['message'],
                            date: DateTime.now().subtract(Duration(minutes: 1)),
                            isSendByMe: false));
                        isTyping = false;
                        setState(() {});*/
                      }

                      /// Limpiamos nuestro campo de texto
                      _msgUserCtrl.clear();
                    },
                  ),
                ],
              ), // Fin de la fila
            ),
            // Fin del contenedor
          ],
        );
      },
    );
  }
}








