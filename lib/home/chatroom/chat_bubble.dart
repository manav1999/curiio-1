import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:login_curiio/home/chatroom/messages.dart';

class ChatBubble extends StatelessWidget {
  final Message loadedMessage;

  ChatBubble(this.loadedMessage);

  @override
  Widget build(BuildContext context) {
    User _currentUser = FirebaseAuth.instance.currentUser;
    final bool isMe = _currentUser.email == loadedMessage.userId;
    return Container(
      decoration: BoxDecoration(
        color: isMe ? Colors.yellow : Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
          bottomLeft: isMe ? Radius.circular(27) : Radius.circular(0),
          bottomRight: isMe ? Radius.circular(0) : Radius.circular(27),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From ${loadedMessage.userId}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(loadedMessage.messageBody),
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Text(
                loadedMessage.sentAt,
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       '0 Replies',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //     Icon(Icons.reply),
          //   ],
          // )
        ],
      ),
    );
  }
}
