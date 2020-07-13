import 'package:flutter/material.dart';

class VideoLecturesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    final List<String> topics = [];
    return LectureTopic(media: _media);
  }
}

class LectureTopic extends StatelessWidget {
  const LectureTopic({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: _media.height,
      width: _media.width,
      child: ListView(
        children: <Widget>[
          Container(
            height: _media.height * 0.5,
            width: double.infinity,
            child: Card(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Puberty and Adolescence',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        width: double.infinity,
                        child: Image.asset('assets/images/people.png',
                            fit: BoxFit.fill),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum ')
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: _media.height * 0.23,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => Container(
                height: 100,
                width: 150,
                margin: const EdgeInsets.all(10),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${index + 1}. Puberty',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          width: double.infinity,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(child: Icon(Icons.play_circle_filled)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
