import 'package:flutter/material.dart';

class FAQs {
  final List<String> _titles = [
    "Question 1",
    "Question 2",
    "Question 3",
    "Question 4",
    "Question 5",
    "Question 6",
  ];

  final List<Widget> _images = [
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

  List<String> get titles => [..._titles];

  List<Widget> get images => [..._images];
}
