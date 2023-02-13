import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'model_view_cubit.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatBotScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',);
  final _user2 = const types.User(id: 'dbthbdtbdthbdthb');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModelViewCubit(),
      child: BlocConsumer<ModelViewCubit, ModelViewState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var dataAPI= ModelViewCubit.get(context);
          return Scaffold(
            appBar: appBar(context),
            body: Chat(
              emptyState: const Center(child: Text('Start conversation with AI Chatbot',style: TextStyle(fontFamily: 'Cairo',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),)),
              theme: chatTheme(),
              messages: _messages,
              onSendPressed:(types.PartialText message) {
                _handleSendPressed(message);
                 dataAPI.aiData(message.text).then((value) {
                  final textMessage2 = types.TextMessage(
                    author: _user2,
                    createdAt: DateTime
                        .now()
                        .millisecondsSinceEpoch,
                    id: randomString(),
                    text: value.data[0].toString(),
                  );
                  _addMessage(textMessage2);
                });
                },
              user: _user,
            ),
          );
        },
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);

  }
}


AppBar appBar(context) =>
    AppBar(
      elevation: 0.8,
      toolbarHeight: 80,
      leadingWidth: 80,
      title: const Text('AI Chatbot',style: TextStyle(fontSize: 26),),
      centerTitle: true,
    );


// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

ChatTheme chatTheme() =>
    const DefaultChatTheme(

      sentMessageBodyTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Cairo', fontSize: 14,
          fontWeight: FontWeight.w500),
      attachmentButtonIcon: Icon(Icons.attach_file,),
      sendButtonIcon: Icon(Icons.send,color: Colors.blue,),
      inputBackgroundColor: Colors.black26,
      inputTextColor: Colors.black,
      inputTextStyle: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Cairo'),
      inputBorderRadius: BorderRadius.zero,
      inputContainerDecoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      emptyChatPlaceholderTextStyle: TextStyle(fontFamily: 'Cairo',
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal),
      primaryColor: Colors.blue,
    );
