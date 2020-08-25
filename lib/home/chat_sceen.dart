import 'package:flutter/material.dart';

import 'package:login_curiio/home/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (ctx, item) => ChatBubble(),
      ),
    );
  }
}
