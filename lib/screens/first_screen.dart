import 'package:flutter/material.dart';

import './login_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Text(
              'Curiio',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 65,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          OutlineButton(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Login/Sign-Up',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
