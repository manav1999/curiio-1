import 'package:flutter/material.dart';

// login widget for login_screen
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String pass = '';
  bool _autovalidate = false;
  final _formKey = GlobalKey<FormState>();

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePass(String value) {
    if (value.isEmpty || value.length<6)
      return "Enter a password 6+ chars long";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: validateEmail,
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                TextFormField(
                  validator: validatePass,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  onChanged: (val) {
                    pass = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      print(email);
                      print(pass);
                    } else {
                      setState(() {
                        _autovalidate = true;
                      });
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
