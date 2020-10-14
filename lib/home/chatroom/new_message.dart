import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:login_curiio/database/db_queries.dart' as db;

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();

  Future<void> _sendMessage() async {
    print('sending message');
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
    await db.DBQueries().addMessageToDB(_enteredMessage);
    // await _refreshMessages();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLength: 200,
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: 'Type here...'),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          ),
        ),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.send),
          onPressed: () {
            return _enteredMessage.trim().isEmpty ? null : _sendMessage();
          },
        ),
      ],
    );
  }
}
