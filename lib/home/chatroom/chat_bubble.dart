import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_curiio/models/message.dart';
import 'package:login_curiio/home/chatroom/messages.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:login_curiio/home/chatroom/expanded_message.dart';

final _cardColors = [
  Color(0xfff9e5dd),
  Color(0xff00a38e),
  Color(0xff8045dd),
  Color(0xff214e8b),
];

class ChatBubble extends StatefulWidget {
  final Message loadedMessage;

  ChatBubble(this.loadedMessage);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Random random = new Random();
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    User _currentUser = FirebaseAuth.instance.currentUser;
    // final bool isMe = _currentUser.email == widget.loadedMessage.userEmail;
    return InkWell(
      child: Column(
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            clipBehavior: Clip.antiAlias,
            child: Hero(
              tag: widget.loadedMessage.sentAt +
                  widget.loadedMessage.messageBody,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  color: _cardColors[2],
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.loadedMessage.messageBody,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Container()),
                          IconButton(
                            icon: _liked
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                //ADD FUNCTIONALITY TO STORE LIKE STATUS
                                // final url = 'https://curiio-dev-3cedd.firebaseio.com/chats/${widget.loadedMessage.id}.json';
                                _liked = !_liked;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'by ${widget.loadedMessage.userEmail.substring(0, widget.loadedMessage.userEmail.indexOf('@'))}',
                          ),
                          Text(
                            widget.loadedMessage.sentAt,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Container(),
          //       ),
          //       Text(
          //         widget.loadedMessage.sentAt,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (ctx) => ExpandMessage(loadedMessage: widget.loadedMessage),
        // ));
        Navigator.of(context).push(
          PageRouteBuilder(
              fullscreenDialog: true,
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (ctx, animation, secondaryAnimation) {
                return ExpandedMessage(loadedMessage: widget.loadedMessage);
              },
              transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }),
        );
      },
    );
  }
}
