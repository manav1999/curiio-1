import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();

  //
  Future<void> _sendMessageAndAddToDB() async {
    FocusScope.of(context).unfocus();
    User user = FirebaseAuth.instance.currentUser;

    final url = 'https://curiio-dev-3cedd.firebaseio.com/chats.json';

    try {
      await http.post(
        url,
        body: json.encode({
          'message': _enteredMessage,
          'userId': user == null
              ? 'google user'
              : user
                  .email, //this isnt working for google signed in users. need to check if person is a google user and render differently
          'timestamp':
              DateFormat.yMd().add_jm().format(new DateTime.now()).toString(),
        }),
      );
      _controller.clear();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            decoration:
                InputDecoration(hintText: 'Do you have a question to ask?'),
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
            return _enteredMessage.trim().isEmpty
                ? null
                : _sendMessageAndAddToDB();
          },
        ),
      ],
    );
  }
}
