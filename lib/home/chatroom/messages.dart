import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_curiio/home/chatroom/chat_bubble.dart';

class Message {
  final String messageBody;
  final String userId;
  final String sentAt;

  Message({this.messageBody, this.userId, this.sentAt});
}

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool _isInit = false;
  var _isLoading = false;
  final List<Message> loadedChats = [];

  Future<void> _fetchMessages() async {
    final url = 'https://curiio-dev-3cedd.firebaseio.com/chats.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      extractedData.forEach((chatId, chatData) {
        loadedChats.add(
          Message(
            messageBody: chatData['message'],
            userId: chatData['userId'],
            sentAt: chatData['timestamp'],
          ),
        );
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _fetchMessages().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) => ChatBubble(loadedChats[index]),
            itemCount: loadedChats.length,
          );
  }
}
