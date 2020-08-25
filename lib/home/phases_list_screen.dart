import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_curiio/home/video_lectures_screen.dart';

class PhasesListScreen extends StatefulWidget {
  @override
  _PhasesListScreenState createState() => _PhasesListScreenState();
}

class _PhasesListScreenState extends State<PhasesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('levels')
            .orderBy('level_number')
            .snapshots(),
        builder: (ctx, levelSnapshot) {
          if (levelSnapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          final levelDocs = levelSnapshot.data.documents;
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: levelDocs.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => VideoLecturesScreen(),
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: Theme.of(context).accentColor,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Phase ${levelDocs[index]['level_number']}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${levelDocs[index]['level_description']}'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
