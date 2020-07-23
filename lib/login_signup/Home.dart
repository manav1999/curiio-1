import 'package:flutter/material.dart';
import 'package:login_curiio/home/first_screen.dart';
import '../auth.dart';
//nothing in here :)

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  String email = '';
  String name = '';
  Home(this.email, [this.name = 'null']);

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
          //Image.network(imageurl),
          RaisedButton(
            child: Text("logout"),
            onPressed: () {
              _auth.signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return FirstScreen();
                  },
                ),
                ModalRoute.withName('/'),
              );
            },
          )
        ],
      ),
    );
  }
}
