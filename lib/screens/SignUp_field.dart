//Sign up widget for sign_up_screen
import 'package:flutter/gestures.dart';
import 'package:login_curiio/screens/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String pass = '';
  String RePass = '';
  String error='';

  bool _checkBox = false;
  bool _autovalidate = false;

  void _togglePrivacyPolicy() {
    setState(() {
      _checkBox = !_checkBox;
    });
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
    if (value.isEmpty || value.length<6)
      return "Enter a password 6+ chars long";
    else
      return null;
  }

  String validateRePass(String value) {
    if (value.isEmpty)
      return "Re-type the Password";
    else if (value != pass)
      return "Passwords do not match";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Form(
            key: _formkey,
            autovalidate: _autovalidate,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
                TextFormField(
                  validator: validateRePass,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Re-enter Password"),
                  onChanged: (val) {
                    RePass = val;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: _checkBox
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      onPressed: () {
                        _togglePrivacyPolicy();
                      },
                    ),
                    SizedBox(width: 20),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'I agree with the ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://flutter.dev/');
                              })
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: _checkBox
                      ? () async {
                          if (_formkey.currentState.validate()) {
                            dynamic result= await _auth.registerWithEmailAndPassword(email, pass);
                            if(result==null){
                              setState(() {
                                error="Please supply valid email ";
                              });
                            }
                            else{
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Home(email);
                              }));
                            }

                          } else {
                            setState(() {
                              _autovalidate = true;
                            });
                          }
                        }
                      : null,
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
