import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_curiio/home/first_login.dart';
import 'package:login_curiio/home/menu_dashboard_layout.dart';
import '../auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// login widget for login_screen
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String pass = '';
  UserCredential user;
  bool _autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
    print('tt');
    if (value.isEmpty || value.length < 6)
      return "Enter a password 6+ chars long";
    else
      return null;
  }

  bool _isRegistered;
  String _userName;

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
                  controller: _emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: validatePass,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
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
                      try {
                        user = await _auth.signIn(email, pass);
                        if (user.user.uid != null) {
                          print("Login successful");
                          _userCheck(user.user.uid);
                        }
                        /*  */

                      } catch (e) {
                        print(e.toString());
                      }
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

  void _userCheck(userID) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      if (value.exists) {
        print("User exists");
        Map<String, dynamic> data = value.data();
        _userName = data['name'];
        _isRegistered = true;
        Navigator.of(context).pushNamed(MenuDashboardLayout.routeName);
      } else {
        print("user does not exists");
        _isRegistered = false;
        Navigator.of(context).pushNamed(FirstTimeLogin.routeName);
      }
    });
  }
}
