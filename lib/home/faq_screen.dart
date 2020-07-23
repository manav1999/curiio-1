import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import './faq_details.dart';
import '../models/faqs.dart' as faq;

class FAQScreen extends StatelessWidget {
  final List<String> titles = [
    "Question 1",
    "Question 2",
    "Question 3",
    "Question 4",
    "Question 5",
    "Question 6",
  ];

  final List<Widget> images = [
    Hero(
      tag: "Question 1",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.purple,
        ),
      ),
    ),
    Hero(
      tag: "Question 2",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.purple,
        ),
      ),
    ),
    Hero(
      tag: "Question 3",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.purple,
        ),
      ),
    ),
    Hero(
      tag: "Question 4",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.purple,
        ),
      ),
    ),
    Hero(
      tag: "Question 5",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.purple,
        ),
      ),
    ),
    Hero(
      tag: "Question 6",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.purple,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: VerticalCardPager(
                  titles: titles, // required
                  images: images, // required
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold), // optional
                  onSelectedItem: (index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FAQDetails(title: titles[index]),
                      ),
                    );
                  },
                  initialPage: 0, // optional
                  align: ALIGN.CENTER // optional
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
