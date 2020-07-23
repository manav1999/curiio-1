import 'package:flutter/material.dart';

class FAQDetails extends StatelessWidget {
  final String title;

  FAQDetails({this.title});
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: _media.height * 0.2,
                  width: double.infinity,
                  child: Hero(
                    tag: title,
                    child: ClipRRect(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.purple,
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text('answer to above question'),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 20),
              child: InkWell(
                child: Icon(Icons.arrow_back, size: 30),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
