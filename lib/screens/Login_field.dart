import 'package:flutter/material.dart';
// login widget for login_screen
class Loginwidget extends StatefulWidget {
  @override
  _LoginwidgetState createState() => _LoginwidgetState();
}

class _LoginwidgetState extends State<Loginwidget> {
  final email = TextEditingController();
  final pass = TextEditingController();
  void submit(){
    final e=email.text;
    final p=pass.text;
    setState(() {
      print(e);
      print(p);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),controller: email,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),controller: pass,
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text('Login'),
            onPressed: submit,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
          ),
        ],
      ),
    );
  }
}
