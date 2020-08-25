import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(12),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
              'dummy message dummy message dummy message dummy message dummy message dummy message dummy message '),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0 Replies',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(Icons.reply),
            ],
          )
        ],
      ),
    );
  }
}
