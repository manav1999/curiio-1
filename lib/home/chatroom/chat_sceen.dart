import 'package:flutter/material.dart';
import 'package:login_curiio/home/chatroom/messages.dart';
import 'package:login_curiio/home/chatroom/new_message.dart';

// import 'package:login_curiio/home/chatroom/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
