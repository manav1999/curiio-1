import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_curiio/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DBQueries {
  List<Message> _loadedChats = [];
  List<Message> _loadedReplies = [];

  List<Message> get loadedChats {
    return [..._loadedChats];
  }

  Future<List<Message>> fetchMessages() async {
    final url = 'https://curiio-dev-3cedd.firebaseio.com/chats.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      extractedData.forEach((chatId, chatData) {
        if (_loadedChats.indexWhere((message) =>
                message.sentAt == chatData['sentAt'] &&
                message.userEmail == chatData['userEmail'] &&
                message.messageBody == chatData['messageBody']) ==
            -1) {
          _loadedChats.add(
            Message(
              messageBody: chatData['messageBody'],
              userEmail: chatData['userEmail'],
              sentAt: chatData['sentAt'],
              messageId: chatId, //added here
            ),
          );
        }
      });
      print('insdie db q');
      print(_loadedChats.length);
      return _loadedChats;
    } catch (error) {
      print(error);
    }
    return _loadedChats;
  }

  Future<void> addMessageToDB(String enteredMessage) async {
    print('adding message to db');
    User user = FirebaseAuth.instance.currentUser;

    final url = 'https://curiio-dev-3cedd.firebaseio.com/chats.json';

    try {
      await http.post(
        url,
        body: json.encode({
          'messageBody': enteredMessage,
          'userEmail': user == null ? 'google user' : user.email,
          'sentAt':
              DateFormat.yMd().add_jm().format(new DateTime.now()).toString(),
          // 'likes': 0,
        }),
      );
    } catch (error) {
      print(error);
    }
  }

  // Future<void> refreshMessages() async {
  //   print('refreshing...');
  //   await fetchMessages();
  //   // setState(() {});
  // }

  Future<List<Message>> fetchReplies(String messageId) async {
    print('fetching replies...');
    print(messageId);
    final url =
        'https://curiio-dev-3cedd.firebaseio.com/chats/${messageId}.json';
    try {
      final response = await http.get(url);
      // print('THIS OS ${response.body.length}');
      // print('THIS OS hahaha ${response.body}');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      extractedData.forEach(
        (chatId, chatData) {
          print(chatId);
          if (_loadedReplies.indexWhere((message) =>
                  message.sentAt == chatData['sentAt'] &&
                  message.userEmail == chatData['userEmail'] &&
                  message.messageBody == chatData['messageBody']) ==
              -1) {
            _loadedReplies.add(
              Message(
                messageBody: chatData['messageBody'],
                userEmail: chatData['userEmail'],
                sentAt: chatData['sentAt'],
                messageId: chatId,
              ),
            );
          }
        },
      );
      print('length${_loadedReplies.length}');
      return _loadedReplies;
    } catch (error) {
      print(error);
    }
    return _loadedReplies;
  }

  Future<void> addReplyToDB(String messageId, String enteredReply) async {
    print('adding reply to db');
    User user = FirebaseAuth.instance.currentUser;

    final url =
        'https://curiio-dev-3cedd.firebaseio.com/chats/${messageId}.json';
    print(messageId);

    try {
      await http.post(
        url,
        body: json.encode({
          'messageBody': enteredReply,
          'userEmail': user.email,
          'sentAt':
              DateFormat.yMd().add_jm().format(new DateTime.now()).toString(),
          // 'likes': 0,
        }),
      );
    } catch (error) {
      print(error);
    }
  }
}
