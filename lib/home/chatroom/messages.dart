import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_curiio/home/chatroom/chat_bubble.dart';
import 'package:login_curiio/models/message.dart';
import 'package:login_curiio/database/db_queries.dart' as db;

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool _isInit = false;
  var _isLoading = false;
  List<Message> loadedChats = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });

    _refreshMessages().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshMessages() async {
    print('refreshing...');
    loadedChats = await db.DBQueries().fetchMessages();
    print('loaded chats');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            child: ListView.builder(
              itemBuilder: (ctx, index) => ChatBubble(loadedChats[index]),
              itemCount: loadedChats.length,
            ),
            onRefresh: _refreshMessages,
          );
  }
}
