import 'package:flutter/material.dart';
import 'package:login_curiio/screens/first_screen.dart';
import 'auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Spacer(
            flex: 1,
          ),
          Text("Name : $name"),
          Spacer(
            flex: 1,
          ),
          Text("Email: $email"),
          RaisedButton(child: Text("logout"),
            onPressed: () {
              signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return FirstScreen();
              }), ModalRoute.withName('/'));
            },
          )
        ],
      ),
    );
  }
}
