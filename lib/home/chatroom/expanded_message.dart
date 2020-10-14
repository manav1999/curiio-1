import 'package:flutter/material.dart';
import 'package:login_curiio/models/message.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
import 'package:login_curiio/database/db_queries.dart' as db;

final _cardColors = [
  Color(0xfff9e5dd),
  Color(0xff00a38e),
  Color(0xff8045dd),
  Color(0xff214e8b),
];

class ExpandedMessage extends StatefulWidget {
  ExpandedMessage({this.loadedMessage});

  final Message loadedMessage;

  @override
  _ExpandedMessageState createState() => _ExpandedMessageState();
}

class _ExpandedMessageState extends State<ExpandedMessage> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();
  List<Message> loadedReplies = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _refreshReplies().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _sendReply() async {
    FocusScope.of(context).unfocus();
    await db.DBQueries()
        .addReplyToDB(widget.loadedMessage.messageId, _enteredMessage);
    _controller.clear();
  }

  Future<void> _refreshReplies() async {
    print('refreshing...');
    print(widget.loadedMessage.messageId);
    loadedReplies =
        await db.DBQueries().fetchReplies(widget.loadedMessage.messageId);
    // await _fetchReplies();
    print('loaded replies');
    print(loadedReplies.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _cardColors[2],
        elevation: 0,
        iconTheme: new IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Hero(
            tag: widget.loadedMessage.sentAt + widget.loadedMessage.messageBody,
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
                    Text(
                      'by ${widget.loadedMessage.userEmail.substring(0, widget.loadedMessage.userEmail.indexOf('@'))}',
                      style: TextStyle(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          widget.loadedMessage.sentAt,
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.7,
                      color: Colors.white,
                    ),
                    _isLoading
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: _cardColors[0],
                              ),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: _refreshReplies,
                              child: ListView.builder(
                                  itemCount: loadedReplies.length,
                                  itemBuilder: (ctx, index) =>
                                      ReplyCard(reply: loadedReplies[index])),
                            ),
                          ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLength: 200,
                            controller: _controller,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: 'Type here...',
                            ),
                            onChanged: (val) {
                              setState(() {
                                _enteredMessage = val;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.send),
                          onPressed: () {
                            return _enteredMessage.trim().isEmpty
                                ? null
                                : _sendReply();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReplyCard extends StatefulWidget {
  final Message reply;
  ReplyCard({this.reply});
  @override
  _ReplyCardState createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 20,
            ),
            Expanded(
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.reply.messageBody,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Expanded(child: Container()),
                          Text(
                            widget.reply.sentAt,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                              'by ${widget.reply.userEmail.substring(0, widget.reply.userEmail.indexOf('@'))}'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        // Container(
        //   margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        //   child: Row(
        //     children: [
        //       Expanded(child: Container()),
        //       Container(
        //         color: Colors.white,
        //         child: Text('${widget.reply.sentAt}'),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}

// Column(
//       children: [
//         Card(
//           margin: const EdgeInsets.all(10),
//           elevation: 4,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           //color: Colors.red,
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             height: 170,
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   height: 80,
//                   width: 80,
//                   child: CircleAvatar(
//                     backgroundColor: Theme.of(context).accentColor,
//                     radius: 40,
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(widget.reply.messageBody),
//                         Expanded(child: Container()),
//                         Row(
//                           children: [
//                             Expanded(child: Container()),
//                             Text(
//                                 'by ${widget.reply.userEmail.substring(0, widget.reply.userEmail.indexOf('@'))}'),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.fromLTRB(10, 2, 10, 10),
//           child: Row(
//             children: [
//               Expanded(child: Container()),
//               Text('${widget.reply.sentAt}'),
//             ],
//           ),
//         )
//       ],
//     );
